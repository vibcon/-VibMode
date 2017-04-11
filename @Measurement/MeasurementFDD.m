function [Frq,Mode,DampingRatio] = MeasurementFDD(obj,ModeNo,SingularvalueNo,varagin)
%    MeasurementFDD��Ƶ��ֽⷨ(FDD)�������Ƶ�ʺ�����
%    [Frq,Mode,DampingRatio] = MeasurementFDD(obj,ModeNo)��
%    objΪĳһ����������Ӧ��ModeNoΪ��Ҫ�õ���������Ŀ����Ϊ�����������
%    FrqΪ����Ƶ�ʼ���λ�ã�ModeΪ���;���DampingRatioΪ���������������������Ϊ����������
%    [Frq,Mode,DampingRatio] = MeasurementFDD(obj,ModeNo,window,noverlap,nfft)
%    windowΪ��������noverlapΪ�źŵķֶ��ص����ȣ�nfftΪFFT�ĳ��ȣ���Ϊ��ѡ��������
%    window���������룬Ĭ�ϲ��ú�����������������Ϊ�źų��ȵ�1/8�����źŲ��ܱ�8������������Զ��ض��źš�
%    noverlap���������룬Ĭ�Ϸֶ��ص�����Ϊÿ���źų��ȵ�50%��
%    nfft���������룬Ĭ��ȡ256�ͷֶ��źų�����ӽ��Ľϴ��2���������еĽϴ�ֵ��
%    Copyright 2016 Vibcon Lab, Tongji University
narginchk(2,5)            % ���ٵ��������Ϊ2���������������Ϊ5�������б�����2���������������Ϊ��ѡ����
nargoutchk(3,3)           % ���ٵ��������Ϊ0���������������Ϊ2������Ϊ��ѡ����
Fs = obj.SamplingRate;          %ʱ�����ݵĲ���Ƶ��
switch nargin
    case 2                      %��ѡ��������ΪĬ����
        for i = 1:size(obj.ChannelData,2)-1
            for j = 1:size(obj.ChannelData,2)-1
                [PSD(i,j,:),F(i,j,:)]=cpsd(obj.ChannelData(1,i+1).Data,obj.ChannelData(1,j+1).Data,[],[],[],Fs);
            end
        end                     %�����ͨ��֮��Ļ�������
    case 3                      %��������ѡ�������ѡ������ΪĬ����
        for i = 1:size(obj.ChannelData,2)-1
            for j = 1:size(obj.ChannelData,2)-1
                [PSD(i,j,:),F(i,j,:)]=cpsd(obj.ChannelData(1,i+1).Data,obj.ChannelData(1,j+1).Data,varagin{1},[],[],Fs);
            end
        end                     %�����ͨ��֮��Ļ�������
    case 4                      %���������źŷֶ��ص�������ѡ�������ѡ������ΪĬ����
        for i = 1:size(obj.ChannelData,2)-1
            for j = 1:size(obj.ChannelData,2)-1
                [PSD(i,j,:),F(i,j,:)]=cpsd(obj.ChannelData(1,i+1).Data,obj.ChannelData(1,j+1).Data,varagin{1},varagin{2},[],Fs);
            end
        end                     %�����ͨ��֮��Ļ�������
    case 5                      %���п�ѡ��������Ϊ��ѡ
        for i = 1:size(obj.ChannelData,2)-1
            for j = 1:size(obj.ChannelData,2)-1
                [PSD(i,j,:),F(i,j,:)]=cpsd(obj.ChannelData(1,i+1).Data,obj.ChannelData(1,j+1).Data,varagin{1},varagin{2},varagin{3},Fs);
            end
        end                     %�����ͨ��֮��Ļ�������
end
Frequencies(:,1) = F(1,1,:);
for i = 1:size(PSD,3)
    for j = 1:SingularvalueNo
        [u,s,~] = svd(PSD(:,:,i));         %�Թ����׾����������ֵ�ֽ�
        SingularValue(j,i) = s(j,j);       %��������ֵ
        SingularMatrix(:,:,i) = s;
    end
end

%�������ֵ��Ƶ�ʵı仯����
for i = 1:SingularvalueNo
    figure
    plot(Frequencies,mag2db(SingularValue(i,:)));
    hold on
end
xlabel('Frequency (Hz)');
ylabel(' Singular values of the PSD matrix (db)');

%�ҳ�����ֵ�����еķ�ֵ�ͷ�ֵ��

Fp = [];
k = 0;
    y = mag2db(SingularValue(1,:));             %һ������ֵ����
while k ~= ModeNo
    A = getrect;                                %��ͼ���Ͽ�ѡ��ֵ��Χ
    [~,P1] = min(abs(Frequencies-A(1)));
    [~,P2] = min(abs(Frequencies-(A(1)+A(3))));
    [~,B] = max(y(P1:P2));
    Max = B+P1-1;                               %�ҵ���ֵ���Ӧ��Ƶ��λ��
    scatter(Frequencies(Max),y(Max),'MarkerEdgeColor'...
        ,'b','MarkerFaceColor','b')             %��ѡ���ķ�ֵ����б�ǣ���ɫ��
    pause;key=get(gcf,'CurrentKey');
    Fp(end+1,:)=[Max,Frequencies(Max)];
    if strcmp(key,'space')                      %���ո��ȷ�϶Ը÷�ֵ���ѡȡ
        k=k+1;
        scatter(Frequencies(Max),y(Max),'MarkerEdgeColor'...
            ,'g','MarkerFaceColor','g')          %���Ѿ�ȷ��ѡȡ�ķ�ֵ������ɫ���
    else                                        %���ո����������ȡ���Ѿ�ѡ���ķ�ֵ��
        Fp(end,:)=[];
        scatter(Frequencies(Max),y(Max),'MarkerEdgeColor',...
            'r','MarkerFaceColor','r');          % ��ȡ��ѡ���ķ�ֵ����Ϊ��ɫ
    end
end

%���Ѿ�ѡ��õķ�ֵ���������

[~,Sr]=sort(Fp(:,2));
Fp=Fp(Sr,:);
clf
plot(Frequencies,mag2db(SingularValue))                %���»���һ������ֵ����ͼ
hold on
xlabel('Frequency (Hz)')
ylabel('1st Singular values of the PSD matrix (db)')
for I=1:size(Fp,1)
    scatter(Fp(I,2),y(Fp(I,1)),'MarkerEdgeColor',...
        'g','MarkerFaceColor','g')
    text(Fp(I,2), y(Fp(I,1))*1.05, mat2str(I))        %����������õķ�ֵ�������������ͼ���ϼ���˵��
end
%�ڼ�ֵ�㴦��������
Frq = Fp(:,2);
save NaturalFrequency.mat Frq
for i = 1:ModeNo
    [ug, ~, ~] = svd(PSD(:,:,Fp(i,1)));
    Mode(:,i) = ug(:,1);                       %��������
end
save Mode.mat Mode
%��FSDD���������
for i = 1:ModeNo
    for j = 1:size(PSD,3)
        EPSD(j,i) = SingularMatrix(i,i,j); %������ǿPSD
    end
end
for j = 1:ModeNo
    A_tem(:,1,j) = EPSD(:,j);
    A_tem(:,2,j) = Frequencies.*EPSD(:,j);
    A_tem(:,3,j) = ones(size(PSD,3),1);
    b_tem(:,j) = -(Frequencies.^2).*EPSD(:,j);
    x_tem(:,j) = A_tem(:,:,j)\b_tem(:,j);
    DampingRatio(j) = sqrt(1-(x_tem(2,j))^2/(4*x_tem(1,j)));
end
EEPSD = A_tem(:,:,1)*x_tem(:,1);
save DampingRatio.mat DampingRatio
plot(Frequencies,mag2db(EEPSD));
end

function [Frq,Mode,DampingRatio,varargout] = MeasurementFDD(obj,ModeNo,varargin)
%    MeasurementFDD��Ƶ��ֽⷨ(FDD)ʶ��ϵͳģ̬����
%    [Frq,Mode,DampingRatio] = MeasurementFDD(obj,ModeNo)��
%    objΪĳһ����������Ӧ��ModeNoΪ��Ҫ�õ���������Ŀ����Ϊ�����������
%    FrqΪ����Ƶ�ʼ���λ�ã�ModeΪ���;���DampingRatioΪ���������������������Ϊ����������
%    [Frq,Mode,DampingRatio,EFrq] = MeasurementFDD(obj,ModeNo,window,noverlap,nfft)
%    EFrqΪ��Ƶ��ռ���ֽ�õ�������Ƶ�ʣ�Ϊ��ѡ�����
%    windowΪ��������noverlapΪ�źŵķֶ��ص����ȣ�nfftΪFFT�ĳ��ȣ���Ϊ��ѡ��������
%    window���������룬Ĭ�ϲ��ú�����������������Ϊ�źų��ȵ�1/8�����źŲ��ܱ�8������������Զ��ض��źš�
%    noverlap���������룬Ĭ�Ϸֶ��ص�����Ϊÿ���źų��ȵ�50%��
%    nfft���������룬Ĭ��ȡ256�ͷֶ��źų�����ӽ��Ľϴ��2���������еĽϴ�ֵ��
%    Copyright 2016 Vibcon Lab, Tongji University

%% ������������Ŀ
narginchk(2,5)            % ���ٵ��������Ϊ2���������������Ϊ5�������б�����2���������������Ϊ��ѡ����
nargoutchk(3,4)           % ���ٵ��������Ϊ3���������������Ϊ4��
Fs = obj.SamplingRate;          %ʱ�����ݵĲ���Ƶ��

%% �����ͨ����Ӧ�Ļ�������
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
                [PSD(i,j,:),F(i,j,:)]=cpsd(obj.ChannelData(1,i+1).Data,obj.ChannelData(1,j+1).Data,varargin{1},[],[],Fs);
            end
        end                     %�����ͨ��֮��Ļ�������
    case 4                      %���������źŷֶ��ص�������ѡ�������ѡ������ΪĬ����
        for i = 1:size(obj.ChannelData,2)-1
            for j = 1:size(obj.ChannelData,2)-1
                [PSD(i,j,:),F(i,j,:)]=cpsd(obj.ChannelData(1,i+1).Data,obj.ChannelData(1,j+1).Data,varargin{1},varargin{2},[],Fs);
            end
        end                     %�����ͨ��֮��Ļ�������
    case 5                      %���п�ѡ��������Ϊ��ѡ
        for i = 1:size(obj.ChannelData,2)-1
            for j = 1:size(obj.ChannelData,2)-1
                [PSD(i,j,:),F(i,j,:)]=cpsd(obj.ChannelData(1,i+1).Data,obj.ChannelData(1,j+1).Data,varargin{1},varargin{2},varargin{3},Fs);
            end
        end                     %�����ͨ��֮��Ļ�������
end
Frequencies(:,1) = F(1,1,:);
for i = 1:size(PSD,3)
    for j = 1:size(PSD,2)
        [~,s,~] = svd(PSD(:,:,i));         %�Թ����׾����������ֵ�ֽ�
        SingularValue(j,i) = s(j,j);       %��������ֵ
    end
end

%% �������ֵ��Ƶ�ʵı仯����
figure(1)
legend_str = cell(1,size(PSD,2));
for i = 1:size(PSD,2)
    figure(1)
    plot(Frequencies,mag2db(SingularValue(i,:)));
    hold on
    legend_str{i} = [num2str(i),'th singularvalue'];
end
xlabel('Frequency (Hz)');
ylabel('Singular values of the PSD matrix (db)');
legend(legend_str)

%% ����ƽ������ֵ����
AveSingularValue = (ones(1,size(PSD,2))*SingularValue)/size(PSD,2);
figure(2)
plot(Frequencies,mag2db(AveSingularValue));
hold on
xlabel('Frequency (Hz)');
ylabel('Average Singular values of the PSD matrix (db)');

%% �ҳ�ƽ������ֵ�����еķ�ֵ�ͷ�ֵ��
disp('Please use the crosshair box to select the peak point, and press space key for next peak point')
Fp = [];
k = 0;
    y = mag2db(AveSingularValue);                %ƽ������ֵ����
while k ~= ModeNo
    A = getrect(figure(2));                      %��ͼ���Ͽ�ѡ��ֵ��Χ
    [~,P1] = min(abs(Frequencies-A(1)));
    [~,P2] = min(abs(Frequencies-(A(1)+A(3))));
    [~,B] = max(y(P1:P2));
    Max = B+P1-1;                                %�ҵ���ֵ���Ӧ��Ƶ��λ��
    scatter(Frequencies(Max),y(Max),'MarkerEdgeColor'...
        ,'b','MarkerFaceColor','b')              %��ѡ���ķ�ֵ����б�ǣ���ɫ��
    pause;key=get(gcf,'CurrentKey');
    Fp(end+1,:)=[Max,Frequencies(Max)];
    if strcmp(key,'space')                       %���ո��ȷ�϶Ը÷�ֵ���ѡȡ
        k=k+1;
        scatter(Frequencies(Max),y(Max),'MarkerEdgeColor'...
            ,'g','MarkerFaceColor','g')          %���Ѿ�ȷ��ѡȡ�ķ�ֵ������ɫ���
    else                                         %���ո����������ȡ���Ѿ�ѡ���ķ�ֵ��
        Fp(end,:)=[];
        scatter(Frequencies(Max),y(Max),'MarkerEdgeColor',...
            'r','MarkerFaceColor','r');          % ��ȡ��ѡ���ķ�ֵ����Ϊ��ɫ
    end
end

%% ���Ѿ�ѡ��õķ�ֵ���������
[~,Sr]=sort(Fp(:,2));
Fp=Fp(Sr,:);
clf
plot(Frequencies,mag2db(AveSingularValue))            %���»���ƽ������ֵ����ͼ
hold on
xlabel('Frequency (Hz)')
ylabel('Singular values of the PSD matrix (db)')
for I=1:size(Fp,1)
    scatter(Fp(I,2),y(Fp(I,1)),'MarkerEdgeColor',...
        'g','MarkerFaceColor','g')
    text(Fp(I,2), y(Fp(I,1))*1.05, mat2str(I))        %����������õķ�ֵ�������������ͼ���ϼ���˵��
end
Frq = Fp(:,2);

%% �ڼ�ֵ�㴦��������
for i = 1:ModeNo
    [ug, ~, ~] = svd(PSD(:,:,Fp(i,1)));
    Mode(:,i) = real(ug(:,1));                       %��������
    Mode(:,i) = Mode(:,i)./Mode(1,i);                %�淶������
end
save Mode.mat Mode

%% ��������ʾ��ͼ
nDOF = size(Mode,1);                                 %���ɶ���Ŀ
figure(3)
legend_str = cell(1,ModeNo);
for i = 1:ModeNo
    plot(Mode(:,i),1:nDOF,'linewidth',2,'Marker','.','Markersize',30);
    hold on
    legend_str{i} = [num2str(i),'th mode'];
end
grid on
set(gca,'ytick',0:1:nDOF);
legend(legend_str);
ylabel('Degree of Freedom');title('Diagram of the Mode');

%% ������ǿ�����׺���
for i = 1:ModeNo
    for j = 1:size(PSD,3)
        [ug,~,~] = svd(PSD(:,:,Fp(i,1)));
        EPSD(j,i) = ug(:,1)'*PSD(:,:,j)*ug(:,1); %������ǿPSD
    end
end
%% ������С����������ṹ�����

for i= 1:ModeNo
    bandwidth(:,i) = Frequencies(Fp(i,1)-10:Fp(i,1)+10);    %�γɼ����������ȵĴ������
end
for j = 1:ModeNo
    A_tem(:,1,j) = EPSD(Fp(i,1)-10:Fp(i,1)+10,j);
    A_tem(:,2,j) = bandwidth(:,j).*EPSD(Fp(i,1)-10:Fp(i,1)+10,j);
    A_tem(:,3,j) = ones(21,1);
    b_tem(:,j) = -(bandwidth(:,j).^2).*EPSD(Fp(i,1)-10:Fp(i,1)+10,j);
    x_tem(:,j) = A_tem(:,:,j)\b_tem(:,j);
    DampingRatio(j) = real(sqrt(1-(x_tem(2,j))^2/(4*x_tem(1,j))));
    EFrq(j) = sqrt(x_tem(1,j));
end
switch nargout
    case 4
        varargout = EFrq;
end
end

function [Frq,Mode,DampingRatio] = MeasurementFDD(obj,ModeNo,SingularvalueNo,varagin)
%    MeasurementFDD用频域分解法(FDD)求解自振频率和振型
%    [Frq,Mode,DampingRatio] = MeasurementFDD(obj,ModeNo)。
%    obj为某一工况的振动响应，ModeNo为需要得到的振型数目，均为必须的输入量
%    Frq为自振频率及其位置，Mode为振型矩阵，DampingRatio为各阶振型阻尼比向量，均为必须的输出量
%    [Frq,Mode,DampingRatio] = MeasurementFDD(obj,ModeNo,window,noverlap,nfft)
%    window为窗函数，noverlap为信号的分段重叠长度，nfft为FFT的长度，均为可选输入量。
%    window项若无输入，默认采用汉明窗，窗函数长度为信号长度的1/8，若信号不能被8整除，程序会自动截断信号。
%    noverlap项若无输入，默认分段重叠长度为每段信号长度的50%。
%    nfft项若无输入，默认取256和分段信号长度最接近的较大的2次幂整数中的较大值。
%    Copyright 2016 Vibcon Lab, Tongji University
narginchk(2,5)            % 最少的输入变量为2个，最多的输入变量为5个，其中必须有2个输入变量，其他为可选变量
nargoutchk(3,3)           % 最少的输出变量为0个，最多的输出变量为2个，均为可选变量
Fs = obj.SamplingRate;          %时程数据的采样频率
switch nargin
    case 2                      %可选输入量均为默认量
        for i = 1:size(obj.ChannelData,2)-1
            for j = 1:size(obj.ChannelData,2)-1
                [PSD(i,j,:),F(i,j,:)]=cpsd(obj.ChannelData(1,i+1).Data,obj.ChannelData(1,j+1).Data,[],[],[],Fs);
            end
        end                     %计算各通道之间的互功率谱
    case 3                      %窗函数自选，其余可选输入量为默认量
        for i = 1:size(obj.ChannelData,2)-1
            for j = 1:size(obj.ChannelData,2)-1
                [PSD(i,j,:),F(i,j,:)]=cpsd(obj.ChannelData(1,i+1).Data,obj.ChannelData(1,j+1).Data,varagin{1},[],[],Fs);
            end
        end                     %计算各通道之间的互功率谱
    case 4                      %窗函数，信号分段重叠长度自选，其余可选输入量为默认量
        for i = 1:size(obj.ChannelData,2)-1
            for j = 1:size(obj.ChannelData,2)-1
                [PSD(i,j,:),F(i,j,:)]=cpsd(obj.ChannelData(1,i+1).Data,obj.ChannelData(1,j+1).Data,varagin{1},varagin{2},[],Fs);
            end
        end                     %计算各通道之间的互功率谱
    case 5                      %所有可选输入量均为自选
        for i = 1:size(obj.ChannelData,2)-1
            for j = 1:size(obj.ChannelData,2)-1
                [PSD(i,j,:),F(i,j,:)]=cpsd(obj.ChannelData(1,i+1).Data,obj.ChannelData(1,j+1).Data,varagin{1},varagin{2},varagin{3},Fs);
            end
        end                     %计算各通道之间的互功率谱
end
Frequencies(:,1) = F(1,1,:);
for i = 1:size(PSD,3)
    for j = 1:SingularvalueNo
        [u,s,~] = svd(PSD(:,:,i));         %对功率谱矩阵进行奇异值分解
        SingularValue(j,i) = s(j,j);       %计算奇异值
        SingularMatrix(:,:,i) = s;
    end
end

%绘出奇异值随频率的变化曲线
for i = 1:SingularvalueNo
    figure
    plot(Frequencies,mag2db(SingularValue(i,:)));
    hold on
end
xlabel('Frequency (Hz)');
ylabel(' Singular values of the PSD matrix (db)');

%找出奇异值曲线中的峰值和峰值点

Fp = [];
k = 0;
    y = mag2db(SingularValue(1,:));             %一阶奇异值曲线
while k ~= ModeNo
    A = getrect;                                %在图像上框选峰值范围
    [~,P1] = min(abs(Frequencies-A(1)));
    [~,P2] = min(abs(Frequencies-(A(1)+A(3))));
    [~,B] = max(y(P1:P2));
    Max = B+P1-1;                               %找到峰值点对应的频率位置
    scatter(Frequencies(Max),y(Max),'MarkerEdgeColor'...
        ,'b','MarkerFaceColor','b')             %对选定的峰值点进行标记（蓝色）
    pause;key=get(gcf,'CurrentKey');
    Fp(end+1,:)=[Max,Frequencies(Max)];
    if strcmp(key,'space')                      %按空格键确认对该峰值点的选取
        k=k+1;
        scatter(Frequencies(Max),y(Max),'MarkerEdgeColor'...
            ,'g','MarkerFaceColor','g')          %将已经确认选取的峰值点用绿色标记
    else                                        %按空格键外的任意键取消已经选定的峰值点
        Fp(end,:)=[];
        scatter(Frequencies(Max),y(Max),'MarkerEdgeColor',...
            'r','MarkerFaceColor','r');          % 将取消选定的峰值点标记为红色
    end
end

%对已经选择好的峰值点进行排序

[~,Sr]=sort(Fp(:,2));
Fp=Fp(Sr,:);
clf
plot(Frequencies,mag2db(SingularValue))                %重新绘制一阶奇异值曲线图
hold on
xlabel('Frequency (Hz)')
ylabel('1st Singular values of the PSD matrix (db)')
for I=1:size(Fp,1)
    scatter(Fp(I,2),y(Fp(I,1)),'MarkerEdgeColor',...
        'g','MarkerFaceColor','g')
    text(Fp(I,2), y(Fp(I,1))*1.05, mat2str(I))        %将重新排序好的峰值点用数字序号在图像上加以说明
end
%在极值点处计算振型
Frq = Fp(:,2);
save NaturalFrequency.mat Frq
for i = 1:ModeNo
    [ug, ~, ~] = svd(PSD(:,:,Fp(i,1)));
    Mode(:,i) = ug(:,1);                       %计算振型
end
save Mode.mat Mode
%用FSDD计算阻尼比
for i = 1:ModeNo
    for j = 1:size(PSD,3)
        EPSD(j,i) = SingularMatrix(i,i,j); %计算增强PSD
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

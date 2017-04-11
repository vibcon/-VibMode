function varagout = ChannelCoherence(obj1,obj2,varagin)
%   ChannelCoherence用韦尔奇方法计算两通道数据的相干函数
%   CoherenceFactor =ChannelCoherence(obj1,obj2),obj1,obj2分别为某通道振动信号，CoherenceFactor为两信号间的相干函数。
%   其中，obj1,obj2为必须的输入量
%   [CoherenceFactor,Frequency] = ChannelCoherence（obj1,obj2,window,noverlap,nfft）
%   Frequency为自功率谱频率向量；window为窗函数；noverlap为信号的分段重叠长度；nfft为FFT的长度。
%   CoherenceFactor，Frequency为可选输出量；window,noverlap,nfft为可选的输入量。
%   window项若无输入，默认采用汉明窗，窗函数长度为信号长度的1/8，若信号不能被8整除，程序会自动截断信号。
%   noverlap项若无输入，默认分段重叠长度为每段信号长度的50%。
%   nfft项若无输入，默认取256和分段信号长度最接近的较大的2次幂整数中的较大值。
%   Copyright 2016 Vibcon Lab, Tongji University
narginchk(2,5)            % 最少的输入变量为2个，最多的输入变量为5个，其中必须有2个输入变量，其他为可选变量
nargoutchk(0,2)           % 最少的输出变量为0个，最多的输出变量为2个，均为可选变量
fs = obj1.SamplingRate;                %信号采样频率(两信号采样频率应一致）
switch nargin
    case 2                            %可选输入量均为默认量
        [CoherenceFactor,Frequency]=mscohere(obj1.Data,obj2.Data,[],[],[],fs); %韦尔奇方法，输出两信号的相干函数，和频率向量
    case 3                            %窗函数自选，其余可选输入量为默认量
        [CoherenceFactor,Frequency]=mscohere(obj1.Data,obj2.Data,varagin{1},[],[],fs); %韦尔奇方法，输出两信号的相干函数，和频率向量
    case 4                            %窗函数，信号分段重叠长度自选，其余可选输入量为默认量
        [CoherenceFactor,Frequency]=mscohere(obj1.Data,obj2.Data,varagin{1},varagin{2},[],fs); %韦尔奇方法，输出两信号的相干函数，和频率向量
    case 5                            %所有可选输入量均为自选
        [CoherenceFactor,Frequency]=mscohere(obj1.Data,obj2.Data,varagin{1},varagin{2},varagin{3},fs); %韦尔奇方法，输出两信号的相干函数，和频率向量
end
switch nargout
    case 0                            %只输出相干函数图形
        plot(Frequency,CoherenceFactor);                    %绘出幅值谱
        xlabel('Frequency(Hz)');ylabel('Amplitude');        %坐标轴名称
        title('Coherence Function Estimate');               %图像名称
        grid on                                             %打开网格
    case 1                            %输出相干函数，并保存相干函数数据
        plot(Frequency,CoherenceFactor);                    %绘出幅值谱
        xlabel('Frequency(Hz)');ylabel('Amplitude');        %坐标轴名称
        title('Coherence Function Estimate');               %图像名称
        grid on                                             %打开网格
        save CoherenceFactor.mat CoherenceFactor            %保存相干函数数据
        varagout{1} = CoherenceFactor;
    case 2                            %输出相干函数，并保存相干函数及其频率向量数据
        plot(Frequency,CoherenceFactor);                %绘出幅值谱
        xlabel('Frequency(Hz)');ylabel('Amplitude');    %坐标轴名称
        title('Coherence Function Estimate');           %图像名称
        grid on                                         %打开网格
        save CoherenceFactor.mat CoherenceFactor Frequency  %保存相干函数数据
        varagout{1} = CoherenceFactor;varagout{2} = Frequency;
end
end
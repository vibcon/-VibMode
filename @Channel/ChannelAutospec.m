function varagout = ChannelAutospec(obj,varagin)
%   ChannelAutospec用韦尔奇方法计算某通道数据的自功率谱。
%   Autospectrum = ChannelAutospec(X),X为某通道振动信号，Autospectrum为该信号的自功率谱。
%   其中，X为必须的输入量。
%   [Autospectrum,Frequency] = ChannelAutospec（X,window,noverlap,nfft）
%   Frequency为自功率谱频率向量；window为窗函数；noverlap为信号的分段重叠长度；nfft为FFT的长度。
%   Autospectrum，Frequency为可选输出量；window,noverlap,nfft为可选的输入量。
%   window项若无输入，默认采用汉明窗，窗函数长度为信号长度的1/8，若信号不能被8整除，程序会自动截断信号。
%   noverlap项若无输入，默认分段重叠长度为每段信号长度的50%。
%   nfft项若无输入，默认取256和分段信号长度最接近的较大的2次幂整数中的较大值。
%   Copyright 2016 Vibcon Lab, Tongji University
narginchk(1,4)            % 最少的输入变量为1个，最多的输入变量为4个，其中必须有1个输入变量，其他为可选变量
nargoutchk(0,2)           % 最少的输出变量为0个，最多的输出变量为2个，均为可选变量
fs = obj.SamplingRate;                %信号采样频率
switch nargin
    case 1                            %可选输入量均为默认量
        [Autospectrum,Frequency]=pwelch(obj.Data,[],[],[],fs); %韦尔奇方法，输出信号的自功率谱，和频率向量
        Autospectrum = mag2db(Autospectrum);                   %将自功率谱幅值转换为分贝
    case 2                            %窗函数自选，其余可选输入量为默认量
        [Autospectrum,Frequency]=pwelch(obj.Data,varagin{1},[],[],fs); %韦尔奇方法，输出信号的自功率谱，和频率向量
        Autospectrum = mag2db(Autospectrum);                           %将自功率谱幅值转换为分贝
    case 3                            %窗函数，信号分段重叠长度自选，其余可选输入量为默认量
        [Autospectrum,Frequency]=pwelch(obj.Data,varagin{1},varagin{2},[],fs); %韦尔奇方法，输出信号的自功率谱，和频率向量
        Autospectrum = mag2db(Autospectrum);                                   %将自功率谱幅值转换为分贝
    case 4                            %所有可选输入量均为自选
        [Autospectrum,Frequency]=pwelch(obj.Data,varagin{1},varagin{2},varagin{3},fs); %韦尔奇方法，输出信号的自功率谱，和频率向量
        Autospectrum = mag2db(Autospectrum);                                           %将自功率谱幅值转换为分贝
end
switch nargout
    case 0                            %只输出自功率谱图形
        plot(Frequency,Autospectrum); %绘出自功率谱
        xlabel('Frequency(Hz)');ylabel('Amplitude（db）');  %坐标轴名称
        title('Power Spectral Density Estimate');           %图像名称
        grid on                                             %打开网格
    case 1                            %输出自功率谱，并保存自功率谱数据
        plot(Frequency,Autospectrum); %绘出自功率谱
        xlabel('Frequency(Hz)');ylabel('Amplitude（db）');  %坐标轴名称
        title('Power Spectral Density Estimate');           %图像名称
        grid on                                             %打开网格
        save Autospectrum.mat Autospectrum  %保存自功率谱数据
        varagout{1} = Autospectrum;
    case 2                            %输出自功率谱，并保存自功率谱及其频率向量数据
        plot(Frequency,Autospectrum); %绘出自功率谱
        xlabel('Frequency(Hz)');ylabel('Amplitude（db）');  %坐标轴名称
        title('Power Spectral Density Estimate');           %图像名称
        grid on                                             %打开网格
        save Autospectrum.mat Autospectrum Frequency  %保存自功率谱及其频率向量数据
        varagout{1} = Autospectrum;varagout{2} = Frequency;
end
end






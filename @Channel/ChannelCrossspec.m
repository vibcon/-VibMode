function varagout = ChannelCrossspec(obj1,obj2,varagin)
%   ChannelCrossspec用韦尔奇方法计算两通道数据的互功率谱
%   Crossspectrum =ChannelCrossspec(obj1,obj2),obj1,obj2分别为某通道振动信号，Crossspectrum为两信号间的互功率谱。
%   其中，obj1,obj2为必须的输入量
%   [Crossspectrum,Frequency] = ChannelAutospec（obj1,obj2,window,noverlap,nfft）
%   Frequency为互功率谱频率向量；window为窗函数；noverlap为信号的分段重叠长度；nfft为FFT的长度。
%   Crossspectrum，Frequency为可选输出量；window,noverlap,nfft为可选的输入量。
%   window项若无输入，默认采用汉明窗，窗函数长度为信号长度的1/8，若信号不能被8整除，程序会自动截断信号。
%   noverlap项若无输入，默认分段重叠长度为每段信号长度的50%。
%   nfft项若无输入，默认取256和分段信号长度最接近的较大的2次幂整数中的较大值。
%   Copyright 2016 Vibcon Lab, Tongji University
narginchk(2,5)            % 最少的输入变量为2个，最多的输入变量为5个，其中必须有2个输入变量，其他为可选变量
nargoutchk(0,2)           % 最少的输出变量为0个，最多的输出变量为2个，均为可选变量
fs = obj1.SamplingRate;                %信号采样频率(两信号采样频率应一致）
switch nargin
    case 2                            %可选输入量均为默认量
        [Crossspectrum,Frequency]=cpsd(obj1.Data,obj2.Data,[],[],[],fs); %韦尔奇方法，输出两信号的互功率谱，和频率向量
    case 3                            %窗函数自选，其余可选输入量为默认量
        [Crossspectrum,Frequency]=cpsd(obj1.Data,obj2.Data,varagin{1},[],[],fs); %韦尔奇方法，输出两信号的互功率谱，和频率向量
    case 4                            %窗函数，信号分段重叠长度自选，其余可选输入量为默认量
        [Crossspectrum,Frequency]=cpsd(obj1.Data,obj2.Data,varagin{1},varagin{2},[],fs); %韦尔奇方法，输出两信号的互功率谱，和频率向量
    case 5                            %所有可选输入量均为自选
        [Crossspectrum,Frequency]=cpsd(obj1.Data,obj2.Data,varagin{1},varagin{2},varagin{3},fs); %韦尔奇方法，输出两信号的互功率谱，和频率向量
end
switch nargout
    case 0                            %只输出互功率谱图形
        subplot(2,1,1);
        plot(Frequency,angle(Crossspectrum));               %绘出相位谱
        xlabel('Frequency(Hz)');ylabel('Phase');            %坐标轴名称
        title('Phase of Cross Power Spectral Density Estimate');   %图像名称
        grid on                                             %打开网格
        subplot(2,1,2);
        plot(Frequency,mag2db(abs(Crossspectrum)));         %绘出幅值谱
        xlabel('Frequency(Hz)');ylabel('Amplitude(db)');    %坐标轴名称
        title('Amplitude of Cross Power Spectral Density Estimate');%图像名称
        grid on                                             %打开网格
    case 1                            %输出互功率谱，并保存自功率谱数据
        subplot(2,1,1);
        plot(Frequency,angle(Crossspectrum));               %绘出相位谱
        xlabel('Frequency(Hz)');ylabel('Phase');            %坐标轴名称
        title('Phase of Cross Power Spectral Density Estimate');   %图像名称
        grid on                                             %打开网格
        subplot(2,1,2);
        plot(Frequency,mag2db(abs(Crossspectrum)));         %绘出幅值谱
        xlabel('Frequency(Hz)');ylabel('Amplitude(db)');    %坐标轴名称
        title('Amplitude of Cross Power Spectral Density Estimate');%图像名称
        grid on                                             %打开网格
        save Crossspectrum.mat Crossspectrum  %保存互功率谱数据
        varagout{1} = Crossspectrum;
    case 2                            %输出互功率谱，并保存互功率谱及其频率向量数据
        subplot(2,1,1);
        plot(Frequency,angle(Crossspectrum));               %绘出相位谱
        xlabel('Frequency(Hz)');ylabel('Phase');            %坐标轴名称
        title('Phase of Cross Power Spectral Density Estimate');   %图像名称
        grid on                                             %打开网格
        subplot(2,1,2);
        plot(Frequency,mag2db(abs(Crossspectrum)));         %绘出幅值谱
        xlabel('Frequency(Hz)');ylabel('Amplitude(db)');    %坐标轴名称
        title('Amplitude of Cross Power Spectral Density Estimate');%图像名称
        grid on                                             %打开网格
        save Crossspectrum.mat Crossspectrum                %保存互功率谱数据
        save Frequency.mat Frequency                        %保存频率向量数据
        varagout{1} = Crossspectrum;varagout{2} = Frequency;
end
end
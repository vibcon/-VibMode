 classdef Channel < handle
    properties (SetAccess=public)
        Name;                   %测试数据的名称
        SignalType;             %Input or Output
        Connected;              %是否是有效的数据 true or false       
        MeasurementType;        %Displacement, Velocity or Acceleration
        MeasurementUnit;        %单位
        SamplingRate;           %采样频率
        Factor = 1.0;           %放大系数
        Location;               %结点序号
        Xdirection;             %方向 true or false
        Ydirection;             %方向 true or false
        Zdirection;             %方向 true or false
        Reference;              %是否为参考点 true or false
        Data;                   %时程数据
    end
        
    methods
        function obj = Channel( )   %构造函数
            obj.Name = [];  
        end
        
        function fh = Plot(obj)    %绘出该通道的数据
            fh = figure;             
            step = size(obj.Data,1);
            interval = 1/obj.SamplingRate;
            time = 0:interval: (step-1)*interval;
            plot(time,obj.Data);
            title(['Channel Name: ' obj.Name]);
            xlabel('time (s)');
            ylabel([obj.MeasurementType ' (' obj.MeasurementUnit ')']);
            
        end
        
       %用韦尔奇方法计算两通道数据间的相干函数
       %输入量为两通道振动信号（obj1为输入信号，obj2为输出信号），输出量为两信号间相干函数
       %窗函数为海明窗
        function ft = Coherence(obj1,obj2)           
            ft=figure;
            fs = obj1.SamplingRate;                %信号采样频率(两信号采样频率应一致）
            [CoherenceFactor,Frequency]=mscohere(obj1.Data,obj2.Data,[],[],[],fs); %韦尔奇方法，输出两信号的相干函数，和频率向量
            plot(Frequency,CoherenceFactor);                  %绘出幅值谱
            xlabel('Frequency(Hz)');ylabel('Amplitude');      %坐标轴名称
            title('Coherence Function Estimate');             %图像名称
            grid on                                           %打开网格
        end
    end
 end
            
            
            
            
            
            
         
 
 
 
            
        
            
 
        
  
  
            
            
            
            
           
            
            
            
            
            
    
    
    
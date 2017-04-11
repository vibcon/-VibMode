 classdef Channel < handle
    properties (SetAccess=public)
        Name;                   %�������ݵ�����
        SignalType;             %Input or Output
        Connected;              %�Ƿ�����Ч������ true or false       
        MeasurementType;        %Displacement, Velocity or Acceleration
        MeasurementUnit;        %��λ
        SamplingRate;           %����Ƶ��
        Factor = 1.0;           %�Ŵ�ϵ��
        Location;               %������
        Xdirection;             %���� true or false
        Ydirection;             %���� true or false
        Zdirection;             %���� true or false
        Reference;              %�Ƿ�Ϊ�ο��� true or false
        Data;                   %ʱ������
    end
        
    methods
        function obj = Channel( )   %���캯��
            obj.Name = [];  
        end
        
        function fh = Plot(obj)    %�����ͨ��������
            fh = figure;             
            step = size(obj.Data,1);
            interval = 1/obj.SamplingRate;
            time = 0:interval: (step-1)*interval;
            plot(time,obj.Data);
            title(['Channel Name: ' obj.Name]);
            xlabel('time (s)');
            ylabel([obj.MeasurementType ' (' obj.MeasurementUnit ')']);
            
        end
        
       %��Τ���淽��������ͨ�����ݼ����ɺ���
       %������Ϊ��ͨ�����źţ�obj1Ϊ�����źţ�obj2Ϊ����źţ��������Ϊ���źż���ɺ���
       %������Ϊ������
        function ft = Coherence(obj1,obj2)           
            ft=figure;
            fs = obj1.SamplingRate;                %�źŲ���Ƶ��(���źŲ���Ƶ��Ӧһ�£�
            [CoherenceFactor,Frequency]=mscohere(obj1.Data,obj2.Data,[],[],[],fs); %Τ���淽����������źŵ���ɺ�������Ƶ������
            plot(Frequency,CoherenceFactor);                  %�����ֵ��
            xlabel('Frequency(Hz)');ylabel('Amplitude');      %����������
            title('Coherence Function Estimate');             %ͼ������
            grid on                                           %������
        end
    end
 end
            
            
            
            
            
            
         
 
 
 
            
        
            
 
        
  
  
            
            
            
            
           
            
            
            
            
            
    
    
    
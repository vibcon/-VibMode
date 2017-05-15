classdef Measurement < handle
    properties (SetAccess=public)
        Name;                   %�������ݵ�����
        Description;            %�������ݵ�˵��
        Connected;              %�Ƿ�����Ч������ true or false
        ChannelNo;              %ͨ������
        ChannelData;            %ͨ������
        SamplingRate;           %����Ƶ��
        
    end
    
    methods
        function obj=Measurement(channelno)
            obj.Name = [];
            obj.Description = [];
            obj.Connected = [];
            obj.ChannelNo = [];
            obj.SamplingRate = [];
            switch nargin
                case 1
                    ref(channelno) = Channel();
                    obj.ChannelData = ref;
                    obj.ChannelNo = channelno;
                otherwise
                    obj.ChannelData = Channel();
                    obj.ChannelNo = 1;
            end
        end
        
        function obj=Show(obj)
            disp(obj.Description)
        end
    end
end

    
    
    
    
    
    
    
    
    
    
    

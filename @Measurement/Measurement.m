classdef Measurement < handle
    properties (SetAccess=public)
        Name;                   %测试数据的名称
        Description;            %测试数据的说明
        Connected;              %是否是有效的数据 true or false
        ChannelNo;              %通道数量
        ChannelData;            %通道数据
        SamplingRate;           %采样频率
        
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

    
    
    
    
    
    
    
    
    
    
    

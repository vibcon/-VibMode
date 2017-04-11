classdef Experiment < handle           %句柄型类的对象     
    properties (SetAccess=public)
        Name = [];                   %试验名称
        Date = [];                   %试验日期
        Owner = [];                  %试验实施者
        Description = [];            %试验描述
        Location = [];               %试验地点  
        ExperimentType = [];         %试验类型
        StructureType = [];          %结构类型
        Material = [];               %结构材料
        ModelData = [];              %结构模型（内嵌对象）
        MeasurementNo = [];          %结构工况数量  
        MeasurementData = [];        %结构工况（内嵌对象）       
    end    
    
    methods
        function obj=Experiment(measurementno)    %构造函数
            obj.Name = [];
            obj.Date = [];
            obj.Owner = [];
            obj.Description = [];
            obj.ExperimentType = [];         
            obj.StructureType = [];          
            obj.Material = []; 
            obj.ModelData = Model();
            
            switch nargin  %对输入变量的数目进行判别
                case 1                    
                    temp(measurementno) = Measurement( );
                    obj.MeasurementData = temp;
                    obj.MeasurementNo = measurementno;
                otherwise 
                    obj.MeasurementData = Measurement( );  
                    obj.MeasurementNo = 1;
            end
        end
        
        function obj=Show(obj)
            disp(obj.Name)
            disp(obj.Description)
        end
        
            
        function obj = Set(obj,PropertyName,val)        %对变量属性进行赋值        
            switch PropertyName
                case 'Name'
                    obj.Name = val;
                case 'Date'
                    obj.Date = val;
                case 'Owner'
                    obj.Owner = val;
                case 'Description'
                    obj.Description = val;
                case 'Location'
                    obj.Location = val;
                case 'ExperimentType'
                    obj.ExperimentType = val;
                case 'StructureType'
                    obj.StructureType = val;
                case 'Material' 
                    obj.Material = val;
                case 'ModelData'
                    obj.ModelData = val;
                case 'MeasurementNo'
                    obj.MeasurementNo = val;
                case 'MeasurementData'
                    obj.MeasurementData = val;
                otherwise                                      
                    disp('No such property name')
            end
        end
    end
end

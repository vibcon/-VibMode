classdef Experiment < handle           %�������Ķ���     
    properties (SetAccess=public)
        Name = [];                   %��������
        Date = [];                   %��������
        Owner = [];                  %����ʵʩ��
        Description = [];            %��������
        Location = [];               %����ص�  
        ExperimentType = [];         %��������
        StructureType = [];          %�ṹ����
        Material = [];               %�ṹ����
        ModelData = [];              %�ṹģ�ͣ���Ƕ����
        MeasurementNo = [];          %�ṹ��������  
        MeasurementData = [];        %�ṹ��������Ƕ����       
    end    
    
    methods
        function obj=Experiment(measurementno)    %���캯��
            obj.Name = [];
            obj.Date = [];
            obj.Owner = [];
            obj.Description = [];
            obj.ExperimentType = [];         
            obj.StructureType = [];          
            obj.Material = []; 
            obj.ModelData = Model();
            
            switch nargin  %�������������Ŀ�����б�
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
        
            
        function obj = Set(obj,PropertyName,val)        %�Ա������Խ��и�ֵ        
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

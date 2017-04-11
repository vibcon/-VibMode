classdef Model < handle
    properties (SetAccess=public)
        Nodes;                   %结点     格式：编号  X坐标   Y坐标   Z坐标
        Lines;                   %线       格式：编号  结点编号1   结点编号2
        Linesec;                 %线横截面  格式：编号   宽          高（只表示矩形截面）
        Surfaces;                %面       格式：编号  结点编号1   结点编号2  结点编号3   结点编号4
        Surfacesec;              %面横截面  格式：编号     宽          高（只表示矩形截面）
        Constraint;              %约束边界  格式：编号  结点编号   X  Y  Z  UX  UY  UZ (1表示约束)
        NodeNo;                  %结点数
        LineNo;                  %线段数
        SurfaceNo;               %面的数
        Mass;                    %质量分布（未来修改）        
    end
        
    methods
        function obj=Model( ) 
            obj.Nodes = [] ;
            obj.Lines = [];
            obj.Linesec = [];
            obj.Surfaces = [];
            obj.Surfacesec = [];
            obj.Mass = [];
            
        end
        function obj=Show(obj)
            disp(obj.Nodes)
        end
    end
end    
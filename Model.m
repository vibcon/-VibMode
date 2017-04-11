classdef Model < handle
    properties (SetAccess=public)
        Nodes;                   %���     ��ʽ�����  X����   Y����   Z����
        Lines;                   %��       ��ʽ�����  �����1   �����2
        Linesec;                 %�ߺ����  ��ʽ�����   ��          �ߣ�ֻ��ʾ���ν��棩
        Surfaces;                %��       ��ʽ�����  �����1   �����2  �����3   �����4
        Surfacesec;              %������  ��ʽ�����     ��          �ߣ�ֻ��ʾ���ν��棩
        Constraint;              %Լ���߽�  ��ʽ�����  �����   X  Y  Z  UX  UY  UZ (1��ʾԼ��)
        NodeNo;                  %�����
        LineNo;                  %�߶���
        SurfaceNo;               %�����
        Mass;                    %�����ֲ���δ���޸ģ�        
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
function [ Frq,Mode,DampingRatio] = MeasurementSSID( obj,varargin)

%   MeasurementSSID 用随机子空间方法（SSID)识别系统模态参数
%   obj 为某一工况中的输入输出时程
%   varagin 可变输入量，可选择识别模型的阶数，不输入情况下，默认在1-10阶次内选择识别效果最佳的阶次
%   Frq 为自振频率及其位置，Mode为振型矩阵，DampingRatio为各阶振型阻尼比向量，均为必须的输出量
%   Copyright 2016 Vibcon Lab, Tongji University

%% 检查输入输出数目
narginchk(1,2)            % 最少的输入变量为1个，最多的输入变量为2个，其中1个必须输入变量，1个可选输入变量
nargoutchk(3,3)           % 最少的输出变量为3个，最多的输出变量为3个

%% 建立识别模型
dt = 1/obj.SamplingRate;                                      %时程采样间隔       
for i =1:size(obj.ChannelData,2)-1
     Response(:,i) = obj.ChannelData(1,i+1).Data;     %从工况中提取响应时程
end
Excitation = obj.ChannelData(1,1).Data*ones(1,size(obj.ChannelData,2)-1); %从工况中提取输入激励
Stru=iddata(Response,Excitation,dt);                  %建立待识别的数据模型

%% 用随机子空间方法识别离散时间状态空间模型
switch nargin
    case 1
        Model = n4sid(Stru,'best');   
    case 2
        Model = n4sid(Stru,varargin);
end

%% 识别系统的自振频率、模态和阻尼比
[V,D] = eig(Model.A);                             %对系统矩阵进行特征值分解
Eigenvalue = diag(log(diag(D)))./dt;            %求连续时间系统的特征值矩阵
Frq = abs(diag(Eigenvalue));                          %求振动结构的自振频率
DampingRatio = -real(diag(Eigenvalue))./Frq;            %求振动结构的阻尼比
Mode = abs(Model.C*V);                                    %求振动结构的振型
Frq = Frq/(2*pi);                                      

%% 舍弃共轭模态参数
Frq = Frq(1:2:end-1);
DampingRatio = DampingRatio(1:2:end-1);
Mode = Mode(:,1:2:end-1);

%% 对识别结果进行排序
[Frq,index] = sort(Frq);
DampingRatio = DampingRatio(index);
Mode = Mode(:,index);

%% 展示模态识别结果
nDOF = size(Mode,1);                                                %自由度
figure(1)
legend_str = cell(1,size(Mode,2));
for i = 1:size(Mode,2)
    Mode(:,i) = Mode(:,i)/Mode(1,i);                            %规范化振型
    plot(Mode(:,i),1:nDOF,'linewidth',2,'Marker','.','Markersize',30);
    hold on
    legend_str{i} = [num2str(i),'th mode'];
end
grid on
set(gca,'ytick',0:1:nDOF);
legend(legend_str);
ylabel('Degree of Freedom');title('Diagram of the Mode');
end







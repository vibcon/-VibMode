function [ Frq,Mode,DampingRatio] = MeasurementSSID( obj,varargin)

%   MeasurementSSID ������ӿռ䷽����SSID)ʶ��ϵͳģ̬����
%   obj Ϊĳһ�����е��������ʱ��
%   varagin �ɱ�����������ѡ��ʶ��ģ�͵Ľ���������������£�Ĭ����1-10�״���ѡ��ʶ��Ч����ѵĽ״�
%   Frq Ϊ����Ƶ�ʼ���λ�ã�ModeΪ���;���DampingRatioΪ���������������������Ϊ����������
%   Copyright 2016 Vibcon Lab, Tongji University

%% ������������Ŀ
narginchk(1,2)            % ���ٵ��������Ϊ1���������������Ϊ2��������1���������������1����ѡ�������
nargoutchk(3,3)           % ���ٵ��������Ϊ3���������������Ϊ3��

%% ����ʶ��ģ��
dt = 1/obj.SamplingRate;                                      %ʱ�̲������       
for i =1:size(obj.ChannelData,2)-1
     Response(:,i) = obj.ChannelData(1,i+1).Data;     %�ӹ�������ȡ��Ӧʱ��
end
Excitation = obj.ChannelData(1,1).Data*ones(1,size(obj.ChannelData,2)-1); %�ӹ�������ȡ���뼤��
Stru=iddata(Response,Excitation,dt);                  %������ʶ�������ģ��

%% ������ӿռ䷽��ʶ����ɢʱ��״̬�ռ�ģ��
switch nargin
    case 1
        Model = n4sid(Stru,'best');   
    case 2
        Model = n4sid(Stru,varargin);
end

%% ʶ��ϵͳ������Ƶ�ʡ�ģ̬�������
[V,D] = eig(Model.A);                             %��ϵͳ�����������ֵ�ֽ�
Eigenvalue = diag(log(diag(D)))./dt;            %������ʱ��ϵͳ������ֵ����
Frq = abs(diag(Eigenvalue));                          %���񶯽ṹ������Ƶ��
DampingRatio = -real(diag(Eigenvalue))./Frq;            %���񶯽ṹ�������
Mode = abs(Model.C*V);                                    %���񶯽ṹ������
Frq = Frq/(2*pi);                                      

%% ��������ģ̬����
Frq = Frq(1:2:end-1);
DampingRatio = DampingRatio(1:2:end-1);
Mode = Mode(:,1:2:end-1);

%% ��ʶ������������
[Frq,index] = sort(Frq);
DampingRatio = DampingRatio(index);
Mode = Mode(:,index);

%% չʾģ̬ʶ����
nDOF = size(Mode,1);                                                %���ɶ�
figure(1)
legend_str = cell(1,size(Mode,2));
for i = 1:size(Mode,2)
    Mode(:,i) = Mode(:,i)/Mode(1,i);                            %�淶������
    plot(Mode(:,i),1:nDOF,'linewidth',2,'Marker','.','Markersize',30);
    hold on
    legend_str{i} = [num2str(i),'th mode'];
end
grid on
set(gca,'ytick',0:1:nDOF);
legend(legend_str);
ylabel('Degree of Freedom');title('Diagram of the Mode');
end







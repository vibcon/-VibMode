clear 
clc

load TestModel.mat
figure(1)
test.MeasurementData(1,1).ChannelData(1,2).ChannelAutospec;  % ����ͨ���źŵ��Թ�����
figure(2)
ChannelCrossspec(test.MeasurementData(1,1).ChannelData(1,1),test.MeasurementData(1,1).ChannelData(1,2));  % ������ͨ���źŵĻ�������
figure(3)
ChannelFRF(test.MeasurementData(1,1).ChannelData(1,1),test.MeasurementData(1,1).ChannelData(1,2));  % ������ͨ���źŵ�Ƶ�캯��
figure(4)
ChannelCoherence(test.MeasurementData(1,1).ChannelData(1,1),test.MeasurementData(1,1).ChannelData(1,2));  % ������ͨ���źŵ���ɺ���

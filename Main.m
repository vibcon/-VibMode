clear 
clc

load TestModel.mat

test.MeasurementData(1,1).ChannelData(1,2).Autospec;  % ����ͨ���źŵ��Թ�����
Crossspec(test.MeasurementData(1,1).ChannelData(1,1),test.MeasurementData(1,1).ChannelData(1,2));  % ������ͨ���źŵĻ�������
FRF(test.MeasurementData(1,1).ChannelData(1,1),test.MeasurementData(1,1).ChannelData(1,2));  % ������ͨ���źŵ�Ƶ�캯��
Coherence(test.MeasurementData(1,1).ChannelData(1,1),test.MeasurementData(1,1).ChannelData(1,2));  % ������ͨ���źŵ���ɺ���

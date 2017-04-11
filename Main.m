clear 
clc

load TestModel.mat

test.MeasurementData(1,1).ChannelData(1,2).Autospec;  % 绘制通道信号的自功率谱
Crossspec(test.MeasurementData(1,1).ChannelData(1,1),test.MeasurementData(1,1).ChannelData(1,2));  % 绘制两通道信号的互功率谱
FRF(test.MeasurementData(1,1).ChannelData(1,1),test.MeasurementData(1,1).ChannelData(1,2));  % 绘制两通道信号的频响函数
Coherence(test.MeasurementData(1,1).ChannelData(1,1),test.MeasurementData(1,1).ChannelData(1,2));  % 绘制两通道信号的相干函数

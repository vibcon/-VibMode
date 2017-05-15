clear 
clc

load TestModel.mat
figure(1)
test.MeasurementData(1,1).ChannelData(1,2).ChannelAutospec;  % 绘制通道信号的自功率谱
figure(2)
ChannelCrossspec(test.MeasurementData(1,1).ChannelData(1,1),test.MeasurementData(1,1).ChannelData(1,2));  % 绘制两通道信号的互功率谱
figure(3)
ChannelFRF(test.MeasurementData(1,1).ChannelData(1,1),test.MeasurementData(1,1).ChannelData(1,2));  % 绘制两通道信号的频响函数
figure(4)
ChannelCoherence(test.MeasurementData(1,1).ChannelData(1,1),test.MeasurementData(1,1).ChannelData(1,2));  % 绘制两通道信号的相干函数

clear 
clc
load('TestModel.mat');
[Frq,Mode,DampingRatio] = MeasurementSSID(test.MeasurementData(1,1));
%[Frq,Mode,DampingRatio] = MeasurementSSID(test.MeasurementData(1,1),3);
%[Frq,Mode,DampingRatio] = MeasurementSSID(test.MeasurementData(1,1),1:10);
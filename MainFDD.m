clear 
clc
load('TestModel.mat');
 [Frq,Mode,DampingRatio] = MeasurementFDD(test.MeasurementData(1,1),5);
%[Frq,Mode,DampingRatio,EFrq] = MeasurementFDD(test.MeasurementData(1,1),5);
%[Frq,Mode,DampingRatio,EFrq] = MeasurementFDD(test.MeasurementData(1,1),5,blackman(1000));
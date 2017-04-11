clear all
clc

test=Experiment(2);

test.Set('Name','12层钢筋混凝土框架结构振动台模型试验');
test.Set('Date','Jun-16-2013');
test.Set('Owner','同济大学土木工程防灾国家重点实验室振动台试验室');
test.Set('Description', '国家自然科学基金重点项目资助（No. 50338040, 50025821）资助');
test.Set('Location', '同济大学土木工程防灾国家重点实验室振动台试验室');
test.Set('ExperimentType', '振动台模型试验');
test.Set('StructureType', '钢筋混凝土结构');
test.Set('Material', '钢筋混凝土');

test.ModelData.Nodes = [ 1  0  0  0; 
                         2  0  0  1;
                         3  0  0  2;
                         4  0  0  3;
                         5  0  0  4;
                         6  0  0  5;
                         7  0  0  6;
                         8  0  0  7;
                         9  0  0  8;
                         10  0  0  9;
                         11  0  0  10;
                         12  0  0  11;
                         13  0  0  12 ];
test.ModelData.Lines = [ 1  1  2;
                         2  2  3;
                         3  3  4;
                         4  4  5;
                         5  5  6;
                         6  6  7;
                         7  7  8;
                         8  8  9;
                         9  9  10;
                         10  10  11;
                         11  11  12;
                         12  12  13];
test.ModelData.Constraint = [ 1  1  1  1  1  1  1  1 ];  %表示固定端
test.ModelData.NodeNo = 2;
test.ModelData.LineNo = 1;

test.MeasurementData(1).Name = 'e1-s10h';
test.MeasurementData(1).Description = 'El Centro波（X单向）';
test.MeasurementData(1).Connected = true;
test.MeasurementData(1).ChannelNo = 8;
test.MeasurementData(1).SamplingRate = 50;

test.MeasurementData(1).ChannelData(8) = Channel();
for j=1:8
    test.MeasurementData(1).ChannelData(j).SignalType = 'Output';
    test.MeasurementData(1).ChannelData(j).Connected = true;
    test.MeasurementData(1).ChannelData(j).MeasurementType = 'Acceleration';
    test.MeasurementData(1).ChannelData(j).MeasurementUnit = 'm/s/s';
    test.MeasurementData(1).ChannelData(j).SamplingRate = 50;
    test.MeasurementData(1).ChannelData(j).Factor = 1;
    
    test.MeasurementData(1).ChannelData(j).Xdirection = true;
    test.MeasurementData(1).ChannelData(j).Ydirection = false;
    test.MeasurementData(1).ChannelData(j).Zdirection = false;
    test.MeasurementData(1).ChannelData(j).Reference = false;
end

test.MeasurementData(1).ChannelData(1).Name = 'elx'
test.MeasurementData(1).ChannelData(1).SignalType = 'Input';
test.MeasurementData(1).ChannelData(1).Location = 1;
test.MeasurementData(1).ChannelData(1).Factor = 0.090;
test.MeasurementData(1).ChannelData(1).Data = VarName1;

test.MeasurementData(1).ChannelData(2).Name = 'A1e1s1h'
test.MeasurementData(1).ChannelData(2).Location = 1;
test.MeasurementData(1).ChannelData(2).Data = VarName2;

test.MeasurementData(1).ChannelData(3).Name = 'A2e1s1h'
test.MeasurementData(1).ChannelData(3).Location = 3;
test.MeasurementData(1).ChannelData(3).Data = VarName3;

test.MeasurementData(1).ChannelData(4).Name = 'A3e1s1h'
test.MeasurementData(1).ChannelData(4).Location = 5;
test.MeasurementData(1).ChannelData(4).Data = VarName4;

test.MeasurementData(1).ChannelData(5).Name = 'A4e1s1h'
test.MeasurementData(1).ChannelData(5).Location = 7;
test.MeasurementData(1).ChannelData(5).Data = VarName5;

test.MeasurementData(1).ChannelData(6).Name = 'A5e1s1h'
test.MeasurementData(1).ChannelData(6).Location = 9;
test.MeasurementData(1).ChannelData(6).Data = VarName6;

test.MeasurementData(1).ChannelData(7).Name = 'A6e1s1h'
test.MeasurementData(1).ChannelData(7).Location = 11;
test.MeasurementData(1).ChannelData(7).Data = VarName7;

test.MeasurementData(1).ChannelData(8).Name = 'A7e1s1h'
test.MeasurementData(1).ChannelData(8).Location = 13;
test.MeasurementData(1).ChannelData(8).Data = VarName8;


test.MeasurementData(2).Name = 'e2-s10h';
test.MeasurementData(2).Description = 'El Centro波（X单向）';
test.MeasurementData(2).Connected = true;
test.MeasurementData(2).ChannelNo = 8;
test.MeasurementData(2).SamplingRate = 50;

test.MeasurementData(2).ChannelData(8) = Channel();
for j=1:8
    test.MeasurementData(2).ChannelData(j).SignalType = 'Output';
    test.MeasurementData(2).ChannelData(j).Connected = true;
    test.MeasurementData(2).ChannelData(j).MeasurementType = 'Acceleration';
    test.MeasurementData(2).ChannelData(j).MeasurementUnit = 'm/s/s';
    test.MeasurementData(2).ChannelData(j).SamplingRate = 50;
    test.MeasurementData(2).ChannelData(j).Factor = 1;
    
    test.MeasurementData(2).ChannelData(j).Xdirection = true;
    test.MeasurementData(2).ChannelData(j).Ydirection = false;
    test.MeasurementData(2).ChannelData(j).Zdirection = false;
    test.MeasurementData(2).ChannelData(j).Reference = false;
end

test.MeasurementData(2).ChannelData(1).Name = 'elx'
test.MeasurementData(2).ChannelData(1).SignalType = 'Input';
test.MeasurementData(2).ChannelData(1).Location = 1;
test.MeasurementData(2).ChannelData(1).Factor = 0.258;
test.MeasurementData(2).ChannelData(1).Data = VarName1;

test.MeasurementData(2).ChannelData(2).Name = 'A1e2s1h'
test.MeasurementData(2).ChannelData(2).Location = 1;
test.MeasurementData(2).ChannelData(2).Data = VarName2;

test.MeasurementData(2).ChannelData(3).Name = 'A2e2s1h'
test.MeasurementData(2).ChannelData(3).Location = 3;
test.MeasurementData(2).ChannelData(3).Data = VarName3;

test.MeasurementData(2).ChannelData(4).Name = 'A3e2s1h'
test.MeasurementData(2).ChannelData(4).Location = 5;
test.MeasurementData(2).ChannelData(4).Data = VarName4;

test.MeasurementData(2).ChannelData(5).Name = 'A4e2s1h'
test.MeasurementData(2).ChannelData(5).Location = 7;
test.MeasurementData(2).ChannelData(5).Data = VarName5;

test.MeasurementData(2).ChannelData(6).Name = 'A5e2s1h'
test.MeasurementData(2).ChannelData(6).Location = 9;
test.MeasurementData(2).ChannelData(6).Data = VarName6;

test.MeasurementData(2).ChannelData(7).Name = 'A6e2s1h'
test.MeasurementData(2).ChannelData(7).Location = 11;
test.MeasurementData(2).ChannelData(7).Data = VarName7;

test.MeasurementData(2).ChannelData(8).Name = 'A7e2s1h'
test.MeasurementData(2).ChannelData(8).Location = 13;
test.MeasurementData(2).ChannelData(8).Data = VarName8;

save TestExperiment.mat test
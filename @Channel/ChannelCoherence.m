function varagout = ChannelCoherence(obj1,obj2,varagin)
%   ChannelCoherence��Τ���淽��������ͨ�����ݵ���ɺ���
%   CoherenceFactor =ChannelCoherence(obj1,obj2),obj1,obj2�ֱ�Ϊĳͨ�����źţ�CoherenceFactorΪ���źż����ɺ�����
%   ���У�obj1,obj2Ϊ�����������
%   [CoherenceFactor,Frequency] = ChannelCoherence��obj1,obj2,window,noverlap,nfft��
%   FrequencyΪ�Թ�����Ƶ��������windowΪ��������noverlapΪ�źŵķֶ��ص����ȣ�nfftΪFFT�ĳ��ȡ�
%   CoherenceFactor��FrequencyΪ��ѡ�������window,noverlap,nfftΪ��ѡ����������
%   window���������룬Ĭ�ϲ��ú�����������������Ϊ�źų��ȵ�1/8�����źŲ��ܱ�8������������Զ��ض��źš�
%   noverlap���������룬Ĭ�Ϸֶ��ص�����Ϊÿ���źų��ȵ�50%��
%   nfft���������룬Ĭ��ȡ256�ͷֶ��źų�����ӽ��Ľϴ��2���������еĽϴ�ֵ��
%   Copyright 2016 Vibcon Lab, Tongji University
narginchk(2,5)            % ���ٵ��������Ϊ2���������������Ϊ5�������б�����2���������������Ϊ��ѡ����
nargoutchk(0,2)           % ���ٵ��������Ϊ0���������������Ϊ2������Ϊ��ѡ����
fs = obj1.SamplingRate;                %�źŲ���Ƶ��(���źŲ���Ƶ��Ӧһ�£�
switch nargin
    case 2                            %��ѡ��������ΪĬ����
        [CoherenceFactor,Frequency]=mscohere(obj1.Data,obj2.Data,[],[],[],fs); %Τ���淽����������źŵ���ɺ�������Ƶ������
    case 3                            %��������ѡ�������ѡ������ΪĬ����
        [CoherenceFactor,Frequency]=mscohere(obj1.Data,obj2.Data,varagin{1},[],[],fs); %Τ���淽����������źŵ���ɺ�������Ƶ������
    case 4                            %���������źŷֶ��ص�������ѡ�������ѡ������ΪĬ����
        [CoherenceFactor,Frequency]=mscohere(obj1.Data,obj2.Data,varagin{1},varagin{2},[],fs); %Τ���淽����������źŵ���ɺ�������Ƶ������
    case 5                            %���п�ѡ��������Ϊ��ѡ
        [CoherenceFactor,Frequency]=mscohere(obj1.Data,obj2.Data,varagin{1},varagin{2},varagin{3},fs); %Τ���淽����������źŵ���ɺ�������Ƶ������
end
switch nargout
    case 0                            %ֻ�����ɺ���ͼ��
        plot(Frequency,CoherenceFactor);                    %�����ֵ��
        xlabel('Frequency(Hz)');ylabel('Amplitude');        %����������
        title('Coherence Function Estimate');               %ͼ������
        grid on                                             %������
    case 1                            %�����ɺ�������������ɺ�������
        plot(Frequency,CoherenceFactor);                    %�����ֵ��
        xlabel('Frequency(Hz)');ylabel('Amplitude');        %����������
        title('Coherence Function Estimate');               %ͼ������
        grid on                                             %������
        save CoherenceFactor.mat CoherenceFactor            %������ɺ�������
        varagout{1} = CoherenceFactor;
    case 2                            %�����ɺ�������������ɺ�������Ƶ����������
        plot(Frequency,CoherenceFactor);                %�����ֵ��
        xlabel('Frequency(Hz)');ylabel('Amplitude');    %����������
        title('Coherence Function Estimate');           %ͼ������
        grid on                                         %������
        save CoherenceFactor.mat CoherenceFactor Frequency  %������ɺ�������
        varagout{1} = CoherenceFactor;varagout{2} = Frequency;
end
end
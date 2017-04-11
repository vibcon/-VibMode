function varagout = ChannelFRF(obj1,obj2,varagin)
%   ChannelFRF��Τ���淽��������ͨ�����ݵ�Ƶ�캯��
%   FrequencyResponse =ChannelFRF(obj1,obj2),obj1,obj2�ֱ�Ϊĳͨ�����źţ�FrequencyResponseΪ���źż��Ƶ�캯����
%   obj1,obj2Ϊ�����������������obj1Ϊ�����źţ�obj2Ϊ����źš�
%   [FrequencyResponse,Frequency] = ChannelFRF��obj1,obj2,window,noverlap,nfft��
%   FrequencyΪ�Թ�����Ƶ��������windowΪ��������noverlapΪ�źŵķֶ��ص����ȣ�nfftΪFFT�ĳ��ȡ�
%   FrequencyResponse��FrequencyΪ��ѡ�������window,noverlap,nfftΪ��ѡ����������
%   window���������룬Ĭ�ϲ��ú�����������������Ϊ�źų��ȵ�1/8�����źŲ��ܱ�8������������Զ��ض��źš�
%   noverlap���������룬Ĭ�Ϸֶ��ص�����Ϊÿ���źų��ȵ�50%��
%   nfft���������룬Ĭ��ȡ256�ͷֶ��źų�����ӽ��Ľϴ��2���������еĽϴ�ֵ��
%   Copyright 2016 Vibcon Lab, Tongji University
narginchk(2,5)            % ���ٵ��������Ϊ2���������������Ϊ5�������б�����2���������������Ϊ��ѡ����
nargoutchk(0,2)           % ���ٵ��������Ϊ0���������������Ϊ2������Ϊ��ѡ����
fs = obj1.SamplingRate;                %�źŲ���Ƶ��(���źŲ���Ƶ��Ӧһ�£�
switch nargin
    case 2                            %��ѡ��������ΪĬ����
        [FrequencyResponse,Frequency]=tfestimate(obj1.Data,obj2.Data,[],[],[],fs); %Τ���淽����������źŵ�Ƶ�캯������Ƶ������
    case 3                            %��������ѡ�������ѡ������ΪĬ����
        [FrequencyResponse,Frequency]=tfestimate(obj1.Data,obj2.Data,varagin{1},[],[],fs); %Τ���淽����������źŵ�Ƶ�캯������Ƶ������
    case 4                            %���������źŷֶ��ص�������ѡ�������ѡ������ΪĬ����
        [FrequencyResponse,Frequency]=tfestimate(obj1.Data,obj2.Data,varagin{1},varagin{2},[],fs); %Τ���淽����������źŵ�Ƶ�캯������Ƶ������
    case 5                            %���п�ѡ��������Ϊ��ѡ
        [FrequencyResponse,Frequency]=tfestimate(obj1.Data,obj2.Data,varagin{1},varagin{2},varagin{3},fs); %Τ���淽����������źŵ�Ƶ�캯������Ƶ������
end
switch nargout
    case 0                            %ֻ���Ƶ�캯��ͼ��
        subplot(2,1,1);
        plot(Frequency,angle(FrequencyResponse));               %�����λ��
        xlabel('Frequency(Hz)');ylabel('Phase');                %����������
        title('Phase of Frequency Response Function Estimate'); %ͼ������
        grid on                                                 %������
        subplot(2,1,2);
        plot(Frequency,mag2db(abs(FrequencyResponse)));         %�����ֵ��
        xlabel('Frequency(Hz)');ylabel('Amplitude(db)');        %����������
        title('Amplitude of Frequency Response Function Estimate');%ͼ������
        grid on                                                 %������
    case 1                            %���Ƶ�캯����������Ƶ�캯������
        subplot(2,1,1);
        plot(Frequency,angle(FrequencyResponse));               %�����λ��
        xlabel('Frequency(Hz)');ylabel('Phase');                %����������
        title('Phase of Frequency Response Function Estimate');   %ͼ������
        grid on                                                 %������
        subplot(2,1,2);
        plot(Frequency,mag2db(abs(FrequencyResponse)));         %�����ֵ��
        xlabel('Frequency(Hz)');ylabel('Amplitude(db)');        %����������
        title('Amplitude of Frequency Response Function Estimate');%ͼ������
        grid on                                                 %������
        save FrequencyResponse.mat FrequencyResponse            %����Ƶ�캯��������
        varagout{1} = FrequencyResponse;
    case 2                            %���Ƶ�캯��ͼ�Σ�������Ƶ�캯������Ƶ����������
        subplot(2,1,1);
        plot(Frequency,angle(FrequencyResponse));               %�����λ��
        xlabel('Frequency(Hz)');ylabel('Phase');                %����������
        title('Phase of Frequency Response Function Estimate');   %ͼ������
        grid on                                                 %������
        subplot(2,1,2);
        plot(Frequency,mag2db(abs(FrequencyResponse)));         %�����ֵ��
        xlabel('Frequency(Hz)');ylabel('Amplitude(db)');        %����������
        title('Amplitude of Frequency Response Function Estimate');%ͼ������
        grid on                                                 %������
        save FrequencyResponse.mat FrequencyResponse Frequency  %����Ƶ�캯��������
        varagout{1} = FrequencyResponse;varagout{2} = Frequency;
end
end
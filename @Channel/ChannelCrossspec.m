function varagout = ChannelCrossspec(obj1,obj2,varagin)
%   ChannelCrossspec��Τ���淽��������ͨ�����ݵĻ�������
%   Crossspectrum =ChannelCrossspec(obj1,obj2),obj1,obj2�ֱ�Ϊĳͨ�����źţ�CrossspectrumΪ���źż�Ļ������ס�
%   ���У�obj1,obj2Ϊ�����������
%   [Crossspectrum,Frequency] = ChannelAutospec��obj1,obj2,window,noverlap,nfft��
%   FrequencyΪ��������Ƶ��������windowΪ��������noverlapΪ�źŵķֶ��ص����ȣ�nfftΪFFT�ĳ��ȡ�
%   Crossspectrum��FrequencyΪ��ѡ�������window,noverlap,nfftΪ��ѡ����������
%   window���������룬Ĭ�ϲ��ú�����������������Ϊ�źų��ȵ�1/8�����źŲ��ܱ�8������������Զ��ض��źš�
%   noverlap���������룬Ĭ�Ϸֶ��ص�����Ϊÿ���źų��ȵ�50%��
%   nfft���������룬Ĭ��ȡ256�ͷֶ��źų�����ӽ��Ľϴ��2���������еĽϴ�ֵ��
%   Copyright 2016 Vibcon Lab, Tongji University
narginchk(2,5)            % ���ٵ��������Ϊ2���������������Ϊ5�������б�����2���������������Ϊ��ѡ����
nargoutchk(0,2)           % ���ٵ��������Ϊ0���������������Ϊ2������Ϊ��ѡ����
fs = obj1.SamplingRate;                %�źŲ���Ƶ��(���źŲ���Ƶ��Ӧһ�£�
switch nargin
    case 2                            %��ѡ��������ΪĬ����
        [Crossspectrum,Frequency]=cpsd(obj1.Data,obj2.Data,[],[],[],fs); %Τ���淽����������źŵĻ������ף���Ƶ������
    case 3                            %��������ѡ�������ѡ������ΪĬ����
        [Crossspectrum,Frequency]=cpsd(obj1.Data,obj2.Data,varagin{1},[],[],fs); %Τ���淽����������źŵĻ������ף���Ƶ������
    case 4                            %���������źŷֶ��ص�������ѡ�������ѡ������ΪĬ����
        [Crossspectrum,Frequency]=cpsd(obj1.Data,obj2.Data,varagin{1},varagin{2},[],fs); %Τ���淽����������źŵĻ������ף���Ƶ������
    case 5                            %���п�ѡ��������Ϊ��ѡ
        [Crossspectrum,Frequency]=cpsd(obj1.Data,obj2.Data,varagin{1},varagin{2},varagin{3},fs); %Τ���淽����������źŵĻ������ף���Ƶ������
end
switch nargout
    case 0                            %ֻ�����������ͼ��
        subplot(2,1,1);
        plot(Frequency,angle(Crossspectrum));               %�����λ��
        xlabel('Frequency(Hz)');ylabel('Phase');            %����������
        title('Phase of Cross Power Spectral Density Estimate');   %ͼ������
        grid on                                             %������
        subplot(2,1,2);
        plot(Frequency,mag2db(abs(Crossspectrum)));         %�����ֵ��
        xlabel('Frequency(Hz)');ylabel('Amplitude(db)');    %����������
        title('Amplitude of Cross Power Spectral Density Estimate');%ͼ������
        grid on                                             %������
    case 1                            %����������ף��������Թ���������
        subplot(2,1,1);
        plot(Frequency,angle(Crossspectrum));               %�����λ��
        xlabel('Frequency(Hz)');ylabel('Phase');            %����������
        title('Phase of Cross Power Spectral Density Estimate');   %ͼ������
        grid on                                             %������
        subplot(2,1,2);
        plot(Frequency,mag2db(abs(Crossspectrum)));         %�����ֵ��
        xlabel('Frequency(Hz)');ylabel('Amplitude(db)');    %����������
        title('Amplitude of Cross Power Spectral Density Estimate');%ͼ������
        grid on                                             %������
        save Crossspectrum.mat Crossspectrum  %���滥����������
        varagout{1} = Crossspectrum;
    case 2                            %����������ף������滥�����׼���Ƶ����������
        subplot(2,1,1);
        plot(Frequency,angle(Crossspectrum));               %�����λ��
        xlabel('Frequency(Hz)');ylabel('Phase');            %����������
        title('Phase of Cross Power Spectral Density Estimate');   %ͼ������
        grid on                                             %������
        subplot(2,1,2);
        plot(Frequency,mag2db(abs(Crossspectrum)));         %�����ֵ��
        xlabel('Frequency(Hz)');ylabel('Amplitude(db)');    %����������
        title('Amplitude of Cross Power Spectral Density Estimate');%ͼ������
        grid on                                             %������
        save Crossspectrum.mat Crossspectrum                %���滥����������
        save Frequency.mat Frequency                        %����Ƶ����������
        varagout{1} = Crossspectrum;varagout{2} = Frequency;
end
end
function varagout = ChannelAutospec(obj,varagin)
%   ChannelAutospec��Τ���淽������ĳͨ�����ݵ��Թ����ס�
%   Autospectrum = ChannelAutospec(X),XΪĳͨ�����źţ�AutospectrumΪ���źŵ��Թ����ס�
%   ���У�XΪ�������������
%   [Autospectrum,Frequency] = ChannelAutospec��X,window,noverlap,nfft��
%   FrequencyΪ�Թ�����Ƶ��������windowΪ��������noverlapΪ�źŵķֶ��ص����ȣ�nfftΪFFT�ĳ��ȡ�
%   Autospectrum��FrequencyΪ��ѡ�������window,noverlap,nfftΪ��ѡ����������
%   window���������룬Ĭ�ϲ��ú�����������������Ϊ�źų��ȵ�1/8�����źŲ��ܱ�8������������Զ��ض��źš�
%   noverlap���������룬Ĭ�Ϸֶ��ص�����Ϊÿ���źų��ȵ�50%��
%   nfft���������룬Ĭ��ȡ256�ͷֶ��źų�����ӽ��Ľϴ��2���������еĽϴ�ֵ��
%   Copyright 2016 Vibcon Lab, Tongji University
narginchk(1,4)            % ���ٵ��������Ϊ1���������������Ϊ4�������б�����1���������������Ϊ��ѡ����
nargoutchk(0,2)           % ���ٵ��������Ϊ0���������������Ϊ2������Ϊ��ѡ����
fs = obj.SamplingRate;                %�źŲ���Ƶ��
switch nargin
    case 1                            %��ѡ��������ΪĬ����
        [Autospectrum,Frequency]=pwelch(obj.Data,[],[],[],fs); %Τ���淽��������źŵ��Թ����ף���Ƶ������
        Autospectrum = mag2db(Autospectrum);                   %���Թ����׷�ֵת��Ϊ�ֱ�
    case 2                            %��������ѡ�������ѡ������ΪĬ����
        [Autospectrum,Frequency]=pwelch(obj.Data,varagin{1},[],[],fs); %Τ���淽��������źŵ��Թ����ף���Ƶ������
        Autospectrum = mag2db(Autospectrum);                           %���Թ����׷�ֵת��Ϊ�ֱ�
    case 3                            %���������źŷֶ��ص�������ѡ�������ѡ������ΪĬ����
        [Autospectrum,Frequency]=pwelch(obj.Data,varagin{1},varagin{2},[],fs); %Τ���淽��������źŵ��Թ����ף���Ƶ������
        Autospectrum = mag2db(Autospectrum);                                   %���Թ����׷�ֵת��Ϊ�ֱ�
    case 4                            %���п�ѡ��������Ϊ��ѡ
        [Autospectrum,Frequency]=pwelch(obj.Data,varagin{1},varagin{2},varagin{3},fs); %Τ���淽��������źŵ��Թ����ף���Ƶ������
        Autospectrum = mag2db(Autospectrum);                                           %���Թ����׷�ֵת��Ϊ�ֱ�
end
switch nargout
    case 0                            %ֻ����Թ�����ͼ��
        plot(Frequency,Autospectrum); %����Թ�����
        xlabel('Frequency(Hz)');ylabel('Amplitude��db��');  %����������
        title('Power Spectral Density Estimate');           %ͼ������
        grid on                                             %������
    case 1                            %����Թ����ף��������Թ���������
        plot(Frequency,Autospectrum); %����Թ�����
        xlabel('Frequency(Hz)');ylabel('Amplitude��db��');  %����������
        title('Power Spectral Density Estimate');           %ͼ������
        grid on                                             %������
        save Autospectrum.mat Autospectrum  %�����Թ���������
        varagout{1} = Autospectrum;
    case 2                            %����Թ����ף��������Թ����׼���Ƶ����������
        plot(Frequency,Autospectrum); %����Թ�����
        xlabel('Frequency(Hz)');ylabel('Amplitude��db��');  %����������
        title('Power Spectral Density Estimate');           %ͼ������
        grid on                                             %������
        save Autospectrum.mat Autospectrum Frequency  %�����Թ����׼���Ƶ����������
        varagout{1} = Autospectrum;varagout{2} = Frequency;
end
end






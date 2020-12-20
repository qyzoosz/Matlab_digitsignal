Fs = 80000; %���ò���Ƶ��Ϊ80k
T = 1/Fs;%���ò�������Ϊ1.25E-05s

%����ͨ���߽�Ƶ��Ϊ4k
%���������ֹƵ��Ϊ20k
%����ͨ�����˥��Ϊ0.5dB
%���������С˥��Ϊ45dB
Omega_pz = 4000; Alpha_p = 0.5;
Omega_sz = 20000;Alpha_s = 45;

%Ϊ����ʹ��������Ӧ���䷨����ɢ�������е��µ�Ƶ�׻������
%���÷����Ե�Ƶ��ѹ����������ģ��Ƶ��ѹ���ڡ���/T֮�䣬�ٽ���z�任���ɵõ�Ƶ����Ӧ
Omega_p = 2/T*tan((Omega_pz*T)/2); %�������ж�ͨ����ֹƵ�ʽ���Ƶ��ѹ��
Omega_s = 2/T*tan((Omega_sz*T)/2); %�������ж������ֹƵ�ʽ���Ƶ��ѹ��

%��ȡ�������µ��˲��������Լ�3dB��ֹƵ��
[N,Omega_c] = buttord(Omega_p,Omega_s,Alpha_p,Alpha_s,'s');
[Bz,Az] = butter(N,Omega_c,'s'); %��ȡ���ݺ����ķ��Ӻͷ�ĸϵ��
[Bw,Aw] = bilinear(Bz,Az,Fs); %����ϵ������˫���Ա任

[Ha,Wz] = freqs(Bw,Aw); %����ģ��Ƶ����Ӧ

%��ͼ
figure(1)
subplot(211);
plot(Wz,20*log10(abs(Ha))); 
title('��p = 4k Hz; ��s = 20k Hz;��p = 0.5dB; ��s = 45dB;  butterworth filter Amplitude Frequency response ');
xlabel('fs / kHz');ylabel('|H(a)| / dB');
hold on

subplot(212);
plot(Wz,angle(Ha));
title('butterworth filter Phase Frequency response');
xlabel('fs / kHz');ylabel('|H(a)| / dB');
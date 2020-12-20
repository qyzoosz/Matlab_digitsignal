clc;clear;
close all;

T=1;                %���ò�������Ϊ1
Fs = 1/T;           %���ò���Ƶ�ʣ���������һ��Ϊ1
Omega_pz = 0.2*pi;      %���ó�ʼ��ͨ���߽�Ƶ��
Omega_sz = 0.3*pi;      %���ó�ʼ�������ֹƵ��
Alpha_p = 1;                %����ͨ�����˥��Ϊ1dB
Alpha_s = 15;               %���������С˥��Ϊ15dB

%Ϊ�˱�����ʹ��������Ӧ���䷨һ�������ڦ� = ��ʱ��Ƶ�׻������
%�����Ƶ�ʱ任��������ģ��Ƶ��ѹ��������/T֮�䣬�ٽ���z�任����
Omega_p = 2/T*tan(Omega_pz/2);        %���б任ʵ��Ƶ��ѹ��
Omega_s = 2/T*tan(Omega_sz/2);          %���б任ʵ��Ƶ��ѹ��

%��ȡ�˲����������˲�����3dB��ֹƵ��
[N,Omega_c] = buttord(Omega_p,Omega_s,Alpha_p,Alpha_s,'s');
[B,A] = butter(N,Omega_c,'s'); %��ȡ���ݺ����ķ��Ӻͷ�ĸϵ��
[Bz,Az] = bilinear(B,A,Fs); %����ϵ������˫���Ա任����ȡת�����zƽ��ϵ��
    
%k = 0:511;              
%fk = 14000/512:14000;
%wz = 2*pi*fk;

[Hz,wz] = freqs(Bz,Az);         %��ȡ�����˲���Ƶ����Ӧ
[Hk,Wk] =freqs(B,A);            %��ȡԭģ���˲���Ƶ����Ӧ


%��ͼ��ת��ΪdB��ʽ 
figure(1);
plot(wz,20*log10(abs(Hz)));   
hold on
plot(Wk,20*log10(abs(Hk)));
xlabel('f/k(Hz)');ylabel('|H|(f)/dB');
legend('�����˲���','��ͬ�����µ�ģ���˲���');
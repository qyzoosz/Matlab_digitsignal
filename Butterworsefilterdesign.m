Fs = 80000; %配置采样频率为80k
T = 1/Fs;%配置采样周期为1.25E-05s

%配置通带边界频率为4k
%配置阻带截止频率为20k
%配置通带最大衰减为0.5dB
%配置阻带最小衰减为45dB
Omega_pz = 4000; Alpha_p = 0.5;
Omega_sz = 20000;Alpha_s = 45;

%为避免使用脉冲响应不变法在离散化过程中导致的频谱混叠现象
%采用非线性的频率压缩，将整个模拟频率压缩在±Π/T之间，再进行z变换即可得到频率响应
Omega_p = 2/T*tan((Omega_pz*T)/2); %利用正切对通带截止频率进行频率压缩
Omega_s = 2/T*tan((Omega_sz*T)/2); %利用正切对阻带截止频率进行频率压缩

%获取该条件下的滤波器阶数以及3dB截止频率
[N,Omega_c] = buttord(Omega_p,Omega_s,Alpha_p,Alpha_s,'s');
[Bz,Az] = butter(N,Omega_c,'s'); %获取传递函数的分子和分母系数
[Bw,Aw] = bilinear(Bz,Az,Fs); %利用系数进行双线性变换

[Ha,Wz] = freqs(Bw,Aw); %计算模拟频率响应

%绘图
figure(1)
subplot(211);
plot(Wz,20*log10(abs(Ha))); 
title('Ωp = 4k Hz; Ωs = 20k Hz;αp = 0.5dB; αs = 45dB;  butterworth filter Amplitude Frequency response ');
xlabel('fs / kHz');ylabel('|H(a)| / dB');
hold on

subplot(212);
plot(Wz,angle(Ha));
title('butterworth filter Phase Frequency response');
xlabel('fs / kHz');ylabel('|H(a)| / dB');
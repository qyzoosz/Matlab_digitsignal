clc;clear;
close all;

T=1;                %设置采样周期为1
Fs = 1/T;           %设置采样频率，采样周期一般为1
Omega_pz = 0.2*pi;      %设置初始的通带边界频率
Omega_sz = 0.3*pi;      %设置初始的阻带截止频率
Alpha_p = 1;                %设置通带最大衰减为1dB
Alpha_s = 15;               %设置阻带最小衰减为15dB

%为了避免像使用脉冲响应不变法一样出现在ω = Π时的频谱混叠现象
%则进行频率变换，将整个模拟频率压缩到±Π/T之间，再进行z变换即可
Omega_p = 2/T*tan(Omega_pz/2);        %正切变换实现频率压缩
Omega_s = 2/T*tan(Omega_sz/2);          %正切变换实现频率压缩

%获取滤波器阶数和滤波器的3dB截止频率
[N,Omega_c] = buttord(Omega_p,Omega_s,Alpha_p,Alpha_s,'s');
[B,A] = butter(N,Omega_c,'s'); %获取传递函数的分子和分母系数
[Bz,Az] = bilinear(B,A,Fs); %利用系数进行双线性变换，获取转换后的z平面系数
    
%k = 0:511;              
%fk = 14000/512:14000;
%wz = 2*pi*fk;

[Hz,wz] = freqs(Bz,Az);         %获取数字滤波器频率响应
[Hk,Wk] =freqs(B,A);            %获取原模拟滤波器频率响应


%绘图，转变为dB形式 
figure(1);
plot(wz,20*log10(abs(Hz)));   
hold on
plot(Wk,20*log10(abs(Hk)));
xlabel('f/k(Hz)');ylabel('|H|(f)/dB');
legend('数字滤波器','相同条件下的模拟滤波器');
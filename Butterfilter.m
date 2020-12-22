clc;clear;
close all;

%用于设计低通模拟/数字巴特沃斯滤波器
%ω = ΩT；
%Ω = （2/T）tan(0.5*Ω_1*T)
%s=jΩ  z= e^-jω
%s = (2/T)*((1-z^-1)/(1+z^-1))   => z= (2/T+s)/(2/T-s)
%//////////////|
%//////////////|
%/_/_/_/_/_|________
%//////////////|
%//////////////|
%//////////////|

fp = 5000 ;Alpha_p =2;     %通带边界频率5k  通带最大衰减2dB
fs = 12000;Alpha_s = 20;  %阻带截止频率12k 阻带最小衰减20dB

Omega_p = 2*pi*fp;          %计算通带边界频率
Omega_s = 2*pi*fs;          %计算阻带截止频率

[N,Omega_c] = buttord(Omega_p,Omega_s,Alpha_p,Alpha_s,'s'); %获取滤波器阶数，同时获取Ω_c3dB截止频率，这里选择设计模拟滤波器
[B,A] = butter(N,Omega_c,'s'); %利用阶数和Ω_c自动设计巴特沃斯滤波器

%k = 0:511;                          
fk = 14000/512:14000;       
wk = 2*pi*fk;                   %设置确定实向量的角频率

Hk = freqs(B,A,wk);         %利用已获得的分子和分母系数向量计算一定频域内的频率响应

%%%绘图
close all;
plot(fk/1000,20*log10(abs(Hk)));
grid on 
xlabel('f/k(Hz)');ylabel('|H|(f)/dB');

T = 0.01;    %用于配置采样频率的采样周期
%通带边界频率为10Hz
%阻带截止频率为 17.5Hz
%通带最大衰减为1dB
%阻带最大衰减为10dB
wp = 0.2*pi/T;ws = 0.35*pi/T;rp=1;rs = 10;  
[Nz,wc] = buttord(wp,ws,rp,rs,'s');   %设计模拟滤波器、获取滤波器阶数和3dB最大截止频率
[Bw,Aw] = butter(Nz,wc,'s'); %设计巴特沃斯滤波器
[Bz,Az] = impinvar(Bw,Aw,1/T);  %转换为数字滤波器，采样频率为100Hz
Hz = freqs(Bz,Az,wk); %计算一定频域范围内的频率响应
%画图
figure(2)
plot(fk,20*log10(abs(Hz)));
grid on
xlabel('f/k(Hz)');ylabel('|H|(f)/dB');

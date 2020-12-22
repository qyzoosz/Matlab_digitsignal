%语音信号加噪
%

clc;clear all;
close all;
%awgn
IS = 0.5;  %
wlen =  200;
inc = 80;
SNR = 5;

infile = 'Q:\语音信号处理tts\voicestore\sspu-m1.wav';
[input,fs] = audioread (infile);
input = input - mean(input);
ninput = input/max(input);
N  = length (ninput);
time = (0:N-1)/fs;

signal  = awgn(ninput, SNR,'measured');
noise = signal - ninput;
snr1=snr(ninput,noise);

outfile = 'Q:\语音信号处理tts\实验五\voiceRe\noisy.wav';
nsignal = signal / max(abs(signal));
audiowrite (outfile,nsignal,fs);


overlap = wlen - inc;
NIS = fix((IS*fs-wlen)/inc+1);
a= 4 ; b = 0.001;
output= SpectralSub(signal,wlen,inc,NIS,a,b);
snr2 = snr(ninput ,ninput-output);
outfile = 'Q:\语音信号处理tts\实验五\voiceRe\purecVoice.wav';
audiowrite (outfile,output,fs);


sourcefile = 'Q:\语音信号处理tts\voicestore\sspu-w.wav';
[source,Fs1] = audioread(sourcefile);
noisyfile = 'Q:\语音信号处理tts\实验五\voiceRe\noisy.wav';
[noisyf,Fs2] = audioread(noisyfile);
purefile = 'Q:\语音信号处理tts\实验五\voiceRe\purecVoice.wav';
[pureV,Fs3] = audioread(purefile) ;


figure (1)
subplot(311);
plot(source);
title('Source file Wave');
xlabel('time T / s');ylabel ('Amplitude');
subplot(312);
plot(noisyf);
title('Noisy file Wave');
xlabel('time T / s');ylabel ('Amplitude');
subplot(313);
plot(pureV);
title('PureVoice file Wave');
xlabel('time T / s');ylabel ('Amplitude');
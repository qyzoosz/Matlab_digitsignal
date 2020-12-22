function output = SpectralSub (signal,wlen,inc,NIS,a,b)

wnd = hamming(wlen);
N=length (signal);


[y,ypos] = enframe(signal,wnd,inc);
fn = size (y,1);
y_fft = fft(y');
y_a = abs (y_fft);
y_phase = angle(y_fft);
y_a2 = y_a.^2;

Nt = mean(y_a2(:,1:NIS),2);
nl2 = wlen/2+1;


%
for i = 1:fn;
    for k = 1:nl2
        if y_a2(k,i)>a*Nt(k)
            temp(k) = y_a2(k,i)-a*Nt(k);
        else
            temp(k)=b*y_a2(k,i);
        end
        U(k) = sqrt (temp(k));
    end
    X(:,i)=U;
end;

output = OverlapAdd2(X,y_phase(1:nl2,:),wlen,inc);
Nout = length(output);
if Nout >N
    output = output(1:N);
else if Nout<N
        output = [output;zeros(N-Nout,1)];
    end;
end;
output = output / max(abs(output));

function W = dftmatrix(N)
% This function construxts an NxN discrete fourier transform matrix
%


%disp('Creating DFT matrix....');
for k=0:N-1
    for l=0:N-1
        w(k+1,l+1)=cos((2*pi*k*l)/N)-1i*sin((2*pi*k*l)/N);
    end
end
W=1/sqrt(N)*w;
%disp('Done');

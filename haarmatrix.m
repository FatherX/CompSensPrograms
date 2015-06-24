function DWT=haarmatrix(N)
% This function constructs an N by N Haar discrete wavelet transform
% matrix.

h=sqrt(2)*[1/2 1/2];                % low pass filter
DWT=zeros(N,N);

k=1;m=1;
for i=1:N  
    if i<=(N/2)
        l=k+1;
        DWT(i,k)=h(1);DWT(i,l)=h(2);
        k=k+2;
    elseif i>(N/2)
        n=m+1;
        DWT(i,m)=-h(1);DWT(i,n)=h(2);
        m=m+2;
    end  
end
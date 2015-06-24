function T = dctmatrix(N)
% This function constructs a NxN discrete cosine transform matrix

for p=0:N-1
    for q=0:N-1
        if p==0; T(p+1,q+1)=1/sqrt(N);
        else T(p+1,q+1)=sqrt(2/N)*cos(pi*(2*q+1)*(p)/(2*N));end
    end
end
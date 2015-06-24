function Ws = Daub4matrix(N)
% Daubechies length 4 filter

h1 = (1+sqrt(3))/(4*sqrt(2));
h2 = (3+sqrt(3))/(4*sqrt(2));
h3 = (3-sqrt(3))/(4*sqrt(2));
h4 = (1-sqrt(3))/(4*sqrt(2));
h=[h1 h2 h3 h4];

% construct D4 matrix
j=1;
for i = 1:N
    if i < N/2
        Ws(i,j)=h(1);
        Ws(i,j+1)=h(2);
        Ws(i,j+2)=h(3);
        Ws(i,j+3)=h(4);
        j=j+2;  
    elseif i == N/2
        Ws(i,1)=h(3);
        Ws(i,2)=h(4);
        Ws(i,N-1)=h(1);
        Ws(i,N)=h(2);
        j=1;
    elseif and(i > N/2, i < N)
        Ws(i,j)=h(4);
        Ws(i,j+1)=-h(3);
        Ws(i,j+2)=h(2);
        Ws(i,j+3)=-h(1);
        j=j+2;
    elseif i==N
        Ws(i,1)=h(2);
        Ws(i,2)=-h(1);
        Ws(i,N-1)=h(4);
        Ws(i,N)=-h(3);
    end
end
function sig = filtersig(Phi,T,z,j,N)
% This function takes the signal, transforms and truncates it. It then
% transforms it back again before returning with sig.
% 
sig=[];                   % container for recovered signal
sizete = 0;    % intitialize counter for non zero components
for i=1:j
    
    x=z((i-1)*N+1:i*N);     % block to be processed
    xx=T*x;                 % transform signal
    [tempsig,te] = truncate_trans(xx);   % zero small values in transform
    xrec = T'*tempsig;
    % put it in the signal container
    sig = [sig;xrec];
    sizete=sizete+te;       % counting non zero components
end
percorig = sizete/length(sig)*100;
str3 = sprintf('%% Original signal retained = %s %%',num2str(percorig));
disp(str3)
end

function [tempsig,te] = truncate_trans(transig)
% Transform the original signal - reduce the signal size by zeroing
% everything below a certain value and transform back again.

tempsig = transig(abs(transig)>=0.025); % retaining signal greater than 0.02
te=length(tempsig); tr = length(transig);
tempsig(te+1:tr)=0;
end

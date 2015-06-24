function sig = solveforx(Phi,T,z,j,N)
% Inputs are a matrix Phi (measurement matrix), transform matrix T, original signal z with j blocks
% and block size N: solveforx(Phi,T,z,j,N)
% This function solves minimize ||x|| subject to Ax=y by first recasting the problem as a linear
% program and calling the function linprog which uses a dual interior point
% method to optimize x

sig=[];                   % container for recovered signal
sizete = 0;               % intitialize counter for non zero components
% compute matrix A=Phi*T'
A = Phi*T';

% Process each block
for i=1:j
    
    x=z((i-1)*N+1:i*N);     % block to be processed
%     [xrec,te] = filtersig(x,T);   % zero small values in transform
    % observations
    y = Phi*x;
    
    % Recast problem as a linear program refer linprog
    % Let x= xp -xm then we wish to minimize ones(2*N)'[xp xm]' such that
    % [A -A][xp -xm]'=y and xp, xm >=0
    f = ones(1,2*N);
    Aeq = [A -A];
    E=[]; d=[];
    lb=zeros(2*N,1);
    ub = Inf*ones(2*N,1);
    options = optimset('Display','on','MaxIter',85,'TolFun',1e-06);
    [xhat,fval,flag] = linprog(f,E,d,Aeq,y,lb,ub,'',options);

    % now recover the original signal from xrec=T'*xhat
    xrec=T'*(xhat(1:N)-xhat(N+1:2*N));
    % put it in the signal container
    sig = [sig;xrec];
%     sizete=sizete+te;       % counting non zero components
    % next loop
end
% str3 = sprintf('No. of non zero components in transformed signal = %s',num2str(sizete));
% disp(str3);
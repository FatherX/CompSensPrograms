% This script imports a line of the matrix of an image, transforms it and
% seeks to reconstruct it from its sparse representation through convex
% optimization using "linprog" and the interior point method

clear all

%load data
z=[ 37    11    52    34    19     9     8     8     7     7    15    28    44     1    25    54]';
figure(1)
colormap(gray);
imagesc(z')

% divide signal into processing blocks
N=16;
sizeinfo = length(z);       % signal length
j = floor(sizeinfo(1)/N);
% if rem(j,2)~=0            % check if the number is a multiple of 2 (for Haar wavelet)
%     j=j-1;
% end

% the number of measurements to be taken
K=8;
disp('Creating reconstructed signal.....');
str1=sprintf('Blocks to process = %s',num2str(j));
disp(str1);

tic

% Construct the transform matrix

%T=dftmatrix(N);
%T=haarmatrix(N);
T=dctmatrix(N);
%T=Daub4matrix(N);
%T=eye(N);

% measurement matrix
% disp('Creating measurment matrix...');
Phi = randn(K,N);
Phi = orth(Phi')';
% disp('Done.');

% Call a linear program solver (matlab linprog using primal-dual interior
% point method with matrix A=Phi*T'
sig = solveforx(Phi,T,z,j,N);

toc

disp('Signal quality recovered');
% Define PSNR as 10*log(peakval^2/mse)
L=length(sig);
mserr = sum((z(1:L)-sig).^2)/L;
peakval = max(abs(z(1:L)));
PSNR = 10*log(peakval^2/mserr);
str2 = sprintf('PSNR = %s',num2str(PSNR));
disp(str2);

% draw recovered signal
figure(2)
imagesc(sig')
colormap(gray)

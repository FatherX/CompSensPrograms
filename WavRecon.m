% This file takes a wave file and samples it with a random matrix Phi. One then attempts to
% recover the original signal through convex optimization of the signal in
% a "sparse domain". For example the signal measured is not sparse but may
% have a sparse representation as a discrete cosine or wavelet transform.

clear all

% import wav file
% hfile = 'mySpeech.wav';
hfile = 'handel.wav';
[z, Fs, nbits, readinfo] = wavread(hfile);


%disp('Playing original file at 8192 Hz');
%sound(z);

% divide signal into processing blocks
N=32;
sizeinfo = wavread(hfile, 'size');
j = floor(sizeinfo(1)/N);
if rem(j,2)~=0            % check if the number is a multiple of 2 (for Haar wavelet)
    j=j-1;
end

% the number of measurements to be taken
K=20;
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
% sig = filtersig(Phi,T,z,j,N);       % Filters the transformed signal only

toc

disp('Signal quality recovered');
% Define PSNR as 10*log(peakval^2/mse)
L=length(sig);
mserr = sum((z(1:L)-sig).^2)/L;
peakval = max(abs(z(1:L)));
PSNR = 10*log(peakval^2/mserr);
str2 = sprintf('PSNR = %s',num2str(PSNR));
disp(str2);

% play recovered audio signal
disp('Playing....');
sound(sig)
disp('End');


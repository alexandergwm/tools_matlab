function [X t f] = stft_gavin(x,fs,w,R,M)
%% stft gavin
% Parameters

% Nx is the length of signal 取信号长度
Nx = length(x);
% N is the length of window 取窗的长度
N = numel(w);
% O is the overlap between two windows 计算两窗叠加的长度
O = N - R;
% L is the number of frames 
L = ceil((Nx-O)/R);

%% zero padding  calculate the part that the window is more cover than the signal
Zp = O+L*R-Nx;
x = x(:);
pad = zeros(Zp,1);
% signal padding
x = [x;pad];
% 取L行，1列的元胞，即取窗的数量的索引
xx = cell(L,1);
% 取M行，L列的全零矩阵
X = zeros(M,numel(xx));
% 将信号分割放入上述矩阵中
for ii = 1:numel(xx)
    temp = x(((ii-1)*R+1):(ii-1)*R+N).*w; %截取每个窗长的信号一直到所有的窗L全部截取
     xx{ii} = [temp ; zeros( (M - N), 1)];
    X(: ,ii) = 20 * log10( abs( fft(xx{ii}) )); 
end
%% compute the time and frequency vector
Ts = 1/fs;
T = Ts*numel(x);
STs = T/numel(xx);
t = 0+STs:STs:T;
f= fs/M*(0:M-1);
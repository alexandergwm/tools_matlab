function [y]=convolveFFT_OLS_gavin(x, h, N, bZeroPad)
%Overlap save method with Matlab fft
% bZeroPad states if y will be of length x or x+h, so it y has the
% reverberant tail or cuts off earlier
    M=numel(h); % 取脉冲响应长度
    if bZeroPad ==true
        x=cat(1, x, zeros(M, 1)); % 在1维上，给信号补M行一列的0；
    end
    
    Nx=numel(x); % 获取信号的长度
    L=N-M+1; % 理想的block长度为DFT的size减去脉冲长度加一
    
  
    nblocks=ceil(Nx/N);  % 则block数为向上取整的（信号长度/DFT长度），有多少个block
    hpad=cat(1, h, zeros(N-M, 1)); % 此时给IR补（DFT长度-IR长度的零）；
    H=fft(hpad(1:end,1)); %  % 将hpad扩展到一个hpad长度的矩阵，并取fft，即可得到H（t）的值
    
    xpad=cat(1, zeros(M-1, 1), x); % 此时给信号前面补M-1长度的零
    
    y=zeros(Nx, 1);     % 建立信号长度的零矩阵
    
    for ii=0:nblocks-1  % 从第一个到最后一个blocks，开始切割信号
        
        %xseg = zeros(N, 1);
        xseg = xpad(1+(ii*L):(M-1)+L*(ii+1));  %切割的第一个信号xseg = xpad（1：M-1+L）；从开始取到M-1+L处
        Xseg = fft(xseg); % 对每个切割好的信号做fft
        Yseg = Xseg .* H;  % 输出信号等于FFT后的xseg与FFT后的h相乘，即频域的乘积等于时域的卷积
        yseg = ifft(Yseg); %对Yseg取ifft得到 yseg
       
        %y(1+(i*L):(i+1)*L) = yseg((M-1)+(L*i):(M-1)+(L*(i+1))-1, i+1);
        y(ii*L+1:(ii+1)*L) = yseg(M:end);
    end
      
end
%% This function is used to transfer the data from LTspice to MATLAB
function [f,output1,output2] = LTtoMAT(data)
% Input:
%     data   Input data (.xlsx)      
% Output:
%     f        frequency   
%     output1  

Output = data.textdata;   
[m,n] = size(Output);  
f = data.data';     
Output1 = Output(2:end,2)
temp = zeros(numel(Output1),1);  
temp = string(zeros(numel(Output1),1));

for i = 1:numel(temp)
    temp1 = cell2mat(Output1(i));
    [token1,remain1] = strtok(temp1,',');
    Img_Imd = str2num(strtok(remain1,',')); 
    Real_Imd = str2num(token1);
    output1(i) = Real_Imd + 1j*Img_Imd;
end

end




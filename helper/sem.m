function [ y ] = sem( x )
% Calculates standard error for input array
%   

y = std(x) / sqrt(size(x,2));



end


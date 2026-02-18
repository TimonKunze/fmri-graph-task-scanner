function [ c ] = IntHist( v, b )
%IntHist: Histogram Count optimized for speed. Works only with Integers and
%ignores numbers with decimals. WARNING: Will not issue an error of any
%kind if input contains non-integers. This function doesn't perform any
%special check on the input. This is intentional to prioritize speed.
%
% Usage:
%        Input:
%              v: Vector of integers from which to get the count
%              b: Max integer to be counted. Counts for 1:b
%       Output:
%              c: Count of integers b in v
%
%
% Example in case my English is cryptic:
%
% v = [1, 3, 2, 3, 1, 1, 2];
% b = 3;
%
% c = IntHist( v, b );
% c = [3, 2, 2]
%
% Created by Yamil Vidal @ SISSA. 12/02/2018

%if ~all(mod(v,1)==0); error('Input contains non-integers'); end

c = nan(b,1);

for u = 1:b
    c(u) = sum(v == u);
end

end


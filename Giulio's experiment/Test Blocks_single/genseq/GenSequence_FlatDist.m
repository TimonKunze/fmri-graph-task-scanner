function [ Seq ] = GenSequence_FlatDist( Op, N, w )
%GENSEQUENCE Generates a pseudorandom sequence of numbers with limited
%consecutive repetitions.
%   Usage:
%         [ Seq ] = GenSequence( Op, N );
%
%   Where:
%         Op: Integer. eg. if 3, then numbers 1:3 will be used.
%          N: Integer. Length of the sequence.
%%

assert(~mod(N,Op),'Error: N must be a multiple of Op');
assert(~mod(w,2),'Error: w must be even');

Op = 1:Op;

Seq = nan(N,1);

Seq(1:length(Op)) = Shuffle(Op);

for s = 2:N/length(Op)
    
    last  = (s-1)*length(Op);
    
    Op = Shuffle(Op);
    
    while numel(unique([Seq(last-(w/2-1):last);Op(1:w/2)'])) ~= w; Op = Shuffle(Op); end
    
    Seq(last+1:length(Op)*s) = Op;
end

end


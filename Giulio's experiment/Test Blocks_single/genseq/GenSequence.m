function [ Seq ] = GenSequence( Op, N, MaxR )
%GENSEQUENCE Generates a pseudorandom sequence of numbers with limited
%consecutive repetitions.
%   Usage:
%         [ Seq ] = GenSequence( Op, N, MaxR );
%
%   Where:
%         Op: Integer. eg. if 3, then numbers 1:3 will be used.
%          N: Integer. Length of the sequence.
%       MaxR: Maximun number of consecutive repetitions.


%%
Op = 1:Op;

Seq = nan(N,1);

Seq(1:length(Op)) = Shuffle(Op);

for s = length(Op)+1:N
    
    cOp = Op;
    
    if MaxR > 1
        if numel(unique(Seq(s-MaxR:s-1)))==1
            cOp(cOp == Seq(s-1)) = [];
        end
        cOp = Shuffle(cOp);
    else
        cOp = Shuffle(cOp);
        while cOp(1) == Seq(s-1) || cOp(1) == Seq(s-2); cOp = Shuffle(cOp); end
    end
    Seq(s) = cOp(1);
end

end


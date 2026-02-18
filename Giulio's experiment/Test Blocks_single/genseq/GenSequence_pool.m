function [ Seq ] = GenSequence_pool( Op, N, MaxR )
%GENSEQUENCE Generates a pseudorandom sequence of numbers with limited
%consecutive repetitions.
%   Usage:
%         [ Seq ] = GenSequence_pool( Op, N, MaxR );
%
%   Where:
%         Op: Integer. eg. if 3, then numbers 1:3 will be used.
%          N: Integer. Length of the sequence.
%       MaxR: Maximun number of consecutive repetitions.

% clear
% Op = 3;
% N = 70;
% MaxR = 2;
%%
Op = 1:Op;

pool = ones(length(Op),1)*floor(N/length(Op));
pool(end) = pool(end)+rem(N,length(Op));

pool = pool(randperm(length(pool)));

Seq = nan(N,1);

Seq(1:length(Op)) = Shuffle(Op);
pool              = pool-1;

ok = false;
C = 0;
while ~ok
    for s = length(Op)+1:N
        
        cOp = find(pool);
        
        %if numel(unique(Seq(s-MaxR:s-1)))==1,
        if all(Seq(s-MaxR:s-1)-mean(Seq(s-MaxR:s-1))==0)
            cOp(cOp == Seq(s-1)) = [];
        end
        
        if numel(cOp)>0
            if numel(cOp)>1
                Seq(s) = randsample(cOp,1);
            else
                Seq(s) = cOp;
            end
            pool(Seq(s)) = pool(Seq(s))-1;
        end
    end
    
    ok = ~any(isnan(Seq));
    C = C+1
    
end

end


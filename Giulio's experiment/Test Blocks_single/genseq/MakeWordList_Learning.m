function [Seq] = MakeWordList_Learning(TotLength)

Seq       = [];

ck = true(6,1);

while any(ck)
    Seq   = GenSequence( 6, TotLength, 1 ); % Identity of the Std
    
    for n = 1:6
        ck(n) = abs(sum(Seq == n) - TotLength/6) > 3;
    end
end

end
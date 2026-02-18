

for c = 1:length(E.Stim.LatinI)-1
    HL(c) = size(E.Stim.LatinI{c},1);
    WL(c) = size(E.Stim.LatinI{c},2);
end

for c = 1:length(E.Stim.I)-1
    H(c) = size(E.Stim.I{c},1);
    W(c) = size(E.Stim.I{c},2);
end

%

[~,p1] = ttest2(HL,H);
[~,p2] = ttest2(WL,W);

clc
[p1,p2]
[(mean(HL)-mean(H))/mean(H)*100,(mean(WL)-mean(W))/mean(W)*100]
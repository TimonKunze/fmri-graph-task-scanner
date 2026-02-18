ff = dir('*.mat');

W = nan(200,500);

for f = 1:length(ff)
    load(ff(f).name);
    W(:,f) = words;
end

W = W';

%%
W = cell2mat(Lists')';

plot(sum(W>6))



%% Create matfile with list number info for each participant

PptLists.Lists = [1:50]';

for i = 1:50
    PptLists.Lists(i,2:8) = randperm(20,7)';
    PptLists.CharSet(i,1:18)    = randperm(23,18);
end

% Add character sets





save(['Wordlists/PptLists - ' datestr(now, 'dd-mmm-yyyy HH-MM-SS') '.mat'], "PptLists")
save(['../Learning Blocks/WordLists/PptLists - ' datestr(now, 'dd-mmm-yyyy HH-MM-SS') '.mat'], "PptLists")

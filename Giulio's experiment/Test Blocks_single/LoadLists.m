%% Load all the lists for the blocks containing deviants
% We get the list number from a separate matfile
% Then, based on block number, we load the corresponding file

load("WordLists\PptLists - 28-Jul-2025 15-09-33.mat")

E.Stim.StimList       = PptLists.Lists(str2double(E.sbj.n), E.sbj.block + 1);
E.Stim.WordLists      = nan(E.times.NBlocks,E.times.NWords);
E.Stim.FixTime        = nan(E.times.NBlocks,E.times.NWords);
E.Stim.DelayTime      = nan(E.times.NBlocks,E.times.NWords);
E.Stim.TotalTime      = nan(E.times.NBlocks,E.times.NWords);
E.Stim.BlankTime      = nan(E.times.NBlocks,E.times.NWords);


for L = 1:length(E.Stim.StimList)
    load(fullfile(WordListPath,['S_',num2str(E.Stim.StimList(L)),'.mat']));
    E.Stim.WordLists(L,:) = words(:,1);
    E.Stim.FixTime(L,:)   = words(:,2);
    E.Stim.DelayTime(L,:) = words(:,3);
    E.Stim.BlankTime(L,:) = words(:,4);
    E.Stim.TotalTime(L,:) = words(:,5);

    
end

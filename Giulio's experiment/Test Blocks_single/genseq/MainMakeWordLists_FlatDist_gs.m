clear all

Lists = cell(20,1);

Ndev    = 12;
Nstds   = 72;
Header  = 12;
Ntot = Ndev + Nstds;

for n = 1:length(Lists)
    STDstart    = GenSequence_FlatDist( 6, Header, 2);
    STD         = GenSequence_FlatDist( 6, Nstds - Header, 2 );
    DEV         = GenSequence_pool( 2,  Ndev, 2 ) + 6;
    

    
    nSTD = [];
    
    while sum(nSTD) ~= Ntot - Header
        %nSTD = GenSequence_FlatDist( 3, 60, 2 ) + 2;
        %nSTD = randi(5,[21,1]) + 6;
        nSTD = randi(6,[13,1]) + 4;
    end
    
    %nSTD = GenSequence_FlatDist( 7, 21, 2 ) + 5;
    
    nSTD = cumsum(nSTD);
    
    insert = @(a, x, n)cat(1,  x(1:n), a, x(n+1:end));
    
    for t = length(DEV):-1:1
        STD = insert(DEV(t), STD, nSTD(end-t));
    end
    
    STD = [STDstart; STD];

    words = STD;
    Lists{n} = words;
    display(['List ', num2str(n),' created']);
end

%% Save for online expt
% Save as CSV with label
for n = 1:length(Lists)
    % words = Lists{n};
    % save(['S_',num2str(n)],'words')
    
    % Also load the trial durations
    durs = readtable(strcat('..\..\..\trialDurations\', 'trialDurations_', string(n), '.csv'));
    words = array2table(Lists{n});
    words.Properties.VariableNames = {'word'};

    trialN = [1:84]';
    words = addvars(words, trialN, 'Before','word');
    durs = addvars(durs, trialN, 'Before','fixation_duration');
    
    words = join(words, durs);
    % writetable(words, ['S_',num2str(n), '.csv'])
end


%% Save for in-house expt

for n = 1:length(Lists)
    % words = Lists{n};
    
    
    % Also load the trial durations
    durs = readtable(strcat('..\Inputlists\TrialDurs\', 'trialDurations_', string(n), '.csv'));
    durs = table2array(durs);
    
    words = [words durs];
    save(['S_',num2str(n)],'words')
    
end


%% Check inputlists
for j = 1:20
    
    checklist = Lists{j};
    
    % disp("word 1")
    size(find(checklist == 1),1)
    
    % disp("word 2")
    size(find(checklist == 2),1)
    
    % disp("word 3")
    size(find(checklist == 3),1)
    
    % disp("word 4")
    size(find(checklist == 4),1)
    
    % disp("word 5")
    size(find(checklist == 5),1)
    
    % disp("word 6")
    size(find(checklist == 6),1)
    
    % disp("word 7")
    size(find(checklist == 7),1)
    
    % disp("word 8")
    size(find(checklist == 8),1)

end



%% Modify word lists for fMRI
% Was a small error in the behav lists (1 second in the timings). Load the
% scripts and modify

for n = 1:length(Lists)
    % words = Lists{n};
    % save(['S_',num2str(n)],'words')
    
    load(strcat("..\WordLists\DevBlocks_fMRI\S_",string(n)));

    % Also load the trial durations
    durs = readtable(strcat('..\..\..\trialDurations\', 'trialDurations_', string(n), '.csv'));
    durs = table2array(durs);
    
    % New durations
    words = [words(:,1) durs];
    
    
        save(['S_',num2str(n)],'words')
   
end
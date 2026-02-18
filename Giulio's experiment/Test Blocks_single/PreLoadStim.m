E.Stim.Scale = .1; % Scale of the stim on screen

% Directories
if ~E.debugmode
    NewChar   = fullfile(pwd, 'Stimuli', 'BACS-2');
else
    NewChar   = fullfile(pwd, 'Stimuli', 'Debug');
end

p_data    = fullfile(pwd, 'Data');

WordListPathLearn      = fullfile(pwd, 'WordLists', 'Learning');
WordListPath           = fullfile(pwd, 'WordLists', 'DevBlocks_fMRI');

%% Load all characters
LoadNewCharSet

%% By all means, don't touch this, as it defines the statistical structure of the stimuli
WordsStatStructure

%%
LoadLists
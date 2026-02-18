 % 27/07/2018 - Created by Yamil Vidal @ L2R Lab, SISSA
 function E = TheMainScript()
%% Parameters

% Experiment name
E.exp_name = 'OddBallBigrams - fMRI_E1_Test';
GetSubInfo; 


% Name of the outpu t file
E.filename       = [E.exp_name '-' E.sbj.n ' -B' num2str(E.sbj.block) '-' datestr(now, 'dd-mmm-yyyy HH-MM-SS')];
E.filenameCSV    = [E.exp_name '-' E.sbj.n ' -B' num2str(E.sbj.block) '-' datestr(now, 'dd-mmm-yyyy HH-MM-SS') '_Resultsoutput.csv'];
%%
try
    %% Get things ready
    rng('shuffle'); % Seed random number generator with current date
    SetupTiming; 
    SetupHardware;
    IniHardware;
    PreLoadText;
    PreLoadStim;
    
    
    %% Run the experiment
    ExperimentScript;
    
    %% Save the data
    save(fullfile(p_data,E.filename), 'E');
    display(' ');
    disp('The experiment finished correctly');
    disp(['The data was saved in ' E.filename]);

    % Also save in CSV format 
    % We're saving: %sbjN, BlockN, stimulus, StimList, Response, RT,
    % FixTiming, StimOnsetTiming, ResponseTiming, StimOffTiming
    
    ResultsOutput = table(repmat(E.sbj.n,E.times.NWords,1), repmat(E.sbj.block,E.times.NWords,1), E.Stim.WordLists(:), repmat(E.Stim.StimList,E.times.NWords,1), E.Resp(:), E.RespTime(:),E.Timings(1,:)',...
        E.Timings(2,:)', E.Timings(3,:)', E.Timings(4,:)',...
    'VariableNames', {'Subject', 'Block', 'Word', 'StimList', 'Response', 'RespTime', 'FixOnset', 'StimOnset', 'KeyPressed', 'StimOffset'});

    writetable(ResultsOutput,fullfile(p_data,E.filenameCSV));

    %% Thank participant and CleanUp
    ThankYou;   
    Screen('CloseAll');
    ShowCursor;
    ListenChar;
    % if E.RespBox.use; CedrusResponseBox('CloseAll'); end
    
catch err
    E.err = err;
    if exist([E.filename '.mat'],'var')==2; E.filename = [E.filename '_i']; end
    save(fullfile(pwd,'Crashed',E.filename))
    disp('There was an arror')
    display(err);
    display(err.message);
    display(err.stack);
    Screen('CloseAll');
    ShowCursor;
    ListenChar;
end

%% Auxiliar Functions

function press_space(thekey) % stay in the loop (wait) till space is pressed  m
while 1
    [~, ~, keyCode, ~] = KbCheck;
    if any(keyCode)
        key = find(keyCode);
        K = repmat(thekey,numel(key),1)==repmat(key',1,numel(thekey));
        if any(any(K))
            break
        end
    end
end 
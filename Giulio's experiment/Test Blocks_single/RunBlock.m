function [ E ] = RunBlock( E )
%RUNBLOCK Run a block

%% Trial loop
for w = 1:E.times.NWords
    display(['Block: ',num2str(E.times.BlockCounter),' Trial: ',num2str(w)]);
    
    Screen(E.screen.theWindow,'TextSize',E.screen.textsize*5);
%     DrawFormattedText(E.screen.theWindow,'+','center', E.screen.cy - E.screen.textsize*5/1.5, E.screen.textcolor);
    DrawFormattedText(E.screen.theWindow,'+','center',E.screen.cy,E.screen.textcolor);
    Screen('Flip', E.screen.theWindow);
    
    % trialStart = tic;
    % fixStart = tic;

    %Store timing
    E.Timings(1,w) = GetSecs - E.begintime;
    
    % WaitSecs(E.times.ISI + E.times.ISIJitter*rand);
    WaitSecs(E.Stim.FixTime(E.times.BlockCounter,w)/1000);
    % E.Stim.DebugTimings(1,w) = toc(fixStart);


    CheckKeyRelease; % Check that no key is pressed before showing the stim
    
    W = E.Stim.WordLists(E.times.BlockCounter,w);
    delayTime = E.Stim.DelayTime(E.times.BlockCounter,w);
    totalTime = E.Stim.TotalTime(E.times.BlockCounter,w);
    blankTime = E.Stim.BlankTime(E.times.BlockCounter,w);

    ShowWord(E, E.Stim.Words, E.Stim.I, E.Stim.Char, W, 0);
    
    % Store timing
    E.Timings(2,w) = GetSecs - E.begintime;

    E = GetKeyResp(E,w);
    
    if isnan(E.Resp(w))
    E.Timings(4,w) = GetSecs - E.begintime;
    end    
    % E.Stim.DebugTimings(2,w) = toc(trialStart);

    STOP = press_ctrlalt(E.keys.c_alt, E.keys.c_ctrl); % if ctrl+alt are pressed, ends the Block and continues
    if STOP; break; end
    press_escape(E.keys.c_escape) % generate an error and exit if escape is pressed
    
end

Screen('Flip', E.screen.theWindow); % Clear the Screen
% If no response was given, this is the stimulus offset marker
    

%% End of Block
display(['End of Block ',num2str(E.times.BlockCounter)]);

E.times.BlockCounter = E.times.BlockCounter+1;


end

%% Auxiliary functions
function press_escape(thekey) % if escape is pressed it generates an error
[~, ~, keyCode, ~] = KbCheck;
if any(keyCode)
    key = find(keyCode);
    K = repmat(thekey,numel(key),1)==repmat(key',1,numel(thekey));
    if any(any(K))
        Screen('CloseAll');
        ShowCursor;
        ListenChar;
        error('Exp:Aborted', 'Escape was press')
    end
end
end

function var = press_ctrlalt(altkey,ctrlkey) % If ctrl + alt are pressed it set the variable out to 0
[~, ~, keyCode, ~] = KbCheck;
%if any(keyCode)
key = find(keyCode);
K1 = repmat(altkey,numel(key),1)  == repmat(key',1,numel(altkey));
K2 = repmat(ctrlkey,numel(key),1) == repmat(key',1,numel(ctrlkey));
if any(any(K1)) &&  any(any(K2))
    var = 1;
else
    var = 0;
end
end
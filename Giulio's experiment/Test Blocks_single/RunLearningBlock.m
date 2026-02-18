function [ E ] = RunLearningBlock( E )
%RUNBLOCK Run a block

%% Trial loop
for w = 1:E.times.NWords
    display(['Learning Block Trial: ',num2str(w)]);
    
    Screen(E.screen.theWindow,'TextSize',E.screen.textsize*5);
%     DrawFormattedText(E.screen.theWindow,'+','center', E.screen.cy - E.screen.textsize*5/1.5, E.screen.textcolor);
    DrawFormattedText(E.screen.theWindow,'+','center',E.screen.cy,E.screen.textcolor);
    
    %Screen('FillRect', E.screen.theWindow, [90, 247, 76], [1 1 E.screen.res(1) 100] )
        
    Screen('Flip', E.screen.theWindow);
    WaitSecs(E.times.ISI + rand*.5);
    
    W = E.Stim.WordListsLearn(w);
    ShowWord(E, E.Stim.Words, E.Stim.I, E.Stim.Char, W, 1);
    
    WaitSecs(1 + E.times.ISI + rand*.5);
    
    STOP = press_ctrlalt(E.keys.c_alt, E.keys.c_ctrl); % if ctrl+alt are pressed, ends the Block and continues
    if STOP; break; end
    press_escape(E.keys.c_escape) % generate an error and exit if escape is pressed
end

Screen('Flip', E.screen.theWindow); % Clear the Screen

%% End of Block
display('End of Learning Block');

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
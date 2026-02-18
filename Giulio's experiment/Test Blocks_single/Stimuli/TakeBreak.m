function [  ] = TakeBreak( E )

Screen(E.screen.theWindow,'TextSize',E.screen.textsize*2);

theText = ['Puoi fare una breve pausa \n\n']%,...
%     'Premi ',E.keys.c_K1,' se la parola è giusta \n\n',...
%     'Premi ',E.keys.c_K2,' se la parola è sbagliata'];

DrawFormattedText(E.screen.theWindow,theText,'center','center',E.screen.textcolor);
%DrawFormattedText(theWindow,'Puoi prendere una piccola pausa \n Premi la BARRA per continuare','center','center',255);
Screen('Flip', E.screen.theWindow);

for c = 1:E.times.Break - E.times.CountDown; % Break between blocks    
    WaitSecs(1);
    
    STOP = press_ctrlalt(E.keys.c_alt, E.keys.c_ctrl); % if ctrl+alt are pressed, ends the Block and continues
    if STOP; break; end
end

for c = 1:E.times.CountDown % Break between blocks (CountDown)
    if STOP; break; end
    
    DrawFormattedText(E.screen.theWindow,['Pausa finisce in ', num2str(E.times.CountDown+1 - c)],'center','center',E.screen.textcolor);
    %DrawFormattedText(theWindow,'Puoi prendere una piccola pausa \n Premi la BARRA per continuare','center','center',255);
    Screen('Flip', E.screen.theWindow);
    WaitSecs(1);
    
    STOP = press_ctrlalt(E.keys.c_alt, E.keys.c_ctrl); % if ctrl+alt are pressed, ends the Block and continues
    if STOP; break; end
end
end

%% Auxiliary functions
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

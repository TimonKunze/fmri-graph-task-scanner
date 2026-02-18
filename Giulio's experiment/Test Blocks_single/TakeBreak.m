function [  ] = TakeBreak( E )

Screen(E.screen.theWindow,'TextSize',E.screen.textsize*2);

theText = ['Puoi fare una pausa \n\n'];

DrawFormattedText(E.screen.theWindow,theText,'center','center',E.screen.textcolor);
%DrawFormattedText(theWindow,'Puoi prendere una piccola pausa \n Premi la BARRA per continuare','center','center',255);
Screen('Flip', E.screen.theWindow);

press_space(E.keys.c_space) % waits till space is pressed
       
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

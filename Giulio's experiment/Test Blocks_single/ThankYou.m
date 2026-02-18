if E.sbj.block < 7
    Screen(E.screen.theWindow,'TextSize',E.screen.textsize*2);
    DrawFormattedText(E.screen.theWindow,'Puoi prendere una pausa','center','center',E.screen.textcolor);
    Screen('Flip', E.screen.theWindow);
else
    Screen(E.screen.theWindow,'TextSize',E.screen.textsize*2);
    DrawFormattedText(E.screen.theWindow,'Grazie mille!!','center','center',E.screen.textcolor);
    Screen('Flip', E.screen.theWindow);
end
WaitSecs(5);
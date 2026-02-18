%% Instructions
WelcomeText = ['Ciao, grazie per aver iniziato questo esperimento. \n\n',...
'Premi la [BARRA] per continuare.'];

DrawFormattedText(E.screen.theWindow,WelcomeText,'center','center',E.screen.textcolor);
Screen('Flip', E.screen.theWindow);
press_space(E.keys.c_space)

Instr1Text = ['Questo esperimento consiste di due fasi.\n\n' ,...
    'In totale, la sessione dura circa 60 minuti e avrai delle pause per riposarti \n\n',...
'Nella prima fase, appariranno delle parole in una lingua sconosciuta al centro dello schermo. \n\n',...
'Il tuo compito è di leggerle e provare ad impararle per il prossimo compito. \n\n',...
'Questo durerà cira 7 minuti. \n\n\n\n',...
'La seconda fase verrà spiegata dopo questa prima fase. \n\n\n\n',...
'Premi la [BARRA] per continuare'];

CheckKeyRelease; % Check that no key is pressed before showing the stim
DrawFormattedText(E.screen.theWindow,Instr1Text,'center','center',E.screen.textcolor);
Screen('Flip', E.screen.theWindow);
press_space(E.keys.c_space)

StartText = ['Sei pronto per iniziare?\n\n',...
'Premi la [BARRA]'];

CheckKeyRelease; % Check that no key is pressed before showing the stim
DrawFormattedText(E.screen.theWindow,StartText,'center','center',E.screen.textcolor);
Screen('Flip', E.screen.theWindow);
press_space(E.keys.c_space)


%% Learning Block
display(' ');
display('Ready to start Learning Block. Press space to continue');
press_space(E.keys.c_space) % waits till space is pressed
display('Start!!');
% 
E = RunLearningBlock( E );

%% Test block instruction
TakeBreak(E);

Instr2Text = ['Bene! Questa era la prima fase.\n\n' ,...
    'Quando sei pronto, puoi iniziare la seconda fase. \n\n',...
'In questa fase, vedrai di nuovo le parole apparire al centro dello schermo. \n\n',...
'Il tuo computo e di decidere se la parola è corretta o sbagliata. \n\n',...
'Se è corretta, premi il tasto ' E.keys.c_K1 '. \n\n',...
'Se è sbagliata, premi il tasto ' E.keys.c_K2 '. \n\n',...
'Cerca di essere sia accurato che veloce. \n\n\n\n',...
'Questa fase consiste di 7 parti di circa 7 minuti. \n\n',...
'Dopo ogni parte puoi riposarti per un minuto. \n\n\n\n',...
'Premi la [BARRA] per continuare'];

Screen(E.screen.theWindow,'TextSize',E.screen.textsize);

CheckKeyRelease; % Check that no key is pressed before showing the stim
DrawFormattedText(E.screen.theWindow,Instr2Text,'center','center',E.screen.textcolor);
Screen('Flip', E.screen.theWindow);
press_space(E.keys.c_space)

%% Test Blocks, interwoven with Short Learning Blocks

display(' ');
display('Ready to start Deviant Blocks. Press space to continue');
press_space(E.keys.c_space) % waits till space is pressed
display('Start!!');

% TakeBreak(E);

for b = 1:E.times.NBlocks
    E = RunBlock( E );
    
    if b == 3
        
        theText = ['Sei a metà! Puoi fare una pausa \n\n'];
        Screen(E.screen.theWindow,'TextSize',E.screen.textsize*2);
        CheckKeyRelease; % Check that no key is pressed before showing the stim
        DrawFormattedText(E.screen.theWindow,theText,'center','center',E.screen.textcolor);
        Screen('Flip', E.screen.theWindow);


        display(' ');
        display('Mid experiment break. Check if subject is alive');
        press_space(E.keys.c_space) % waits till space is pressed
        display('Start!!');
    end
        
    if b ~= 3 & b<E.times.NBlocks; TakeBreak(E); end
    
    %     if b ~= E.times.NBlocks
    %         TakeBreak(E);
    %         E = RunShortLearningBlock( E );
    %         TakeBreak(E);
    %     end
end

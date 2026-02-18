%% Instructions
HideCursor

Screen(E.screen.theWindow,'TextSize',E.screen.textsize * 2);

if E.sbj.block == 1

    WelcomeText = ['Ciao, ora inziamo la seconda parte. \n\n',...
    'Ricordati: il tuo computo e di decidere se la parola è corretta o sbagliata. \n\n',...
    'Se è corretta, usa il dito ' E.keynameK1 '. \n\n',...
    'Se è sbagliata, usa il dito ' E.keynameK2 '. \n\n',...
    'Ora lo schermo diventerà vuoto per qualche secondo. Non preoccuparti, dopo inizia il blocco. \n\n',... 
    'Premi un tasto per iniziare'];
    
    
    
    CheckKeyRelease; % Check that no key is pressed before showing the stim
    DrawFormattedText(E.screen.theWindow,WelcomeText,'center','center',E.screen.textcolor);
    Screen('Flip', E.screen.theWindow);
    press_space([E.keys.c_K1 E.keys.c_K2]) % note, this doesn't look for space but for button box
else
     WelcomeText = ['Pronti per il prossimo blocco? \n\n',...
    'Ricordati:',...
    'Se è corretta, usa il dito ' E.keynameK1 '. \n\n',...
    'Se è sbagliata, usa il dito ' E.keynameK2 '. \n\n',...
    'Ora lo schermo diventerà vuoto per qualche secondo. Non preoccuparti, dopo inizia il blocco. \n\n',...
    'Premi un tasto per iniziare'];
    
       
    CheckKeyRelease; % Check that no key is pressed before showing the stim
    DrawFormattedText(E.screen.theWindow,WelcomeText,'center','center',E.screen.textcolor);
    Screen('Flip', E.screen.theWindow);
    press_space([E.keys.c_K1 E.keys.c_K2])
end
%% Test Blocks, interwoven with Short Learning Blocks

display(' ');
display('Ready to start Deviant Blocks. Press space to continue');
%press_space(E.keys.c_space) % waits till space is pressed
display('Start!!');


CheckKeyRelease; % Check that no key is pressed before showing the stim
% DrawFormattedText(E.screen.theWindow,'Start the trigger','center','center',E.screen.textcolor);
Screen('Flip', E.screen.theWindow);

% TakeBreak(E);
[~,KeyCode,~]=KbWait;

if KeyCode(KbName('5%'))==1
    disp(' -- START -- ')
    
    Screen('Flip', E.screen.theWindow);
    E.begintime=GetSecs();
    % tic;
    WaitSecs(12)

for b = 1:E.times.NBlocks
    E = RunBlock( E );
    
   
end

% toc
%% Wait until end of sequence
MaxTime = 500;
CurrentTime = GetSecs;

WaitSecs(MaxTime - CurrentTime);

end
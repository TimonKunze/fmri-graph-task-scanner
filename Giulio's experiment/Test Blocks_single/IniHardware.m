% Open the screen
PsychImaging('PrepareConfiguration');

[E.screen.theWindow] = Screen('OpenWindow', E.screen.screenN, E.screen.bckgrnd, [], E.screen.clrdepth);

% Enable transparency
Screen('BlendFunction',E.screen.theWindow, 'GL_SRC_ALPHA','GL_ONE_MINUS_SRC_ALPHA');

[E.screen.cx, E.screen.cy] = WindowCenter(E.screen.theWindow);

% Set Text Format
Screen(E.screen.theWindow,'TextFont','Arial');
Screen(E.screen.theWindow,'TextSize',E.screen.textsize);

% Maximum priority level
topPriorityLevel = MaxPriority(E.screen.theWindow);
Priority(topPriorityLevel);

% Collect the time for the first flip with vbl
E.screen.vbl = Screen(E.screen.theWindow, 'Flip');

% Calculate center of the screen for stim positioning
[E.screen.cx, E.screen.cy] = WindowCenter(E.screen.theWindow);

% Query the frame duration
E.screen.flipinterval = Screen('GetFlipInterval',E.screen.theWindow);

ListenChar(2);
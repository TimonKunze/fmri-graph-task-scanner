function [] = ShowWord( E, Words, I, Char, w, isLearn)

%Words = [6 6 6 6 6 6];
s                          = E.Stim.Scale; % Font size
LineHeight                 = 400;
[E.screen.cx, E.screen.cy] = WindowCenter(E.screen.theWindow);

Width  = nan(size(Words,2),1);
Height = Width;

for c = 1:size(Words,2)
    Width(c) = size(I{Words(w,c)},2)*s;
    Height(c) = size(I{Words(w,c)},1)*s;
end

inx = (E.screen.res(1) - sum(Width))/2;

pos = [inx;
    E.screen.cy - Height(1);
    inx + Width(1);
    E.screen.cy];

if Width(1)~=0
    Screen('DrawTexture', E.screen.theWindow, Char{Words(w,1)},[],pos);
end

for c = 2:size(Words,2)
    pos = [pos(3)+1;
        E.screen.cy - Height(c);
        pos(3)+1 + Width(c);
        E.screen.cy];
    
    if Width(c)~=0
        Screen('DrawTexture', E.screen.theWindow, Char{Words(w,c)},[],pos);
    end
end

if isLearn
    %Screen('FillRect', E.screen.theWindow, [90, 247, 76], [1 1 E.screen.res(1) 100] )
end

% Draw lines to test centering
%Screen('DrawLine', E.screen.theWindow, [255 0 0], E.screen.res(1)/2, 1, E.screen.res(1)/2, E.screen.res(2), 1);
%Screen('DrawLine', E.screen.theWindow, [255 0 0], 1, E.screen.res(2)/2, E.screen.res(1),  E.screen.res(2)/2, 1);

Screen('Flip', E.screen.theWindow);

% display(num2str(w));

end
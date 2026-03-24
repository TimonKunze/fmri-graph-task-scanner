% if ~E.debugmode
%     E.Stim.C    = randperm(23,18);
% else
%     E.Stim.C    = 1:18;
% end

fn = fullfile("WordLists", "PptLists - 28-Jul-2025 15-09-33.mat");
load(fn);

E.Stim.C    = PptLists.CharSet(str2double(E.sbj.n),:);

E.Stim.I    = cell(18,1);
E.Stim.Char = cell(18,1);

for n = 1:length(E.Stim.C)
    I = imread(fullfile(NewChar,[num2str(E.Stim.C(n)),'.jpg']));
    
    I(I>100) = 255; % Make sure texture is pure black and white
    I(I<100) = 0;
    
    A = I(:,:,1); % Create Alpha channel
    A(I(:,:,1) == 255) = 0;
    A(I(:,:,1) == 0)   = 255;
    I(:,:,4) = A;
    
    E.Stim.I{n}    = I;
    E.Stim.Char{n} = Screen(E.screen.theWindow,'MakeTexture', I);
end

%E.Stim.I{10}    = []; % For no character to display

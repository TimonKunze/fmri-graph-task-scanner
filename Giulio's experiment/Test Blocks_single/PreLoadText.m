%% Instructions and text
T_Blocks         = 'Instructions_Blocks.txt'; % text file for the second instructions

% Read the text files for the instructions
% Regular blocks
id       = fopen(fullfile(pwd, T_Blocks));
t_blocks = textscan(id,'%c','whitespace','');
E.text.t_blocks = t_blocks{1}';
fclose(id);

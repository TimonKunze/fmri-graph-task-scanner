clear all

Lists = cell(500,1);

for n = 1:length(Lists)
    STD  = GenSequence_FlatDist( 6, 180, 2 );
    DEV  = GenSequence_FlatDist( 2,  20, 2 ) + 6;


    
    nSTD = [];
    
    while sum(nSTD) ~= 200
        %nSTD = GenSequence_FlatDist( 3, 60, 2 ) + 2;
        %nSTD = randi(5,[21,1]) + 6;
        nSTD = randi(7,[21,1]) + 5;
    end
    
    %nSTD = GenSequence_FlatDist( 7, 21, 2 ) + 5;
    
    nSTD = cumsum(nSTD);
    
    insert = @(a, x, n)cat(1,  x(1:n), a, x(n+1:end));
    
    for t = length(DEV):-1:1
        STD = insert(DEV(t), STD, nSTD(end-t));
    end
    
    words = STD;
    Lists{n} = words;
    display(['List ', num2str(n),' created']);
end

%%
for n = 1:length(Lists)
    words = Lists{n};
    save(['S_',num2str(n)],'words')
end

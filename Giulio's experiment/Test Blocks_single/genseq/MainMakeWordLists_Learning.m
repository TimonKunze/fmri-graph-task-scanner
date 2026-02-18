Lists = cell(20,1);

parfor n = 1:length(Lists)
    
    ck = true;
    
    while ck
        words = MakeWordList_Learning(100);
        w = 50;
        h = [];
        
        for i = 1:length(words)-w
            h(i,:) = hist(words(i:i+(w-1)),6)/w;
        end
        
        ck = any(abs(h(:) - 1/6) > .1);
    end
    
    Lists{n} = words;
end


for n = 1:length(Lists)
    words = Lists{n};
    save(['S_Learn_',num2str(n),'.mat'],'words')
end

Lists = cell(500,1);

for n = 1:length(Lists)
    
    ck = [true true];
    
    C = 1;
    CK = nan(3,1000);
    while any(ck)
        words = MakeWordList();
        
        %% First, check if std word frequency is stable
        w = 50;
        h = [];
        
        for i = 1:length(words)-w
            h(i,:) = IntHist(words(i:i+(w-1)),8)/w;
        end
        
        h = h(:,1:6);
        
        ck(1) = any(abs(h(:) - 1/6) > .1);
         CK(1,C) = ck(1);
        %% Second, check if at any point, mean dev freq is higher than std freq, or if mean dev freq is above 10% 
        w = 30;
        h = [];
        
        for i = 1:length(words)-w
            h(i,:) = IntHist(words(i:i+(w-1)),8)/w;
        end
        
        mpd = mean(h(:,7:8),2); % mean prob deviant
        mps = mean(h(:,1:6),2); % mean prob standard
        
        ck(2) = any(mpd > mps) || any(mpd > .1);
        CK(2,C) = any(mpd > mps);
        CK(3,C) = any(mpd > .1);
        %ck = false;
         C = C+1;
    end
    
    Lists{n} = words;
    display(['List ', num2str(n),' created']);
end

for n = 1:length(Lists)
    words = Lists{n};
    save(['S_',num2str(n),'.mat'],'words')
end

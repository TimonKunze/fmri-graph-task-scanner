ck = nan(10000,3);
for n = 1:500
    words = MakeWordList();
    
    %% First, check if std word frequency is stable
    w = 50;
    h = [];
    
    for i = 1:length(words)-w
        h(i,:) = hist(words(i:i+(w-1)),9)/w;
    end
    
    h = h(:,1:6);
    
    ck(n,1) = any(abs(h(:) - 1/6) > .1);
    
    %% Second, check if at any point, mean dev freq is higher than std freq, or if mean dev freq is above 10%
    w = 20;
    h = [];
    
    for i = 1:length(words)-w
        h(i,:) = hist(words(i:i+(w-1)),9)/w;
    end
    
    mpd = mean(h(:,7:9),2); % mean prob deviant
    mps = mean(h(:,1:6),2); % mean prob standard
    
    ck(n,2) = any(mpd > mps);
    ck(n,3) = any(mpd > .1);
    %ck = false;
end
%%
CK = ck;

CK(isnan(CK(:,1)),:) = [];

mean(CK);
%%

CK = CK == 0;

1/prod(mean(CK(:,1:3)))*1.5/60/4
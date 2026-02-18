function [Seq] = MakeWordList()

Intervals  = 7;
TotDev     = 20;
TotLength  = 200;
HeadingStd = 12;
Stds       = TotLength-TotDev-HeadingStd;

Int = [];
ck = true(4,1);

% CK = nan(4,100000);
% c  = 1;
while any(ck)
    Int = GenSequence( Intervals, TotDev, 2 )+5; % Interval between Std
    
    ck(1) = sum(Int)~=(Stds);
    %ck(2) = sum(Int == 4) - floor(TotDev/Intervals) < -2 || sum(Int == 4) - floor(TotDev/Intervals) > 1;
    
    for nInt = 1: Intervals
        ck(nInt+1) = abs(sum(Int == nInt+5) - floor(TotDev/Intervals))>2;
    end
        
%     CK(:,c) = ck;
%     c = c+1;
end

%CK(:,isnan(CK(1,:))) = [];
%p = abs((sum(CK,2)/length(CK))-1);


D = [];
while sum(D == 7)~=10
    D   = GenSequence( 2, TotDev, 2 ) + 6; % Type of Dev
end


S = [];
ck = true(6,1);

while any(ck)
    S   = GenSequence( 6, Stds, 1 ); % Identity of the Std
    
    for n = 1:6
       ck(n) = abs(sum(S == n) - floor(Stds/6))>1;
    end
end


Seq = ones(TotLength-HeadingStd,1);

%%
c = 1;
for I = 1:length(Int)
    n = c:c+(Int(I)-1);
    
    Seq(n(end)+1) = 0;
    c = c+Int(I)+1;
end

%%

Seq(Seq==1) = S;
Seq(Seq==0) = D;

S = [];
ck = true(6,1);

while any(ck)
    S   = GenSequence( 6, 12, 1 ); % Identity of the Std
    
    for n = 1:6
        ck(n) = sum(S == n) ~= 2;
    end
end

Seq = [S; Seq];
end
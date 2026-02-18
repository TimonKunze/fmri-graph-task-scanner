Resp  = E.Resp(:);
Words = E.Stim.WordLists(:);
RT    = E.RespTime(:);
%

rem = isnan(Resp);

Resp(rem)  = [];
Words(rem) = [];
RT(rem)    = [];

%

WD = Words == 7 | Words == 8;
BD = Words == 9;

SW = Words <=6;


%

WD_Hits    = mean(~Resp(WD))
BD_Hits    = mean(~Resp(BD))
FalseAlarm = mean(~Resp(SW))

%%

WD_RT    = RT(~Resp(WD));
BD_RT    = RT(~Resp(BD));
SW_RT    = RT(logical(Resp(SW)));

%%
median(SW_RT)
median(WD_RT)
median(BD_RT)

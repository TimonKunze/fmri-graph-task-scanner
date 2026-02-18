function [ E ] = GetKeyResp( E, w )

starttime = GetSecs;

resp = nan; %initializes flag to indicate no response
% stimStart = tic;
while    ((GetSecs-starttime) < (E.Stim.BlankTime(E.times.BlockCounter,w)/1000)); 
    % So from stimulus onset to the next trial takes between 4-6 seconds!
    
    resp = giveans(E.keys.c_ans1key, E.keys.c_ans2key, resp);
    

    if ~isnan(resp)
        E.Resp(E.times.BlockCounter,w)     = resp;
        E.RespTime(E.times.BlockCounter,w) = GetSecs-starttime;
        E.Timings(3,w) = GetSecs - E.begintime;
        % E.Stim.DebugTimings(5,w) = toc(stimStart);
        % delayStart = tic;


        WaitSecs(E.Stim.DelayTime(E.times.BlockCounter,w)/1000);
        Screen('Flip', E.screen.theWindow);
        % E.Stim.DebugTimings(3,w) = toc(delayStart);
        E.Timings(4,w) = GetSecs - E.begintime;

        % blankStart = tic;
        % If you  need to wait min 4 seconds after response:
        %WaitSecs(E.Stim.BlankTime(E.times.BlockCounter,w)/1000);

        % If the SOA from stimulus onset is min 4 seconds:
        WaitSecs(E.Stim.BlankTime(E.times.BlockCounter,w)/1000 - E.RespTime(E.times.BlockCounter,w) - E.Stim.DelayTime(E.times.BlockCounter,w)/1000);
        
        % E.Stim.DebugTimings(4,w) = toc(blankStart);
        % WaitSecs(E.times.WaitAfterResponse);
        break
    end
end

%% Auxiliary functions
function response = giveans(key1,key2,response) % key response a the force choice task
[~, ~, keyCode, ~] = KbCheck;
if any(keyCode)
    key = find(keyCode);
    K1 = repmat(key1,numel(key),1)==repmat(key',1,numel(key1));
    K2 = repmat(key2,numel(key),1)==repmat(key',1,numel(key2));
    if any(any(K1)); response = 0;
    elseif any(any(K2)); response = 1;
    end
end
end
end
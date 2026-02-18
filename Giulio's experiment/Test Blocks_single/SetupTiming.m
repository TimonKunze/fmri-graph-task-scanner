
E.times.NBlocks = 1; % Number of Blocks
E.times.NWords  = 84; % Max is 200

% Blocks
E.times.RespT     = 2; % time to give response
E.times.ISI       = 0.5; % Actual ISI is this plus rand from 0 to .5.
E.times.ISIJitter = 0.5;

E.times.Break     = 60; % Break between blocks
E.times.CountDown = 10; % Break between blocks countdown

% Waiting time after a response has been made
% E.times.WaitAfterResponse = .250;

% Block Counter
E.times.BlockCounter = 1;

% Answers deviant blocks
E.Resp     = nan(E.times.NBlocks,E.times.NWords);
E.RespTime = nan(E.times.NBlocks,E.times.NWords);

% Trial timings
% We want to record the timings for the presentation of:
% 1. Fixation cross
% 2. Stimulus onset
% 3. Response
% 4. Stimulus offset
E.Timings  = repmat(999,4, E.times.NWords);

E.DebugTimings  = nan(E.times.NWords, 3);

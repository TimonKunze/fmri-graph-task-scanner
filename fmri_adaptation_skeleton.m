function E = fmri_adaptation_skeleton()
% Minimal fMRI adaptation task skeleton (Psychtoolbox)
% Logic mirrors the existing scanner task:
% 1) collect subject info, 2) preload trial schedule, 3) wait scanner trigger,
% 4) run timed trial loop, 5) save outputs, 6) cleanup on success/error.

% ---------- Session metadata ----------
E.exp_name = 'fMRI_Adaptation_Skeleton';
E = get_subject_info(E);
E.filename = sprintf('%s-S%s-B%d-%s', E.exp_name, E.sbj.id, E.sbj.block, datestr(now, 'dd-mmm-yyyy_HH-MM-SS'));

% ---------- Defaults ----------
E.nTrials = 60;
E.dummyScanSec = 12;
E.totalRunSec = 500;          % optional fixed run cap
E.triggerKeyName = '5%';      % scanner trigger pulse
E.abortKeyName = 'Escape';
E.startKeyNames = {'3#','4$'}; % button-box keys for "ready to start"
E.respKeyNames = {'3#','4$'};  % response keys (adapt/change)

% ---------- Pre-allocate logging ----------
E.Log.fixOnset = nan(E.nTrials,1);
E.Log.stimOnset = nan(E.nTrials,1);
E.Log.keyTime = nan(E.nTrials,1);
E.Log.stimOffset = nan(E.nTrials,1);
E.Log.resp = nan(E.nTrials,1);
E.Log.rt = nan(E.nTrials,1);
E.Log.trialType = strings(E.nTrials,1); % "adapt" / "deviant"
E.Log.stimId = strings(E.nTrials,1);

% ---------- Trial schedule (replace with your real design loader) ----------
E.Design = make_demo_design(E.nTrials);

% ---------- Output dir ----------
p_data = fullfile(pwd, 'Data');
if ~exist(p_data, 'dir'); mkdir(p_data); end

try
    % ---------- Hardware ----------
    KbName('UnifyKeyNames');
    E.keys.trigger = KbName(E.triggerKeyName);
    E.keys.abort = KbName(E.abortKeyName);
    E.keys.start = cellfun(@KbName, E.startKeyNames);
    E.keys.resp = cellfun(@KbName, E.respKeyNames);

    Screen('Preference', 'SkipSyncTests', 1);
    screenN = max(Screen('Screens'));
    bg = [100 100 100];
    [win, ~] = PsychImaging('OpenWindow', screenN, bg);
    E.win = win;
    E.textColor = [0 0 0];
    E.textSize = 28;
    Screen('TextSize', E.win, E.textSize);
    Screen('BlendFunction', E.win, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    HideCursor;
    ListenChar(2);

    % ---------- Instructions ----------
    instr = ['fMRI adaptation task\n\n' ...
             'Press one key to continue.\n' ...
             'Task starts only after scanner trigger.'];
    DrawFormattedText(E.win, instr, 'center', 'center', E.textColor);
    Screen('Flip', E.win);
    wait_for_any(E.keys.start, E.keys.abort);

    % ---------- Trigger gate ----------
    DrawFormattedText(E.win, 'Waiting for scanner trigger...', 'center', 'center', E.textColor);
    Screen('Flip', E.win);
    wait_for_trigger(E.keys.trigger, E.keys.abort);
    E.runStart = GetSecs;
    WaitSecs(E.dummyScanSec);

    % ---------- Trial loop ----------
    for t = 1:E.nTrials
        % Fixation onset
        DrawFormattedText(E.win, '+', 'center', 'center', E.textColor);
        Screen('Flip', E.win);
        E.Log.fixOnset(t) = GetSecs - E.runStart;
        WaitSecs(E.Design.fixSec(t));

        % Stimulus onset (placeholder text; replace with image/texture draw)
        stimLabel = sprintf('%s | %s', E.Design.trialType(t), E.Design.stimId(t));
        DrawFormattedText(E.win, stimLabel, 'center', 'center', E.textColor);
        Screen('Flip', E.win);
        E.Log.stimOnset(t) = GetSecs - E.runStart;
        E.Log.trialType(t) = E.Design.trialType(t);
        E.Log.stimId(t) = E.Design.stimId(t);

        % Collect response within blank window and preserve planned SOA
        [resp, rt, keyTs] = collect_response(E.Design.blankSec(t), E.keys.resp, E.keys.abort);
        E.Log.resp(t) = resp;
        E.Log.rt(t) = rt;
        if ~isnan(keyTs)
            E.Log.keyTime(t) = keyTs - E.runStart;
            WaitSecs(E.Design.delaySec(t));
            Screen('Flip', E.win);
            E.Log.stimOffset(t) = GetSecs - E.runStart;
            remaining = E.Design.blankSec(t) - rt - E.Design.delaySec(t);
            if remaining > 0; WaitSecs(remaining); end
        else
            Screen('Flip', E.win);
            E.Log.stimOffset(t) = GetSecs - E.runStart;
        end

        check_abort(E.keys.abort);
    end

    % ---------- Optional fixed run end ----------
    elapsed = GetSecs - E.runStart;
    if elapsed < E.totalRunSec
        WaitSecs(E.totalRunSec - elapsed);
    end

    % ---------- Save outputs ----------
    save(fullfile(p_data, [E.filename '.mat']), 'E');
    T = table( ...
        repmat(string(E.sbj.id), E.nTrials, 1), ...
        repmat(E.sbj.block, E.nTrials, 1), ...
        (1:E.nTrials)', ...
        E.Log.trialType, ...
        E.Log.stimId, ...
        E.Log.resp, ...
        E.Log.rt, ...
        E.Log.fixOnset, ...
        E.Log.stimOnset, ...
        E.Log.keyTime, ...
        E.Log.stimOffset, ...
        'VariableNames', {'Subject','Block','Trial','TrialType','Stimulus','Response','RT','FixOnset','StimOnset','KeyPressed','StimOffset'});
    writetable(T, fullfile(p_data, [E.filename '_results.csv']));

    % ---------- End ----------
    DrawFormattedText(E.win, 'Run complete. Thank you.', 'center', 'center', E.textColor);
    Screen('Flip', E.win);
    WaitSecs(1.5);
    cleanup();

catch err
    E.err = err;
    crashDir = fullfile(pwd, 'Crashed');
    if ~exist(crashDir, 'dir'); mkdir(crashDir); end
    save(fullfile(crashDir, [E.filename '_crashed.mat']), 'E');
    cleanup();
    rethrow(err);
end

end

% ---------- Helpers ----------
function E = get_subject_info(E)
prompt = {'Subject ID:', 'Block:'};
defaults = {'99', '1'};
a = inputdlg(prompt, 'Subject Info', 1, defaults);
if isempty(a); error('User cancelled subject dialog.'); end
E.sbj.id = strtrim(a{1});
E.sbj.block = str2double(a{2});
if isnan(E.sbj.block); error('Block must be numeric.'); end
end

function D = make_demo_design(nTrials)
% Replace this with loading your real adaptation schedule from .mat/.csv.
rng('shuffle');
D.fixSec = 0.5 + 0.5 * rand(nTrials,1);     % jittered fixation
D.delaySec = 0.2 * ones(nTrials,1);         % post-response display delay
D.blankSec = 2.5 * ones(nTrials,1);         % response/blank window

types = repmat(["adapt","deviant"], ceil(nTrials/2), 1);
types = types(1:nTrials);
types = types(randperm(nTrials));
D.trialType = types(:);
D.stimId = "stim_" + string((1:nTrials)');
end

function wait_for_trigger(triggerKey, abortKey)
while true
    [~, ~, keyCode] = KbCheck;
    if keyCode(abortKey); error('Aborted by operator (Escape).'); end
    if keyCode(triggerKey); break; end
end
end

function wait_for_any(validKeys, abortKey)
while true
    [~, ~, keyCode] = KbCheck;
    if keyCode(abortKey); error('Aborted by operator (Escape).'); end
    if any(keyCode(validKeys)); break; end
end
end

function [resp, rt, keyTs] = collect_response(maxSec, respKeys, abortKey)
startT = GetSecs;
resp = nan;
rt = nan;
keyTs = nan;
while (GetSecs - startT) < maxSec
    [secs, ~, keyCode] = KbCheck;
    if keyCode(abortKey); error('Aborted by operator (Escape).'); end
    if keyCode(respKeys(1))
        resp = 0; rt = secs - startT; keyTs = secs; return;
    elseif keyCode(respKeys(2))
        resp = 1; rt = secs - startT; keyTs = secs; return;
    end
end
end

function check_abort(abortKey)
[~, ~, keyCode] = KbCheck;
if keyCode(abortKey); error('Aborted by operator (Escape).'); end
end

function cleanup()
Screen('CloseAll');
ShowCursor;
ListenChar(0);
Priority(0);
end



%words = randi(18,300,1);
clear h

w = 60;

for n = 1:length(words)-w
    h(n,:) =    hist(words(n:n+(w-1)),unique(words))/w;
    %h(n,:) = IntHist(words(n:n+(w-1)),max(words))/w;
end

% figure
% subplot(2,1,1)
% plot([mean(h(:,1:6),2),mean(h(:,7:8),2)])
% axis([1 length(h) 0 .2])

%subplot(2,1,2)
%hold on
figure;plot(h(:,1:18),'k')
%plot(h(:,7:8),'r')
axis([1 length(h) 0 .3])


%%

close all
clear h

w = 50;

for n = 1:length(words)-w
    h(n,:) = hist(words(n:n+(w-1)),numel(unique(words)))/w;
end


subplot(2,1,1)
plot([mean(h(:,1:6),2)])
axis([1 length(h) 0 .2])

subplot(2,1,2)
hold on
plot(h(:,1:6),'k')
axis([1 length(h) 0 .3])

%% BIGRAMS

close all
clear h

w = 50;

for n = 1:length(words)-w
    h(n,:) = hist(words(n:n+(w-1)),numel(unique(words)))/w;
end


subplot(2,1,1)
plot([mean(h(:,1:size(h,2)),2)])
axis([1 length(h) 0 .2])

subplot(2,1,2)
hold on
plot(h(:,1:size(h,2)),'k')
axis([1 length(h) 0 .3])

%% CHARACTERS

close all
clear h

w = 50;

for n = 1:length(words)-w
    h(n,:) = hist(words(n:n+(w-1)),numel(unique(words)))/w;
end


subplot(2,1,1)
plot([mean(h(:,1:size(h,2)),2)])
axis([1 length(h) 0 .2])

subplot(2,1,2)
hold on
plot(h(:,1:size(h,2)),'k')
axis([1 length(h) 0 .3])

function [] = genRandomWordClouds(mdl)
figure;
hold on
for i = 1:6
    topicIdx = randi(mdl.NumTopics);
    subplot(3,2,i)
    wordcloud(mdl,topicIdx);
    title("Topic " + topicIdx)
end


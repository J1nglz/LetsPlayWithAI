function [numOfTopics] = getNumOfTopics(documentsIn,percentHoldOut)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
clearvars -except documents textAdditions textData bag

numDocuments = numel(documentsIn);
cvp = cvpartition(numDocuments,'HoldOut',0.1); %holdout 10% to test with
%documentsTrain = documentsIn(cvp.training);
documentsValidation = documentsIn(cvp.test);
% numTopicsCenter(1) = floor(numDocuments)/2;
% numTopicsStart(1) = floor(numTopicsCenter*0.25);
% numTopicsEnd(1) = 3*floor(numTopicsCenter*0.25);
% numTopicsRange = [numTopicsStart numTopicsCenter numTopicsEnd];
numTopicsRange = [2 5 10 20 50];
for i = 1:numel(numTopicsRange)
    numTopics = numTopicsRange(i);
    
    mdlNew = fitlda(bagNew,numTopics, ...
        'Solver','savb', ...
        'Verbose',0);
    
    [~,validationPerplexity(i)] = logp(mdlNew,documentsValidation);
    timeElapsed(i) = mdlNew.FitInfo.History.TimeSinceStart(end);
end

figure
yyaxis left
plot(numTopicsRange,validationPerplexity,'+-')
ylabel("Validation Perplexity")

yyaxis right
plot(numTopicsRange,timeElapsed,'o-')
ylabel("Time Elapsed (s)")

legend(["Validation Perplexity" "Time Elapsed (s)"],'Location','southeast')
xlabel("Number of Topics")


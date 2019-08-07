% do a wiki search on a topic
%searchTerm = "Space Shuttle";
clear all
tic; [results] = wikiSearch("Space Shuttle",10); toc;
tic; data = wikiParse(results); toc;
tic; textArray = wikiCompile(data); toc;

% build a model out of the results
 documents = preprocessText(textArray);
 bag = bagOfWords(documents);
 bag = removeInfrequentWords(bag,2);
 bag = removeEmptyDocuments(bag);
 
%[numOfTopics] = getNumOfTopics(documents,0.1,[30:1:45]);
 
%% chose a number of topics and build a model
 numTopics = 43;
 mdl = fitlda(bag,numTopics,'Verbose',0);
%genRandomWordClouds(mdl)
[wordToSearch] = getNearestNoun(mdl,documents,5);
%write this as a function called wikiExpand...aka getsmarter
%need a function in wikisearch that sees if what you looked up is any good
% textArray2 = textArray;
% for i = 1:length(wordToSearch)
%     tic; [results2] = wikiSearch(wordToSearch(i),1); toc;
%     tic; data2 = wikiParse(results2); toc;
%     tic; textArray2 = wikiCompile(data2, textArray2); toc;
% end
 

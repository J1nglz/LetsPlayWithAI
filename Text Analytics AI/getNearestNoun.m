function [wordToSearch] = getNearestNoun(mdl,documents,howMany)
%%
wordTests=mdl.TopicWordProbabilities;
wordTopValues = howMany;
wordTopic = strings(wordTopValues,mdl.NumTopics);
for i = 1:mdl.NumTopics
   %find the most probable words for each topic
   wordIdx = getTopValueIndex(wordTests(:,i),wordTopValues);
   wordTopic(:,i) = mdl.Vocabulary(wordIdx);   
end
% get the unique words from the list
wordUnique=[wordTopic(:)];
wordUnique = normalizeWords(wordUnique,'Style','lemma');
wordUnique=unique(wordUnique);


%tdetails = tokenDetails(documents);
docsNormalized = normalizeWords(documents,'Style','lemma');
tdetails = tokenDetails(docsNormalized);
nouns = tdetails(tdetails.PartOfSpeech=="noun",:);
for i = 1:length(wordUnique)   
    wordDetails = nouns(find(nouns.Token == wordUnique(i)),1);
    if ~isempty(wordDetails)
        wordToSearch(i) = wordDetails.Token(1);
    end
end
wordToSearch = unique(wordToSearch);
wordToSearch = rmmissing(wordToSearch);
end


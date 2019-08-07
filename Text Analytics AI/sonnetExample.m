%Read text from Shakespeare's Sonnets with the fileread function...
%fileread returns the text as a 1-by-100266 character vector.
sonnets = fileread('sonnets.txt');
sonnets(1:35)
%Convert the text to a string using the string function...
%Then, split it on newline characters using the splitlines function.
%sonnets becomes a 2625-by-1 string array, where each string contains
%one line from the poems. Display the first five lines of sonnets.
sonnets = string(sonnets);
sonnets = splitlines(sonnets);
sonnets(1:5)

%Remove the strings with zero characters ("") from the string array. 
TF = (sonnets == 'Lockheed Martin Proprietary Information U. S. EXPORT CONTROLLED INFORMATION');
sonnets(TF) = [];
sonnets(1:10)

%Replace some punctuation marks with space characters. For example, ...
%replace periods, commas, and semi-colons. Keep apostrophes because ... 
%they can be part of some words in the Sonnets, such as light's.
p = [".","?","!",",",";",":"];
sonnets = replace(sonnets,p," ");
sonnets(1:10)

%Strip leading and trailing space characters from each element of sonnets.
sonnets = strip(sonnets);
sonnets(1:10)


%Split sonnets into a string array whose elements are individual words
sonnetWords = strings(0);
for i = 1:length(sonnets)
   sonnetWords = [sonnetWords ; split(sonnets(i))];
end
sonnetWords(1:10)

%Sort Based on Freq
sonnetWords = lower(sonnetWords);
[words,~,idx] = unique(sonnetWords);
numOccurrences = histcounts(idx,numel(words));
%Sort by most common to least
[rankOfOccurrences,rankIndex] = sort(numOccurrences,'descend');
wordsByFrequency = words(rankIndex);

%Plot Word Freq
loglog(rankOfOccurrences);
xlabel('Rank of word (most to least common)');
ylabel('Number of Occurrences');


numOccurrences = numOccurrences(rankIndex);
numOccurrences = numOccurrences';
numWords = length(sonnetWords);
T = table;
T.Words = wordsByFrequency;
T.NumOccurrences = numOccurrences;
T.PercentOfText = numOccurrences / numWords * 100.0;
T.CumulativePercentOfText = cumsum(numOccurrences) / numWords * 100.0;
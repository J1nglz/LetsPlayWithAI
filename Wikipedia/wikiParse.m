function [data] = wikiParse(results)

% process into documents
% pageIdentifier = '(?<=([\r\n]{3}[=]{4}\s))([\w\s])+(?=(\s[=]{4}[\r\n]))';
% finds ==== Crew Compartment ====

dataName = strings(size(results,1),1);
for j = 1:size(results,1)
    dataName(j) = strrep(results{j,1},' ','');
    data.(dataName(j)).raw = results(j,2);
    pageIdentifier = '(?<=([=]{2,4}))([a-zA-Z_0-9 ['']\-\,\.\:\>\<\\\/\?\)\(\[\]])+(?=([=]{2,4}))';
    [pages] = text2pages(results(j,2),pageIdentifier);


for i = 1:length(pages)
	pages(i).name = strtrim(pages(i).name);
    rgxName = ['\s(' char(pages(i).name) ')\s[=]{2,}'];
	pages(i).text = regexprep(pages(i).text,rgxName,'');
    rgxEquals = '[\r\n\s]+[=]+';
    pages(i).text = regexprep(pages(i).text,rgxEquals,'');
    pages(i).text=strtrim(pages(i).text);
    pageTest(i)=isempty((regexp(pages(i).text,'(?![=])(.)')));
end

pages(pageTest)=[];
clear pageTest
%for k = 1:length(pages)
    data.(dataName(j)).pages=cellArray2stringArray(extractfield(pages,'text'));
%end
end

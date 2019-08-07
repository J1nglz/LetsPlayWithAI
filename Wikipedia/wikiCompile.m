function [textData] = wikiCompile(varargin)
%% arg1 = data structure arg2 =textdata 
% This function takes in currently existing textString array and adds the wikipedia data structure to the end
% if it does not have a textData input it starts with the first 
data=varargin{1};
fnames = fieldnames(data);
%figure out a way to test for duplicate data
if nargin<2
    textTemp = extractfield(data.(fnames{1}),'pages');
    textData = textTemp{:};
    ii = 2;
else
    textData=varargin{2};
    ii = 1;
end
    textSto = textData;
    
for i = ii:length(fnames)
    textTemp = extractfield(data.(fnames{i}),'pages');
    textSto(end+1:end+length(textTemp{:}),1) = textTemp{:};
end
textData = textSto;
end


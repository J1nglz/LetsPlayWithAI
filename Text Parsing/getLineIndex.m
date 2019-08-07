function [ind] = getLineIndex(inputStrArray,inputRegExp)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if isstring(inputRegExp)
    %remove parentheses they screw everything up
    inputStrArray=strrep(inputStrArray,'(','');
    inputStrArray=strrep(inputStrArray,')','');
    inputRegExp=strrep(inputRegExp,'(','');
    inputRegExp=strrep(inputRegExp,')','');
    inputStrArray=strrep(inputStrArray,' ','');
    inputRegExp=strrep(inputRegExp,' ','');
    inputStrArray = strtrim(inputStrArray);
    inputRegExp = strtrim(inputRegExp);
end
    if length(inputStrArray)<2
        ind = regexp(inputStrArray,inputRegExp);
    else
        ind(1,:) = find(~cellfun(@isempty,regexp(inputStrArray,inputRegExp)));
    end
end


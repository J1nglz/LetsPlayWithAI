function [pages] = text2pages(flatText,pageIdentifier)
%% This function takes a string array and divides it into individual pages identified by a unique page number identifier
% It then returns a data structure containing the pages, starting index of
% the page and text per page.
%rgexp = '^\d{1,3}\s(?!(\d+|\w+))';
%rgexp = '^\d{1,3}\s(?!\S)'; %just the 1-3 numbers followed by a space then nothing else
%pageIdentifier = '^(Page)\s\d{1,4}\s(of)\s\d{1,4}'; %for Page XXXX of XXXX
%match = regexp(flatText,pageIdentifier,'dotexceptnewline','match');
[names,pageIdx] = regexp(flatText,pageIdentifier,'match');
if iscell(pageIdx)
    match = cellfun('isempty',pageIdx);
    names = cellArray2stringArray(names);
    pageIdx=find(~match);
end

%if this has a problem with flatText being array out of bounds it is
%because you have to do flatText{1}(start:end) fix this later if it gives
%you a problem

    for i = 1:length(pageIdx)
        pages(i).pageNo = i;
        pages(i).name = names(i);
        pages(i).idx = pageIdx(i);
        if i == length(pageIdx)
            start = pageIdx(i);
            pages(i).text = flatText{1}(start:end);
        else
            start = pageIdx(i);    %2 lines of header
            finish = pageIdx(i+1); %12 lines of footer
            pages(i).text = flatText{1}(start:finish);           
        end
    end
end


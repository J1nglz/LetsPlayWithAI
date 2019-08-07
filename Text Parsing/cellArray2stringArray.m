function [outputString] = cellArray2stringArray(inputCell)
%cell array to string array
%cell array to string array
%tcvap=DPCReqs.VerificationApproach(1:28);
%tcvap=cellstr(tcvap(:))
%tcvapr=strings(size(tcvap));
%[tcvapr{:}] = tcvap{:}
if iscell(inputCell)
    %inputCell=extractCells(inputCell);
    %empties = find(cellfun('isempty',inputCell));
    inputCell=extractCells(inputCell);
    idx=1;
    for i = 1:length(inputCell)
        if iscell(inputCell{i})||isempty(inputCell{i})
            inputCell{i} = "blank";
            idx(end+1) = i;
        elseif numel(inputCell{i})>1
            inputCell{i} = join(inputCell{i});
        end
    end
    idx=idx(2:end);
    
    %inputCell{empties} = 'blank';
    inputCell=cellstr(inputCell(:));

    outputString=strings(size(inputCell));
    [outputString{:}] = inputCell{:};
    outputString(idx) = ''; 

else
    inputCell = cellstr(inputCell);
    outputString=strings(size(inputCell));
    [outputString{:}] = inputCell{:};
end

outputString=strtrim(outputString);



end


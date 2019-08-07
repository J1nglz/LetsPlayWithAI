function [idxTop] = getTopValueIndex(inputMatrix,numOfTopValues)
%UNTITLED3 Summary of this function goes here
    topMatrix = zeros(length(inputMatrix),2);
    topMatrix(1:end,1) = [1:length(inputMatrix(:,1))];
    topMatrix(:,2) = inputMatrix(:,1);
    topMatrix = sortrows(topMatrix,[2 1],{'descend'});
    idxTop = topMatrix(1:numOfTopValues);
end


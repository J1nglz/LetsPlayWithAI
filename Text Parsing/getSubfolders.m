function [subFolders,subFiles] = getSubfolders(dirLoc)
%UNTITLED4 Summary of this function goes here

% names = DPCVVMFinalBrewer.ReqID;
%     for i=1:length(names)
%        mkdir([dirLoc '\' names{i} '\']);
%     end
% Get a list of all files and folders in this folder.
files = dir(dirLoc);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
subFiles = files(~dirFlags);
% Get rid of the .. and . tags
subFolders = subFolders(cellfun(@(x) isempty(x), regexp(extractfield(subFolders,'name'),'^[.]{1,2}'),'UniformOutput',1));
for i = 1 : numel(subFolders)
    subContents=dir(string(subFolders(i).folder) + '\' + string(subFolders(i).name));
    subContents = subContents(cellfun(@(x) isempty(x), regexp(extractfield(subContents,'name'),'^[.]{1,2}'),'UniformOutput',1));
    subFolders(i).content = subContents;    
end




function words = load_lexicon(filename) 
%LOAD_LEXICON loads sentiment lexicon
%   Lexicon is available at https://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html#lexicon
    fid=fopen(filename);                             % open file
    tline = fgetl(fid);                              % get new line
    words = string({});                              % accumlate words
    while ischar(tline)                              % while new line is available
        if ~startsWith(tline,';') && ...             % if doesn't start with semicolon
                ~isempty(tline)                      % or is not empty
            words(end+1,1) = tline;                  % add words
        end
        tline = fgetl(fid);                          % get next line
    end
    fclose(fid);                                     % close file
end

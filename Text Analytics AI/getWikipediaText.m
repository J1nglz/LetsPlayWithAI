function [str,status] = getWikipediaText(url)
%url = "https://en.wikipedia.org/wiki/Ground_(electricity)";
%https://en.wikipedia.org/wiki/Electrical_resistance_and_conductance

    data = webread(url);
    hasWikibase = regexp(data,'(?<=((Number of Wikibase entities loaded)[:]\s))\d*(?=(\/\d*))','match');    
    hasDisambig = regexp(data,'(Template)\:(Disambig)');
    %This is used for testing
    %databad = webread("https://en.wikipedia.org/wiki/atm");
    %commentsbad = regexp(databad,'(?<=([<][!][-]{2}))[a-zA-Z_0-9 -.:\r\n\[\]\\\/\?]+(?!([->]))','match');
    %commentsString = string(join(comments));
    %hasWikibase = regexp(commentsString,'(?<=((Number of Wikibase entities loaded)[:]\s))\d*(?=(\/\d*))','match');    
    if ~isempty(hasWikibase)
        hasWikibase = str2double(hasWikibase{:});
    else
        hasWikibase =0;
    end
        
        %hasDisambig = regexp(commentsString,'(Template)\:(Disambig)');
    
    if hasWikibase>0&&isempty(hasDisambig)
        %data from the website is valid
        tree = htmlTree(data);
        singleDef=findElement(tree,"p:first-of-type");
        definition = extractHTMLText(singleDef);
        subtrees = findElement(tree,'p');
        str = extractHTMLText(subtrees);   
        status = 1;
    else
        str = "Ambiguous";
        status = 0;
    end


end


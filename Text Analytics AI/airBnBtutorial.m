opts = detectImportOptions('listings.csv');
l = readtable('listings.csv',opts);
reviews = readtable('reviews.csv');
comments = tokenizedDocument(reviews.comments);
comments = lower(comments);
comments = removeWords(comments,stopWords);
comments = removeShortWords(comments,2);
comments = erasePunctuation(comments);

% == uncomment to generate a word cloud ==
% bag = bagOfWords(comments);
% figure
% wordcloud(bag);
% title('AirBnB Review Word Cloud')

% Generate a Bigram Word Cloud
f = @(s)s(1:end-1) + " " + s(2:end);
bigrams = docfun(f,comments);
bag2 = bagOfWords(bigrams);
figure
wordcloud(bag2);
title('AirBnB Review Bigram Cloud')

figure
histogram(l.review_scores_rating)
title('Distribution of AirBnB Review Ratings')
xlabel('Review Ratings')
ylabel('# Listings')

% Score the reviews
f = @(str) sent.scoreText(str);
reviews.sentiment = cellfun(f,reviews.comments);

% Calculate the median review score by listing
[G,listings] = findgroups(reviews(:,'listing_id'));
listings.sentiment = splitapply(@median, ...
    reviews.sentiment,G);

% Visualize the results
figure
histogram(listings.sentiment)
title('Sentiment by Boston AirBnB Listing')
xlabel('Median Sentiment Score')
ylabel('Number of Listings')

% Join sentiment scores and listing info
joined = innerjoin( ...
    listings,l(:,{'id','latitude','longitude', ...
    'neighbourhood_cleansed'}), ...
    'LeftKeys','listing_id','RightKeys','id');
joined.Properties.VariableNames{end} = 'ngh';

% Discard listings with a NaN sentiment score
joined(isnan(joined.sentiment),:) = [];

% Discretize the sentiment scores into buckets
joined.cat = discretize(joined.sentiment,0:0.25:1, ...
    'categorical',{'< 0.25','< 0.50','< 0.75','<=1.00'});

% Remove undefined categories
cats = categories(joined.cat);
joined(isundefined(joined.cat),:) = [];

% Variable for color
colorlist = winter(length(cats));

% Generate the plot
latlim = [42.300 42.386];
lonlim = [-71.1270 -71.0174];
load boston_map.mat
figure
imagesc(lonlim,latlim, map)
hold on
gscatter(joined.longitude,joined.latitude,joined.cat,colorlist,'o')
hold off
dar = [1, cosd(mean(latlim)), 1];
daspect(dar)
set(gca,'ydir','normal');
axis([lonlim,latlim])
title('Sentiment Scores by Boston Airbnb Listing')
[g,ngh] = findgroups(joined(:,'ngh'));
ngh.Properties.VariableNames{end} = 'name';
ngh.lat = splitapply(@mean,joined.latitude,g);
ngh.lon = splitapply(@mean,joined.longitude,g);

% Annotations
text(ngh.lon(2),ngh.lat(2),ngh.name(2),'Color','w')
text(ngh.lon(4),ngh.lat(4),ngh.name(4),'Color','w')
text(ngh.lon(6),ngh.lat(6),ngh.name(6),'Color','w')
text(ngh.lon(11),ngh.lat(11),ngh.name(11),'Color','w')
text(ngh.lon(13),ngh.lat(13),ngh.name(13),'Color','w')
text(ngh.lon(17),ngh.lat(17),ngh.name(17),'Color','w')
text(ngh.lon(18),ngh.lat(18),ngh.name(18),'Color','w')
text(ngh.lon(22),ngh.lat(22),ngh.name(22),'Color','w')
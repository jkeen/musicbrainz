# 0.8.0 (April 23, 2017) ##

*   Increases coverage of MusicBrainz API and replaces bindings by Music Brainz XSL schema transformation mapper.
*   TrackSearch renamed to RecordingSearch.
*   Find Recording by Release ID.
*   Artist#release_groups supports :offset param.
*   Adds :limit and :offset params to Recording search.
*   Adds :offset option for ReleaseGroup search.
*   Improves artist search and search everywhere and not only in artist name field.
*   extra_query option for MusicBrainz::Artist#release_groups.
*   Find Disc by Disc ID.

# 0.7.7 (December 1, 2014) ##

*   Handle nil values returned from Base model search at Artist#find_by_name and ReleaseGroup#find_by_artist_and_title [#24]

# 0.7.6 (June 14, 2013) ##

*   Improves urls attribute to return an array if there are multiple urls for a relation type. [#19]

# 0.7.5 (May 6, 2013) ##

*   Created new track_search binding to allow searching for tracks. [#18]
*   Adds release group urls. [#17]

# 0.1.0 (July 18, 2011) ##

*   Initial version.

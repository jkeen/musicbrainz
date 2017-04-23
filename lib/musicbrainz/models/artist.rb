module MusicBrainz
  class Artist < BaseModel
    include Mapper::Resources::Artist
    
    xml_accessor :mbid, from: '@id' # deprecated
    
    # user_tags user_ratings
    INCLUDES = %w(release_groups releases works recordings aliases tags ratings discids media puids isrcs artist_credits various_artists annotation url_rels artist_rels label_rels recording_rels release_rels release_group_rels work_rels)
    
    def release_groups(options = {})
      return @release_groups if @release_groups || @id.nil? || do_not_search
      
      params = {
        artist: id,
        inc: (options.has_key?(:inc) ? options[:inc] : [:url_rels, :artist_credits]),
        limit: (options.has_key?(:limit) ? options[:limit] : 100),
        offset: (options.has_key?(:offset) ? options[:offset] : 0) }
      
      client.find('MusicBrainz::ReleaseGroup', params)
    end
    
    class << self
      def search(name)
        name = CGI.escape(name).gsub(/\!/, '\!')
        client.search(to_s, "\"#{name}\"", create_models: false)
      end

      def discography(mbid)
        artist = find(mbid)
        artist.release_groups.each { |rg| rg.releases.each { |r| r.tracks } }
        artist
      end

      def find_by_name(name)
        matches = search(name)
        if matches and not matches.empty?
          find(matches.first[:id])
        end
      end
    end
  end
end

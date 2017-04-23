require 'digest/sha1'
require 'fileutils'

require 'faraday'
require 'roxml'
require File.expand_path('../vendor_extensions/roxml', File.dirname(__FILE__))
require 'rexml/document'

require 'musicbrainz/version'
require 'musicbrainz/deprecated'
require 'musicbrainz/middleware'
require 'musicbrainz/configuration'

# ClientModules
require 'musicbrainz/client_modules/transparent_proxy'
require 'musicbrainz/client_modules/failsafe_proxy'
require 'musicbrainz/client_modules/caching_proxy'
require 'musicbrainz/client'

# Mapper
require 'musicbrainz/mapper/entity'
require 'musicbrainz/mapper/list'
require 'musicbrainz/mapper/search_result'

require 'musicbrainz/mapper/generator/base'
require 'musicbrainz/mapper/generator/model'
require 'musicbrainz/mapper/generator/resource'

require 'musicbrainz/mapper/resources/artist'
require 'musicbrainz/mapper/resources/release'
require 'musicbrainz/mapper/resources/release_group'
require 'musicbrainz/mapper/resources/recording'
require 'musicbrainz/mapper/resources/label'
require 'musicbrainz/mapper/resources/work'
require 'musicbrainz/mapper/resources/track'

require 'musicbrainz/mapper/resources/url'
require 'musicbrainz/mapper/resources/disc'
require 'musicbrainz/mapper/resources/puid'
require 'musicbrainz/mapper/resources/isrc'
require 'musicbrainz/mapper/resources/name_credit'
require 'musicbrainz/mapper/resources/relation'
require 'musicbrainz/mapper/resources/alias'
require 'musicbrainz/mapper/resources/tag'
require 'musicbrainz/mapper/resources/user_tag'
require 'musicbrainz/mapper/resources/rating'
require 'musicbrainz/mapper/resources/label_info'
require 'musicbrainz/mapper/resources/medium'
require 'musicbrainz/mapper/resources/annotation'
require 'musicbrainz/mapper/resources/cdstub'
require 'musicbrainz/mapper/resources/freedb_disc'
require 'musicbrainz/mapper/resources/nonmb_track'
require 'musicbrainz/mapper/resources/collection'
require 'musicbrainz/mapper/resources/cover_art_archive'

# Models
require 'musicbrainz/models/base_model'

require 'musicbrainz/models/annotation'
require 'musicbrainz/models/rating'
require 'musicbrainz/models/cover_art_archive'

require 'musicbrainz/models/artist'
require 'musicbrainz/models/name_credit'
require 'musicbrainz/models/concerns/artist_name'
require 'musicbrainz/models/release_group'
require 'musicbrainz/models/release'
require 'musicbrainz/models/recording'
require 'musicbrainz/models/label'
require 'musicbrainz/models/work'
require 'musicbrainz/models/track'

require 'musicbrainz/models/url'
require 'musicbrainz/models/disc'
require 'musicbrainz/models/puid'
require 'musicbrainz/models/isrc'
require 'musicbrainz/models/relation'
require 'musicbrainz/models/alias'
require 'musicbrainz/models/tag'
require 'musicbrainz/models/user_tag'
require 'musicbrainz/models/label_info'
require 'musicbrainz/models/medium'
require 'musicbrainz/models/cdstub'
require 'musicbrainz/models/freedb_disc'
require 'musicbrainz/models/nonmb_track'
require 'musicbrainz/models/collection'

module MusicBrainz
  GH_PAGE_URL = 'http://git.io/brainz'

  module Configurable
    def configure
      raise Exception.new("Configuration block missing") unless block_given?
      yield @config ||= MusicBrainz::Configuration.new
      config.valid?
    end

    def config
      raise Exception.new("Configuration missing") unless instance_variable_defined?(:@config)
      @config
    end

    def apply_test_configuration!
      configure do |c|
        c.app_name = "gem musicbrainz (development mode)"
        c.app_version = MusicBrainz::VERSION
        c.contact = `git config user.email`.chomp
      end
    end
  end

  extend Configurable

  module ClientHelper
    def client
      @client ||= Client.new
    end
  end

  extend ClientHelper
end

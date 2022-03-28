# frozen_string_literal: true

require 'json'
require 'net/http'
require 'thor'
require 'yaml'

# Service for renaming tv show filenames in a way that is friendly with Plex
class PlexTvToolService
  attr_reader :dir, :episodes, :title, :season

  def initialize(dir, options)
    @dir = dir
    @title = options[:title]
    @season = options[:season]
    @episodes = fetch_episodes
  end

  def rename_files!
    sort_and_rename!
  rescue StandardError => e
    puts e.message
    puts e.backtrace.inspect
  end

  class << self
    def load_config
      config_path = File.join File.dirname(__FILE__), 'config.yml'
      YAML.safe_load File.read(config_path)
    end

    def write_config!(config)
      File.open(File.join(File.dirname(__FILE__), 'config.yml'), 'w') do |f|
        YAML.dump config, f
      end
    end
  end

  private

  def fetch_episodes
    api_key, base_uri = api_params
    params = { t: title, Season: season, apikey: api_key }
    uri = URI base_uri
    uri.query = URI.encode_www_form params
    response = Net::HTTP.get_response uri
    raise 'Bad response from OMDB API' unless response.is_a? Net::HTTPSuccess

    body = JSON.parse response.body
    check_response body
    body['Episodes']
  end

  def check_response(response)
    return unless response['Response'] == 'False'

    puts "Error response from OMDB API: #{response['Error']}"
    exit 1
  end

  def api_params
    loaded_config = self.class.load_config
    [loaded_config.dig('plextvt', 'omdb', 'api_key'),
     loaded_config.dig('plextvt', 'omdb', 'base_uri')]
  end

  def sort_and_rename!
    files = Dir.glob("#{dir}/*").sort
    files.zip(episodes).each do |file, episode|
      new_name = format_new_name(file, episode)
      print "Renaming #{File.basename(file)} to #{new_name} ... "
      File.rename(file, "#{dir}/#{new_name}")
      puts 'DONE'
    end
  end

  def format_new_name(file, episode)
    new_name = "#{title} s#{season.to_s.rjust(2, '0')}"\
      "e#{episode['Episode'].rjust(2, '0')} #{episode['Title']}#{File.extname(file)}"
    new_name.tr('<>:"/\\|?*', '') # Invalid chars for ntfs
  end
end

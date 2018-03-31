require 'digest/md5'

class MarvelService
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def characters_list
    parse_json.map do |character|
      Character.new({
        name: character[:name],
        description: character[:description],
        image: character[:thumbnail]
      })
    end
  end

  private
    def auth_hash
      timestamp = Time.now.to_s
      { ts: timestamp,
        ts_key_hash: Digest::MD5.hexdigest(timestamp + ENV['marvel_private_key'] + ENV['marvel_public_key']) }
    end

    def characters_url
      Faraday.get("http://gateway.marvel.com/v1/public/characters?nameStartsWith=#{@name}&apikey=#{ENV['marvel_public_key']}&hash=#{auth_hash[:ts_key_hash]}&ts=#{auth_hash[:ts]}")
    end

    def parse_json
      JSON.parse(characters_url.body, symbolize_names: true)[:data][:results]
    end

    def auth_hash
      timestamp = Time.now.to_s
      { ts: timestamp,
        ts_key_hash: Digest::MD5.hexdigest(timestamp + ENV['marvel_private_key'] + ENV['marvel_public_key']) }
    end
end

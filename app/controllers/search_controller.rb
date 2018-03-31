require 'digest/md5'

class SearchController < ApplicationController
  def index
    ts = Time.now.to_s
    hash = Digest::MD5.hexdigest(ts + ENV['marvel_private_key'] + ENV['marvel_public_key'])
    response = Faraday.get("http://gateway.marvel.com/v1/public/characters?nameStartsWith=#{params[:name]}&apikey=#{ENV['marvel_public_key']}&hash=#{hash}&ts=#{ts}")
    json = JSON.parse(response.body, symbolize_names: true)

    @characters = json[:data][:results].map do |character|
      attrs = { name: character[:name],
                description: character[:description],
                image: character[:thumbnail] }

      Character.new(attrs)
    end
  end
end

class Character
  attr_reader :name, :description, :image

  def initialize(attrs)
    @name = attrs[:name]
    @description = attrs[:description]
    @image = format_image_path(attrs[:image])
  end

  def format_image_path(image_hash)
    image_hash[:path] + '.' + image_hash[:extension]
  end
end

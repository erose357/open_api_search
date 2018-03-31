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

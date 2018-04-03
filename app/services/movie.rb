class Movie
  attr_reader :title, :overview, :release_date

  def initialize(attrs)
    @title = attrs[:title]
    @overview = attrs[:overview]
    @release_date = attrs[:release_date]
  end
end

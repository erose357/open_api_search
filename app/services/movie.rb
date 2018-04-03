class Movie
  attr_reader :title, :overview, :release_date

  def initialize(attrs)
    @title = attrs[:title]
    @overview = clean_overview_string(attrs[:overview])
    @release_date = attrs[:release_date]
  end

  private
    def clean_overview_string(input)
      input.delete '"\"'
    end
end

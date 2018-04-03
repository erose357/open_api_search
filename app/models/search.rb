class Search < ActiveRecord::Base
  validates :search_term, uniqueness: true

  has_many :past_searches, dependent: :destroy

  after_save :add_past_search

  def self.update_or_create(search_name)
    if search = find_by(search_term: search_name)
      search.update(search_count: search.search_count += 1)
    else
      create(search_term: search_name)
    end
  end

  def add_past_search
    past_searches.create
  end
end

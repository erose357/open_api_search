class Search < ActiveRecord::Base
  validates :search_term, uniqueness: true

  def self.update_or_create(search_name)
    if search = find_by(search_term: search_name)
      increment_counter(:search_count, search.id)
    else
      create(search_term: search_name)
    end
  end
end

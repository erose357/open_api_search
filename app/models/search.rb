class Search < ActiveRecord::Base
  validates :search_term, uniqueness: true

  def self.update_or_create(search_name)
    if search = find_by(search_term: search_name)
      search.update(search_count: search.search_count += 1)
    else
      create(search_term: search_name)
    end
  end
end

require 'rails_helper'

RSpec.describe Movie do
  attrs = {
    title: 'Pulp Fiction',
    overview: "A burger-loving hit man, his philosophical partner, a drug-addled gangster's moll and a washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories that ingeniously trip back and forth in time",
    release_date: '1994-09-10'
  }

	let (:movie) { Movie.new(attrs) }

  describe 'Attributes' do
    it '@title' do
      expect(movie.title).to eq('Pulp Fiction')
    end

    it '@overview' do
      expect(movie.overview).to eq("A burger-loving hit man, his philosophical partner, a drug-addled gangster's moll and a washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories that ingeniously trip back and forth in time")
    end

    it '@release_date' do
      expect(movie.release_date).to eq('1994-09-10')
    end
  end
end

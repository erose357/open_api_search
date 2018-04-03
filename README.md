# Open API Search 

Open API Search is a simple web app that allows users to search for movies by full or partial title and displays matching results. This product uses the TMDb API but is not endorsed or certified by TMDb.

* Ruby version 2.4.1  
* Rails version 4.2.8  

### To initialize the app locally:  

`git clone git@github.com:erose357/open_api_search.git` 

#### install [figaro](https://github.com/laserlemon/figaro) to store API keys  
`bundle exec figaro install`

#### Database creation
`bundle exec rake db:{create,migrate}`  

#### Testing with RSpec  
`bundle exec rake db:test:prepare`  
`bundle exec rspec`  

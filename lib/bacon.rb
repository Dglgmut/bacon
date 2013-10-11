require "bacon/version"
require "bacon/fryer"
require "bacon/addons"
require "sqlite3"

module Bacon
  # Your bacon goes here...

  #Creates a table with a single column which is serialized as whatever
  #anyone wants
  DB = SQLite3::Database.open "#{ENV['name']}_bacon.sqlite"
  DB.execute "CREATE TABLE IF NOT EXISTS Bacon(Id INTEGER PRIMARY KEY, Object TEXT)"
end

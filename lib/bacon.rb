require "bacon/version"
require "bacon/fryer"
require "bacon/addons"
require "sqlite3"

module Bacon
  # Your bacon goes here...

  ENV['name'] = 'test'
  DB = SQLite3::Database.open "#{ENV['name']}_bacon.sqlite"
  DB.execute "CREATE TABLE IF NOT EXISTS Bacon(Id INTEGER PRIMARY KEY, Object TEXT)"
  DB.execute "CREATE TABLE IF NOT EXISTS User(Id INTEGER PRIMARY KEY, asana_key STRING)"
end

require 'bundler/setup'
Bundler.require

#ActiveRecord::Base.establish_connection(
#  :adapter => "sqlite3",
#  :database => "db/create_students.sqlite"
#)
#sql = <<-SQL
#  CREATE TABLE IF NOT EXISTS artists (
#  id INTEGER PRIMARY KEY,
#  name TEXT,
#  genre TEXT,
#  age INTEGER,
#  hometown TEXT
#  )
#SQL
# 
#ActiveRecord::Base.connection.execute(sql)
#require_relative "../create_students.rb"


Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../lib/support", "*.rb")].each {|f| require f}

ENV["SCHOOL_ENV"] ||= "development"

DBRegistry[ENV["SCHOOL_ENV"]].connect!
DB = ActiveRecord::Base.connection

if ENV["SCHOOL_ENV"] == "test"
  ActiveRecord::Migration.verbose = false
end

def drop_db
  DB.tables.each do |table|
    DB.execute("DROP TABLE #{table}")
  end
end

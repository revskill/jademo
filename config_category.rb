require 'oj'
require 'active_record'
require 'sqlite3'
require 'iso-639'
STRING_ID = "PL8FB14A2200B87185"
DIR_NAME = "PL8FB14A2200B87185-FinancialMarkets"
LANG = 'en'
#https://drive.google.com/open?id=0B-Ls2Z1D5igvTjJMeExtczF6bmc&authuser=0
#https://drive.google.com/uc?export=download&id=0B-Ls2Z1D5igvTjJMeExtczF6bmc
ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3', # or 'postgresql' or 'sqlite3'
  :database => STRING_ID+'.db'
)

ActiveRecord::Schema.define do  
 
  unless ActiveRecord::Base.connection.tables.include? 'items'
    create_table :items do |table|
      table.column :category_id ,    :string
      table.column :name ,   :string
      table.column :thumbnail ,    :string
      table.column :youtubeid  , :string
      table.column :mp3_url  , :string
      table.column :duration, :string
      table.column :caption_url, :string
    end
  end  
end


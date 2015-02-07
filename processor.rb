require_relative './model_category'

f = File.open("./result-"+STRING_ID+".json","r:utf-8").read
h = Oj.load(f)
h.each do |i|
	item = Item.create(duration: i[:duration], category_id: STRING_ID, name: i[:filename].split("-")[0].strip,thumbnail: i[:thumbnail], youtubeid: i[:id])	
end 
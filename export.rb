require_relative './model_category'
 
File.open(STRING_ID + ".json","w:utf-8") do |f|
	f.puts Item.all.to_json(:except => [:mp3_url, :caption_url])
end 
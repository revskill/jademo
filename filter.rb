require_relative './model_category'

Item.all.each do |it|	
	it.destroy unless it.caption_url	
end
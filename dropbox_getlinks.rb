require 'dropbox_sdk'
require 'json'
require_relative './model_category'

def long_share_url(access_token, path)
    client = DropboxClient.new(access_token)
    session = DropboxOAuth2Session.new(access_token, nil)
    response = session.do_get "/shares/auto/#{client.format_path(path)}", {"short_url"=>false}
    Dropbox::parse_response(response)
end
# Get your app key and secret from the Dropbox developer website
# audiobook
APP_KEY = ''
APP_SECRET = ''
flow = DropboxOAuth2FlowNoRedirect.new(APP_KEY, APP_SECRET)
authorize_url = flow.start()
puts '1. Go to: ' + authorize_url
puts '2. Click "Allow" (you might have to log in first)'
puts '3. Copy the authorization code'
print 'Enter the authorization code here: '
code = gets.strip
access_token, user_id = flow.finish(code)
client = DropboxClient.new(access_token)
puts "linked account:", client.account_info().inspect
mp3_metadata = client.metadata('PL8FB14A2200B87185-FinancialMarkets/mp3/')
caption_metadata = client.metadata('PL8FB14A2200B87185-FinancialMarkets/captions/')
mp3_metadata["contents"].each do |c|
	tmp = c["path"].split("/").last.split(".")[0]
	download_url = long_share_url(access_token, c['path'])["url"].gsub('dl=0','dl=1')
	i = Item.where(youtubeid: tmp).first
	if i 
		if (i.mp3_url == nil or i.mp3_url == '')
			i.mp3_url = download_url
			i.save!
		end
	end
end
caption_metadata["contents"].each do |c|
	tmp = c["path"].split("/").last.split(".")[0]
	download_url = long_share_url(access_token, c['path'])["url"].gsub('dl=0','dl=1')
	i = Item.where(youtubeid: tmp).first
	if i 
		if (i.caption_url == nil or i.caption_url == '')
			i.caption_url = download_url
			i.save!
		end
	end
end

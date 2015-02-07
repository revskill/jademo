require 'dropbox_sdk'

# Get your app key and secret from the Dropbox developer website
# audiobook
APP_KEY = ''
APP_SECRET = ''
# learnenglish

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
Dir.entries('public/mp3').each do |e|
	if (e != '.' and e != '..')
		file = open("public/mp3/" + e)
		response = client.put_file('/PL8FB14A2200B87185-FinancialMarkets/mp3/' + e, file)
		puts "uploaded:", response.inspect
	end
end

Dir.entries('public/captions').each do |e|
	if (e != '.' and e != '..')
		file = open("public/captions/" + e)
		response = client.put_file('/PL8FB14A2200B87185-FinancialMarkets/captions/' + e, file)
		puts "uploaded:", response.inspect
	end
end
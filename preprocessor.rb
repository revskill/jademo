require 'oj'
STRING_ID = 'PL8FB14A2200B87185'
f = File.open("res-" + STRING_ID + ".json","r:utf-8").read
f2 = f.gsub("}\n","},\n")[0..-3]
f3 = "[" + f2 + "]"
h = Oj.load(f3)
h2 = []
h.each do |t|
tmp = {}
tmp[:id] = t["display_id"]
tmp[:thumbnail] = t["thumbnail"]
tmp[:filename] = t["_filename"]
tmp[:duration] = "%.2f" % (t["duration"]/60.to_f)
h2 << tmp
end
t = Oj.dump(h2)
File.open("result-#{STRING_ID}.json","w:utf-8") do |f|
f.puts t
end 
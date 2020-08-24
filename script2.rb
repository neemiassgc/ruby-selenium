require "json"

body = ""
File.open("./file.txt", "r").each_line{|e| body += e}
File.open("./file.json", "w"){|e| e.syswrite JSON.generate({body: body})}
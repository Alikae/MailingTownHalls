require_relative "testdemain.rb"
require "google_drive"
require "resolv-replace"

def performing(database, ws)
  z = 2
  database.each {|name, mail| #Pour chaque couple nom/mail
    ws[z, 1] = name
    ws[z, 2] = mail           #On les écrit dans le SpreadSheet
    z += 1
  }
  ws.save                     #Et on sauve
end

def exec()                                                 #Premiere fonction appelée par le programme
puts "sheet key?"
sheet_key = gets.chomp
session = GoogleDrive::Session.from_config("config.json")  #Ouverture de la session Drive
ws = session.spreadsheet_by_key(sheet_key).worksheets[0]   #Ouverture du SpreadSheet
database = perform                                         #On importe les noms et les mails depuis testdemain.rb
performing(database, ws)
end

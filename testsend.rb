require "google_drive"
require "open-uri"

def extract_names_and_mails()
  puts "Sorry but sheet key another time?"
  sheet_key = gets.chomp
  session = GoogleDrive::Session.from_config("config.json") #Ouvre le SpreadSheet
  ws = session.spreadsheet_by_key(sheet_key).worksheets[0]
  databasef = Hash.new
  stop = 0
  nb = 1
  while stop == 0                                           #En boucle:
    name = ws[nb, 1]
    mail = ws[nb, 2]                                        #On récupère les noms et mails dans le SpreadSheet
    puts "importing: #{name} = #{mail}"
    nb += 1                                                 #ligne par ligne
    databasef[name] = mail                                  #Et on les stockes
    stop = 1 if ws[nb, 1] == ""                             #On arrete si c'est fini
  end
  return databasef                                          #Et on retourne la database
end


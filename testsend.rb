require "google_drive"
require "open-uri"

def extract_names_and_mails()
  puts "Sorry but sheet key another time?"
  sheet_key = gets.chomp
  session = GoogleDrive::Session.from_config("config.json")
  ws = session.spreadsheet_by_key(sheet_key).worksheets[0]
  databasef = Hash.new
  stop = 0
  nb = 1
  while stop == 0
    name = ws[nb, 1]
    mail = ws[nb, 2]
    puts "importing: #{name} = #{mail}"
    nb += 1  
    databasef[name] = mail
    stop = 1 if ws[nb, 1] == ""
  end
  return databasef
end


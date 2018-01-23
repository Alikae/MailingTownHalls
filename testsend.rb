require "google_drive"
require "open-uri"

def extract_names_and_mails()
  session = GoogleDrive::Session.from_config("config.json")
  ws = session.spreadsheet_by_key("1FM8cyfajHu1q68Kh2JWnL3xi1ThQ7pypfdQ1rWhQuwQ").worksheets[0]
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


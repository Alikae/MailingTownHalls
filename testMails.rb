require_relative "testdemain.rb"
require "google_drive"
require "resolv-replace"

def performing(database, ws)
  z = 2
  database.each {|name, mail|
    ws[z, 1] = name
    ws[z, 2] = mail
    z += 1
  }
  ws.save
end

def exec()
session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1FM8cyfajHu1q68Kh2JWnL3xi1ThQ7pypfdQ1rWhQuwQ").worksheets[0]
database = perform
performing(database, ws)
end

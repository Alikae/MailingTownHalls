require "open-uri"
require "nokogiri"

def import_city_urls(url)
  names_urls = Hash.new
  doc = Nokogiri::HTML(open(url))
  doc.css('p a.lientxt').each { |link|                         #Idem pour chaque ville
    city_url = "http://annuaire-des-mairies.com" + link["href"][1..-1]
    city_name = link["href"][5..-6]
    names_urls[city_name] = city_url
  }
  return names_urls
end

def get_mail(url)
  mail = "Pas de mail"
  begin
    doc = Nokogiri::HTML(open(url))                             #Et on recupere les mails
    doc.css('tr/td/p/font').each { |txt|
      if /@/ =~ txt.text
        mail = txt.text
      end
    }
  rescue StandardError => error
  mail = "error: #{error.class}"
  end
  return mail
end

def perform()
  databuffer = Hash.new
  puts "Gemme an URL pls"
  dep_url = gets.chomp
  city_names_url = import_city_urls(dep_url)
  city_names_url.each { |city_name, city_url|
    city_mail = get_mail(city_url)
    databuffer[city_name] = city_mail
    puts "importing:  " + city_mail
  }
  return databuffer
end

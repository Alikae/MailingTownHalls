require "open-uri"
require "nokogiri"

def import_city_urls(url)
  names_urls = Hash.new
  doc = Nokogiri::HTML(open(url))                     #Ouvre le site du département
  doc.css('p a.lientxt').each { |link|                #Pour chaque élément de type p a.lientxt
    city_url = "http://annuaire-des-mairies.com" + link["href"][1..-1]
    city_name = link["href"][5..-6]
    names_urls[city_name] = city_url                  #On récupere et stocke le nom et l'URL de la ville
  }
  return names_urls
end

def get_mail(url)
  mail = "Pas de mail"
  begin
    doc = Nokogiri::HTML(open(url))          #Ouvre le site de la commune
    doc.css('tr/td/p/font').each { |txt|     #Pour chaque élément de type tr/td/p/font
      if /@/ =~ txt.text                     #Si il contient un @ (mail)
        mail = txt.text                      #On l'enregistre
      end
    }
  rescue StandardError => error
  mail = "error: #{error.class}"
  end
  return mail                                #Et on le retourne
end

def perform()                                           #Corps principal
  databuffer = Hash.new
  puts "Gemme an URL pls"
  dep_url = gets.chomp                                  #Récupération de l'URL de l'annuaire du département
  city_names_url = import_city_urls(dep_url)            #On importe chaque URL de ville
  city_names_url.each { |city_name, city_url|           #Pour chaque couple nom/url
    city_mail = get_mail(city_url)                        #On récupère le mail
    databuffer[city_name] = city_mail                     #On enregistre le couple nom/mail
    puts "importing:  " + city_mail
  }
  return databuffer                                     #Et on retourne le hash noms/mails
end

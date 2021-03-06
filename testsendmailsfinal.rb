require "gmail"
require "resolv-replace"
require_relative "testsend.rb"


def process()
puts "Login?"
login = gets.chomp
puts "password?"
password = gets.chomp

gmail = Gmail.connect(login, password)   #Connection a l'API Gmail
puts gmail.logged_in?                    #Vérification du log

datahash = extract_names_and_mails()     #Récupération des noms/mails

datahash.each { |name, email|            #Pour chaque couple
  puts "treating: #{name}, #{email}"
  mail = gmail.deliver do                #On écrit le mail
    to email
    subject "Le code, c'est important!"
    text_part do
      body "Bonjour,
Je m'appelle Georges, je suis élève à une formation de code gratuite, ouverte à tous, sans restriction géographique, ni restriction de niveau. La formation s'appelle The Hacking Project (http://thehackingproject.org/). Nous apprenons l'informatique via la méthode du peer-learning : nous faisons des projets concrets qui nous sont assignés tous les jours, sur lesquel nous planchons en petites équipes autonomes. Le projet du jour est d'envoyer des emails à nos élus locaux pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation gratuite.

Nous vous contactons pour vous parler du projet, et vous dire que vous pouvez ouvrir une cellule à #{name}, où vous pouvez former gratuitement 6 personnes (ou plus), qu'elles soient débutantes, ou confirmées. Le modèle d'éducation de The Hacking Project n'a pas de limite en terme de nombre de moussaillons (c'est comme cela que l'on appelle les élèves), donc nous serions ravis de travailler avec #{name} !

Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80"
    end
  end

  gmail.deliver(mail)                    #Et on l'envoies.
}
puts "Mails sent."
puts "End of process."                   #The END.
end


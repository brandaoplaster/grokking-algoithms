require "benchmark"
require_relative "../shared/contact_loader"

contacts = ContactLoader.load("contacts.json", 1000000)

def simple_search(contacts, name)
  counter = 0

  contacts.each  do |contact|
    counter += 1
    if contact.name == name
      puts "Search completed in #{counter} interations."
      return contact
    end
  end

  puts "Search completed in #{counter} interations."
  nil
end

search_1 = Benchmark.realtime do
  result =  simple_search(contacts, contacts[125521].name)
  puts result.name
end

puts "Time taken: #{format('%.6f', search_1.real)} seconds \n\n"

search_2 = Benchmark.realtime do
  result =  simple_search(contacts, contacts[500100].name)
  puts result.name
end

puts "Time taken: #{format('%.6f', search_2.real)} seconds \n\n"


search_3 = Benchmark.realtime do
  result =  simple_search(contacts, contacts[975875].name)
  puts result.name
end

puts "Time taken: #{format('%.6f', search_3.real)} seconds \n\n"

search_4 = Benchmark.realtime do
  result =  simple_search(contacts, contacts[1000000].name)
  puts result.name
end

puts "Time taken: #{format('%.6f', search_4.real)} seconds \n\n"

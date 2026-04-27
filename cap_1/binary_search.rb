require "benchmark"
require_relative "../shared/contact_loader"

contacts = ContactLoader.load("contacts.json", 1000000)

def binary_search(contacts, name)
  low = 0
  high = contacts.length - 1
  counter = 0

  while low <= high
    counter += 1
    mid = (low + high) / 2
    hit = contacts[mid]

    if hit.name == name
      puts "Search completed in #{counter} iterations."
      return hit
    end

    if hit.name < name
      low = mid + 1
    else
      high = mid - 1
    end

  end

  puts "Search completed in #{counter} iterations."

  nil
end


search_1 = Benchmark.realtime do
  result =  binary_search(contacts, contacts[125521].name)
  puts result.name
end

puts "Time taken: #{format('%.6f', search_1.real)} seconds \n\n"

search_2 = Benchmark.realtime do
  result =  binary_search(contacts, contacts[500100].name)
  puts result.name
end

puts "Time taken: #{format('%.6f', search_2.real)} seconds \n\n"


search_3 = Benchmark.realtime do
  result =  binary_search(contacts, contacts[975875].name)
  puts result.name
end

puts "Time taken: #{format('%.6f', search_3.real)} seconds \n\n"

search_4 = Benchmark.realtime do
  result =  binary_search(contacts, contacts[1000000].name)
  puts result.name
end

puts "Time taken: #{format('%.6f', search_4.real)} seconds \n\n"

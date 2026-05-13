require "benchmark"
require_relative "../shared/contact_loader"

contacts = ContactLoader.load("contacts.json", 20, false)
list_contacts = contacts[0..10]

class Node
  attr_accessor :contact, :prox

  def initialize(contact, prox = nil)
    @contact = contact
    @prox = prox
  end
end

class LikedList
  def initialize
    @head = nil
  end

  def add(contact)
    if @head.nil?
      @head  = Node.new(contact)
    else
      current = @head
      current = current.prox until current.prox.nil?
      current.prox = Node.new(contact)
    end
  end

  def print
    puts "======================================\n"
    current = @head
    until current.nil?
      puts "Name: #{current.contact.name} - Phone: #{current.contact.phone}"
      current = current.prox
    end
  end

  def search
  end

  def delete
  end
end

list = LikedList.new
puts "Adding contacts to the list..."

list_contacts.each { |contact| list.add(contact) }
list.print

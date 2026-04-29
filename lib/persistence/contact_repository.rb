require 'json'

module Persistence
  class ContactRepository
    def initialize(file_path = 'contacts.json')
      @file_path = file_path
    end

    def load_all(sorted: false)
      return [] unless File.exist?(@file_path)

      contacts = parse_from_file
      sorted ? contacts.sort_by(&:name) : contacts
    end

    def save_all(contacts)
      data = contacts.map { |c| to_hash(c) }
      File.write(@file_path, JSON.pretty_generate(data))
    end

    def add(contact)
      contacts = load_all
      contacts << contact
      save_all(contacts)
    end

    def update(old_name, new_contact)
      contacts = load_all
      index = contacts.find_index { |c| c.name == old_name }
      return false unless index

      contacts[index] = new_contact
      save_all(contacts)
      true
    end

    def delete(name)
      contacts = load_all
      initial_size = contacts.size
      contacts.reject! { |c| c.name.downcase == name.downcase }

      if contacts.size < initial_size
        save_all(contacts)
        true
      else
        false
      end
    end

    def find_by_name(name)
      load_all.find { |c| c.name.downcase == name.downcase }
    end

    def exists?
      File.exist?(@file_path)
    end

    def count
      load_all.size
    end

    private

    def parse_from_file
      data = JSON.parse(File.read(@file_path))
      data.map { |c| Contact.new(c['name'], c['email'], c['phone']) }
    end

    def to_hash(contact)
      { name: contact.name, email: contact.email, phone: contact.phone }
    end
  end
end

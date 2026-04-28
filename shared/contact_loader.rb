require "json"
require_relative "contact"

class ContactLoader
  def self.load(file_path, count, sort = true)
    if File.exist?(file_path)
      load_from_file(file_path)
    else
      generate_and_save(file_path, count, sort)
    end
  end

  private

  def self.load_from_file(file_path)
    data = JSON.parse(File.read(file_path))
    data.map { |c| Contact.new(c["name"], c["email"], c["phone"]) }
  end

  def self.generate_and_save(file_path, count, sort)
    contacts = Contact.generate_list(count)
    contacts << Contact.new("John Doe", "", "")
    contacts.sort_by!(&:name) if sort

    data = contacts.map { |c| { name: c.name, email: c.email, phone: c.phone } }
    File.write(file_path, data.to_json)

    contacts
  end
end

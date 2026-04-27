require "faker"

class Contact
  attr_accessor :name, :email, :phone

  def initialize(name, email, phone)
    @name = name
    @email = email
    @phone = phone
  end

  def self.add
    new(Faker::Name.name, Faker::Internet.email, Faker::PhoneNumber.phone_number)
  end

  def self.generate_list(count)
    Array.new(count) { add }
  end
end

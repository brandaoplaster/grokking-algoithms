require_relative 'lib/ui/menu'
require_relative 'lib/ui/formatter'
require_relative 'lib/persistence/contact_repository'
require_relative 'shared/contact'

class AlgorithmsCLI
  def initialize
    @menu = UI::Menu.new
    @formatter = UI::Formatter
    @repository = Persistence::ContactRepository.new 
    @current_structure = nil
    @contacts_data = nil
  end

  def start
    puts @formatter.welcome

    loop do
      @menu.display_main(
        format_structure_name,
        get_contacts_count
      )

      choice = @menu.get_main_option

      case choice
      when 1
        choose_data_structure
      when 2
        add_contact
      when 3
        search_contact
      when 4
        delete_contact
      when 5
        list_contacts
      when 0
        puts "\nGoodbye!"
        break
      else
        puts @formatter.error_message("Invalid option! Please try again.")
      end

      @menu.pause unless choice == 0
    end
  end

  private

  def choose_data_structure
    @menu.display_structure_selection
    choice = @menu.get_structure_choice

    case choice
    when 1
      @current_structure = :simple_search
      load_contacts(sorted: false)
      load_simple_search_methods
      puts @formatter.success_message("Array with Simple Search selected!")
      puts @formatter.info_message("Current contacts: #{get_contacts_count}")

    when 2
      @current_structure = :binary_search
      load_contacts(sorted: true)
      load_binary_search_methods
      puts @formatter.success_message("Array with Binary Search selected!")
      puts @formatter.info_message("Current contacts: #{get_contacts_count}")

    when 3
      @current_structure = :linked_list
      initialize_linked_list
      puts @formatter.success_message("Singly Linked List selected!")
      puts @formatter.info_message("Current contacts: #{get_contacts_count}")

    else
      puts @formatter.error_message("Invalid option!")
    end
  end

  def add_contact
    return unless check_structure_selected

    data = @menu.get_contact_data

    if data[:name].empty?
      puts @formatter.error_message("Name cannot be empty!")
      return
    end

    contact = Contact.new(data[:name], data[:email], data[:phone])

    case @current_structure
    when :simple_search
      @contacts_data << contact
      @repository.save_all(@contacts_data)
      puts @formatter.success_message("Contact added successfully!")

    when :binary_search
      @contacts_data << contact
      @contacts_data.sort_by!(&:name)
      @repository.save_all(@contacts_data)
      puts @formatter.success_message("Contact added and sorted!")

    when :linked_list
      @contacts_data.add(contact)
      @repository.save_all(@contacts_data.to_array) 
      puts @formatter.success_message("Contact added to linked list!")
    end

    puts @formatter.info_message("Total contacts: #{get_contacts_count}")
  end

  def search_contact
    return unless check_structure_selected

    name = @menu.get_search_name

    if name.empty?
      puts @formatter.error_message("Name cannot be empty!")
      return
    end

    puts @formatter.info_message("Searching using #{format_structure_name}...")

    start_time = Time.now
    result = perform_search(name)
    elapsed = Time.now - start_time

    puts @formatter.search_result(result, elapsed)
  end

  def delete_contact
    return unless check_structure_selected

    name = @menu.get_delete_name

    if name.empty?
      puts @formatter.error_message("Name cannot be empty!")
      return
    end

    case @current_structure
    when :simple_search, :binary_search
      index = @contacts_data.find_index { |c| c.name.downcase == name.downcase }
      if index
        deleted = @contacts_data.delete_at(index)
        @repository.save_all(@contacts_data)
        puts @formatter.success_message("Contact '#{deleted.name}' deleted successfully!")
        puts @formatter.info_message("Remaining contacts: #{get_contacts_count}")
      else
        puts @formatter.error_message("Contact '#{name}' not found!")
      end

    when :linked_list
      if @contacts_data.delete(name)
        @repository.save_all(@contacts_data.to_array)
        puts @formatter.success_message("Contact '#{name}' deleted!")
        puts @formatter.info_message("Remaining contacts: #{get_contacts_count}")
      else
        puts @formatter.error_message("Contact '#{name}' not found!")
      end
    end
  end

  def list_contacts
    return unless check_structure_selected

    puts @formatter.section_header("CONTACT LIST")

    count = get_contacts_count

    if count == 0
      puts "\nNo contacts registered yet."
      return
    end

    puts "Total: #{count} contact(s)\n\n"

    case @current_structure
    when :simple_search, :binary_search
      @contacts_data.each_with_index do |contact, i|
        puts @formatter.contact_list_item(i, contact)
      end

    when :linked_list
      @contacts_data.print
    end

    puts "\n" + UI::Formatter::SEPARATOR_FULL
  end

  def check_structure_selected
    unless @current_structure
      puts @formatter.warning_message("Please select a data structure first (option 1)")
      return false
    end
    true
  end

  def format_structure_name
    case @current_structure
    when :simple_search
      "Array with Simple Search (O(n))"
    when :binary_search
      "Array with Binary Search (O(log n))"
    when :linked_list
      "Singly Linked List (O(n))"
    else
      "None selected"
    end
  end

  def get_contacts_count
    return 0 unless @contacts_data

    case @current_structure
    when :simple_search, :binary_search
      @contacts_data.length
    when :linked_list
      @contacts_data.count
    else
      0
    end
  end

  def perform_search(name)
    case @current_structure
    when :simple_search
      simple_search(@contacts_data, name)
    when :binary_search
      binary_search(@contacts_data, name)
    when :linked_list
      @contacts_data.search(name)
    end
  end

  def load_simple_search_methods
    require_relative 'cap_1/simple_search' unless defined?(simple_search)
  end

  def load_binary_search_methods
    require_relative 'cap_1/binary_search' unless defined?(binary_search)
  end

  def load_contacts(sorted:)
    @contacts_data = @repository.load_all(sorted: sorted)
    
    if @repository.exists?
      puts @formatter.info_message("Loaded #{@contacts_data.length} contacts")
    else
      puts @formatter.info_message("Starting with empty contact list")
    end
  end

  def initialize_linked_list
    require_relative 'cap_2/singly_linked_list'
    @contacts_data = LikedList.new
    
    if @repository.exists?
      contacts_array = @repository.load_all(sorted: false)
      contacts_array.each { |contact| @contacts_data.add(contact) }
      puts @formatter.info_message("Loaded #{contacts_array.length} contacts into linked list")
    else
      puts @formatter.info_message("Starting with empty linked list")
    end
  end
end

if __FILE__ == $0
  cli = AlgorithmsCLI.new
  cli.start
end

module UI
  class Menu
    def initialize(formatter: Formatter)
      @formatter = formatter
    end

    def display_main(current_structure, contact_count)
      puts @formatter.structure_info(current_structure, contact_count)
      puts "\nMENU OPTIONS:"
      puts "  1. Choose Data Structure"
      puts "  2. Add Contact"
      puts "  3. Search Contact"
      puts "  4. Delete Contact"
      puts "  5. List All Contacts"
      puts "  0. Exit"
    end

    def display_structure_selection
      puts @formatter.section_header("SELECT DATA STRUCTURE & SEARCH ALGORITHM")
      puts "\n1. Array with Simple Search (Linear Search - O(n))"
      puts "   Best for: Unsorted data, small datasets"
      puts "\n2. Array with Binary Search (O(log n))"
      puts "   Best for: Sorted data, large datasets, fast searches"
      puts "\n3. Singly Linked List (O(n))"
      puts "   Best for: Frequent insertions/deletions, sequential access"
    end

    def get_main_option
      print "\nSelect an option: "
      gets.chomp.to_i
    end

    def get_structure_choice
      print "\nChoose (1-3): "
      gets.chomp.to_i
    end

    def get_contact_data
      puts @formatter.section_header("ADD NEW CONTACT")

      print "\nName: "
      name = gets.chomp.strip

      print "Email: "
      email = gets.chomp.strip

      print "Phone: "
      phone = gets.chomp.strip

      { name: name, email: email, phone: phone }
    end

    def get_search_name
      puts @formatter.section_header("SEARCH CONTACT")
      print "\nEnter name to search: "
      gets.chomp.strip
    end

    def get_delete_name
      puts @formatter.section_header("DELETE CONTACT")
      print "\nEnter name of contact to delete: "
      gets.chomp.strip
    end

    def pause
      print "\nPress ENTER to continue..."
      gets
    end
  end
end

module UI
  class Formatter
    SEPARATOR_FULL = "=" * 60
    SEPARATOR_THIN = "-" * 60

    def self.welcome
      "\n#{SEPARATOR_FULL}\n" \
      "#{' ' * 10}CONTACT MANAGER - Grokking Algorithms\n" \
      "#{SEPARATOR_FULL}"
    end

    def self.section_header(title)
      "\n#{SEPARATOR_FULL}\n" \
      "#{title}\n" \
      "#{SEPARATOR_FULL}"
    end

    def self.subsection_header(title)
      "\n#{SEPARATOR_THIN}\n" \
      "#{title}\n" \
      "#{SEPARATOR_THIN}"
    end

    def self.structure_info(structure_name, contact_count)
      "\n#{SEPARATOR_THIN}\n" \
      "Current Data Structure: #{structure_name}\n" \
      "Total Contacts: #{contact_count}\n" \
      "#{SEPARATOR_THIN}"
    end

    def self.contact_details(contact)
      "#{SEPARATOR_THIN}\n" \
      "  Name:    #{contact.name}\n" \
      "  Email:   #{contact.email}\n" \
      "  Phone:   #{contact.phone}\n" \
      "#{SEPARATOR_THIN}"
    end

    def self.search_result(contact, elapsed_time)
      formatted_time = format('%.6f', elapsed_time)

      if contact
        "\n#{SEPARATOR_THIN}\n" \
        "[FOUND] Contact found!\n" \
        "#{SEPARATOR_THIN}\n" \
        "  Name:    #{contact.name}\n" \
        "  Email:   #{contact.email}\n" \
        "  Phone:   #{contact.phone}\n" \
        "#{SEPARATOR_THIN}\n" \
        "  Search time:  #{formatted_time} seconds\n" \
        "#{SEPARATOR_THIN}"
      else
        "\n#{SEPARATOR_THIN}\n" \
        "[NOT FOUND] Contact not found!\n" \
        "#{SEPARATOR_THIN}\n" \
        "  Search time:  #{formatted_time} seconds\n" \
        "#{SEPARATOR_THIN}"
      end
    end

    def self.contact_list_item(index, contact)
      "#{(index + 1).to_s.rjust(3)}. #{contact.name.ljust(30)} | " \
      "#{contact.phone.ljust(15)} | #{contact.email}"
    end

    def self.success_message(message)
      "\n[OK] #{message}"
    end

    def self.error_message(message)
      "\n[ERROR] #{message}"
    end

    def self.warning_message(message)
      "\n[WARNING] #{message}"
    end

    def self.info_message(message)
      "     #{message}"
    end
  end
end

module Listable
        # Formats the description
        def format_description(description)
                "#{description}".ljust(30)
        end

        # Formats the date
        def format_date(options={})
                # If its a todo item
                if options[:start_date]
                        dates = options[:start_date].strftime("%D") if options[:start_date]
                        dates << " -- " + options[:end_date].strftime("%D") if options[:end_date]
                        dates = "N/A" if !dates
                        return dates
                else
                        options[:end_date] ? options[:end_date].strftime("%D") : "No due date"
                end
        end

        # Formats the priority
        def format_priority(priority)
                # If its a todo item
                value = " ⇧".colorize(:red) if priority == "high"
                value = " ⇨".colorize(:yellow) if priority == "medium"
                value = " ⇩".colorize(:green) if priority == "low"
                value = "" if !priority
                return value
        end

        # Formats the type
        def format_type(type)
                value = type.ljust(15).colorize(:light_red) if type == "TODO"
                value = type.ljust(15).colorize(:blue) if type == "Link"
                value = type.ljust(15).colorize(:green) if type == "Event"
                value = type.ljust(15).colorize(:yellow) if type == "List"
                return value
        end

        #Format elements
        def format_elements(elements)
                value = ""
                elements.each_with_index do |element, position|
                        value += "#{element}"
                        if element != @elements[@elements.length-1]
                                value += ", "
                        end
                end
                return value
        end
end

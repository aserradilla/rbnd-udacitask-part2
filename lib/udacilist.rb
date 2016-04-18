require 'terminal-table'

class UdaciList
         attr_reader :title, :items

         def initialize(options={})
                 if options[:title]
                         @title = options[:title]
                 else
                         @title = "Untitled list"
                 end
                 @items = []
         end

         def add(type, description, options={})
                 type = type.downcase
                 check_type(type)
                 @items.push TodoItem.new(description, options) if type == "todo"
                 @items.push EventItem.new(description, options) if type == "event"
                 @items.push LinkItem.new(description, options) if type == "link"
         end

         def delete(index)
                 check_index(index-1)
                 @items.delete_at(index - 1)
         end

         def all
                 rows = []
                 @items.each_with_index do |item, position|
                         rows << [position + 1, item.details]
                 end
                 table = Terminal::Table.new
                 table.title = "#{@title}"
                 table.rows = rows
                 puts table
         end

         # Filters the list by item type
         def filter(type)
                 type = type.downcase
                 check_type(type)
                 items = @items
                 typeclass = TodoItem if type == "todo"
                 typeclass = LinkItem if type == "link"
                 typeclass = EventItem if type == "event"
                 filtered_items = items.select do |item|
                         item.instance_of? typeclass
                 end
                 rows = []
                 filtered_items.each_with_index do |item, position|
                         rows << [position + 1, item.details]
                 end
                 table = Terminal::Table.new
                 table.title = "#{@title} filtered by #{type}"
                 table.rows = rows
                 puts table
         end

         private

         # Raises error when type is unknown
         def check_type(type)
                 if type != "todo" && type != "event" && type != "link"
                         raise UdaciListErrors::InvalidItemType, "type '#{type}' is not supported."
                 end
         end

         # Raises error when index exceeds array's length
         def check_index(index)
                 raise UdaciListErrors::IndexExceedsListSize, "There is no such item to delete, '#{index}' is not valid" if index > @items.length
         end
end

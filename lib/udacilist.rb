 class UdaciList
         attr_reader :title, :items

         def initialize(options={})
                 @title = options[:title]
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
                 if @title
                         puts "-" * @title.length
                         puts @title
                         puts "-" * @title.length
                 end
                 @items.each_with_index do |item, position|
                         puts "#{position + 1}) #{item.details}"
                 end
         end

         # Filters the list by item type
         def filter(type)

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

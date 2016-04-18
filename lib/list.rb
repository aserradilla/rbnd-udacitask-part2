class ListItem
        include Listable
        attr_reader :description, :elements

        def initialize(description, options={})
                @description = description
                if options[:elements]
                        @elements = options[:elements]
                else
                        @elements = []
                end
        end

        def details
                format_description(@description) +
                "type: " + format_type("List") +
                format_elements(@elements)
        end

        private

        # Raises error when index exceeds array's length
        def check_index(index)
                raise UdaciListErrors::IndexExceedsListSize, "There is no such item to delete, '#{index}' is not valid" if index > @elements.length
        end
end

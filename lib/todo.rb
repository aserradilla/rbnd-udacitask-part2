class TodoItem
        include Listable
        attr_reader :description, :due, :priority

        def initialize(description, options={})
                @description = description
                @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
                check_priority(options[:priority]) if options[:options]
                @priority = options[:priority]
        end

        def details
                format_description(@description) +
                "type: " + format_type("TODO") +
                "due: " + format_date(end_date: @due) +
                format_priority(@priority)
        end

        private

        # Raises error when priority is unknown
        def check_priority(priority)
                if priority != "low" && priority != "high" && priority != "medium"
                        raise UdaciListErrors::InvalidPriorityValue, "'#{priority}' is not a valid priority."
                end
        end
end

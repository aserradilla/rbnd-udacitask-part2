class EventItem
        include Listable
        attr_reader :description, :start_date, :end_date

        def initialize(description, options={})
                @description = description
                @start_date = Date.parse(options[:start_date]) if options[:start_date]
                @end_date = Date.parse(options[:end_date]) if options[:end_date]
        end

        def details
                format_description(@description) +
                "type: " + format_type("Event") +
                "event dates: " + format_date(start_date: @start_date, end_date: @end_date)
        end
end

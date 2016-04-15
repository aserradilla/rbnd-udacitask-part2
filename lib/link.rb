class LinkItem
        include Listable
        attr_reader :description, :site_name

        def initialize(url, options={})
                @description = url
                if options[:site_name]
                        @site_name = options[:site_name]
                else
                        @site_name = "No sitename"
                end

        end

        def format_name
                @site_name ? @site_name : ""
        end

        def details
                format_description(@description) +
                "type: " + format_type("Link") +
                "site name: " + format_name
        end
end

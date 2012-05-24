module VlineUpdates
  module Updates

    def self.obtain
      # rss = Nokogiri::XML RestClient.get($CONFIG.vline.page)
      rss = Nokogiri::XML File.read('./tmp/example.rss')

      details = []

      rss.xpath('//item').each do |update|

        type = update.xpath('title').text
        detail = update.xpath('description').text.gsub(/<\/?[^>]+>/, '').strip.chomp

        case type.downcase
            when 'delay'
              klass = Delay
            else
              klass = Generic
          end

          details << klass.new(detail)
      end

      details
    end
  end
end
module VlineUpdates
  module Updates

    def self.obtain
      rss = Nokogiri::XML RestClient.get($CONFIG.vline.page)

      details = []

      rss.xpath('//item').each do |item|

        type = item.xpath('title').text

        case type.downcase
          when 'delay'
            klass = Delay
          when 'cancelled'
            klass = Cancelled
          else
            klass = Generic
        end

        update = klass.new(item)

        unless $DRY_ON
          unless VlineUpdates::Updates::Update.exists?(conditions: { guid: update.guid })
            update.save
            details << update
          else
            $logger.debug "Update already exists - #{update}"
          end
        else
          $logger.debug update
          $logger.debug "Not looking up as --dry mode active"
        end
      end

      details
    end
  end
end
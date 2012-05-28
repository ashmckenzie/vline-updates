module VlineUpdates
  module Updates
    class Update
      include Mongoid::Document
      store_in :updates

      field :guid, type: Integer

      attr_reader :type, :time, :guid, :priority

      def initialize update
        @update = update

        @type = update.xpath('title').text.capitalize
        @time = Time.zone.parse(update.xpath('pubDate').text)
        @guid = update.xpath('guid').text

        super({ :guid => guid })
      end

      def event
        "[#{time.strftime('%d/%m/%Y %H:%M')}] #{@type}"
      end

      def to_s
        "#{event} - #{description}"
      end

      def description
        @description ||= @update.xpath('description').text.gsub(/<\/?[^>]+>/, '').strip.chomp.gsub(/^\.*|\.*$/, '').gsub(/&nbsp;/, ' ')
      end
    end
  end
end
module VlineUpdates
  module Updates
    class Structured
      attr_reader :time, :description, :priority

      def initialize str
        if result = str.scan(/(\d+\/\d+\/\d+)? ?(\d+:\d+) (.+)$/)
          date, time, description = result[0]
          @time = DateTime.strptime((date ? date : Time.now.strftime('%d/%m/%y')) << " " << time, "%d/%m/%y %H:%M")
          @description = description.gsub(/^\.*|\.*$/, '').gsub(/&nbsp;/, ' ')
        else
          raise FormatUnknown
        end
      end

      def event
        "[#{time.strftime('%d/%m/%Y %H:%M')}] #{@event}"
      end

      def to_s
        "#{event} - #{description}"
      end
    end
  end
end
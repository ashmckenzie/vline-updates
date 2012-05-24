module VlineUpdates
  module Updates
    class Delay
      attr_reader :time, :departing, :terminating, :msg, :priority

      def initialize str
        @event = 'Delay'
        @priority = HIGH

        if result = str.scan(/(\d+:\d+) (.+) - (.+) - (.+)$/)
          time, @departing, @terminating, msg = result[0]
          @time = Time.parse(time)
          @msg = msg.gsub(/^\.*|\.*$/, '')
        else
          raise FormatUnknown
        end
      end

      def event
        "[#{time.strftime('%d/%m/%Y %H:%M')}] #{@event}: #{departing} -> #{terminating}"
      end

      def description
        "#{departing} -> #{terminating}: #{msg}"
      end

      def to_s
        "#{event} - #{msg}"
      end
    end
  end
end
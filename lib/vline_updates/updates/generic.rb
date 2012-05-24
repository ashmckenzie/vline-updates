module VlineUpdates
  module Updates
    class Generic
      attr_reader :description, :priority

      def initialize str
        @event = 'Update'
        @description = str
        @priority = NORMAL
      end

      def event
        "[#{Time.now.strftime('%d/%m/%Y %H:%M')}]: #{@event}"
      end

      def to_s
        "#{event} - #{@description}"
      end
    end
  end
end
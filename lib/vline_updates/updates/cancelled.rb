module VlineUpdates
  module Updates
    class Cancelled < Structured

      def initialize str
        @event = 'Delay'
        @priority = EMERGENCY
        super
      end
    end
  end
end
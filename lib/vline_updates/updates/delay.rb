module VlineUpdates
  module Updates
    class Delay < Structured
 
      def initialize str
        @event = 'Delay'
        @priority = HIGH
        super
      end
    end
  end
end
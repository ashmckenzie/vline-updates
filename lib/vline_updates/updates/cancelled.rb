module VlineUpdates
  module Updates
    class Cancelled < Update

      def initialize update
        @priority = EMERGENCY
        super
      end
    end
  end
end
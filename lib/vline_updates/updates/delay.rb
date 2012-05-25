module VlineUpdates
  module Updates
    class Delay < Update
      
      def initialize update
        @priority = HIGH
        super
      end
    end
  end
end
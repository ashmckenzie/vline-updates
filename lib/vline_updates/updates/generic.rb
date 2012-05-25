module VlineUpdates
  module Updates
    class Generic < Update

      def initialize update
        @priority = NORMAL
        super
      end
    end
  end
end
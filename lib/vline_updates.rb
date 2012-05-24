module VlineUpdates

  VERY_LOW = -2
  MODERATE = -1
  NORMAL = 0
  HIGH = 1
  EMERGENCY = 2

  def self.notify
    result = Request.process
    ap result
  end

  class Request
    URL = 'https://www.notifymyandroid.com/publicapi/notify'

    def self.process
      responses = []

      payloads.each do |payload|
        $logger.info payload[:detail]
        payload.delete(:detail)
        responses << Response.new(RestClient.post(URL, payload))
      end

      responses
    end

    def self.payloads
      Detail.obtain.collect do |detail|
        {
          detail: detail,
          apikey: $CONFIG.nma.api_key,
          application: $CONFIG.name,
          event: detail.event,
          description: detail.description,
          priority: eval("#{$CONFIG.nma.priority.to_sym}")    # FIXME
        }
      end 
    end
  end

  class Response

    def initialize xml
      @xml = Nokogiri::XML xml
    end

    def code
      @xml.xpath('//@code').first.value.to_s
    end
  end

  class Detail

    def self.obtain
      # File.open('/tmp/vline.html', 'w') do |f|
      #   x = RestClient.get $CONFIG.vline.page
      #   f.write(x)
      # end

      details = []

      html = Nokogiri::HTML File.read('/tmp/vline.html')

      html.css('div.serviceUpdate').each do |update|
        type = update.css('span').text
        detail = update.text.gsub(Regexp.new("^#{type}"), '')

        case type.downcase
          when 'delay'
            klass = Delay
          else
            klass = Default
        end

        details << klass.new(detail)
      end

      details
    end

    class Misc
      attr_reader :description

      def initialize str
        @event = 'Misc'
        @description = str
      end

      def event
        "[#{Time.now.strftime('%d/%m/%Y %H:%M')}]: #{@event}"
      end

      def to_s
        "#{event} - #{@description}"
      end
    end    

    class Delay
      class DelayFormatUnknown < Exception; end

      attr_reader :time, :departing, :terminating, :msg

      def initialize str
        @event = 'Delay'
        if result = str.scan(/(\d+:\d+) (.+) - (.+) - (.+)$/)
          time, @departing, @terminating, msg = result[0]

          @time = Time.parse(time)
          @msg = msg.gsub(/^\.*|\.*$/, '')
        else
          raise DelayFormatUnknown
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
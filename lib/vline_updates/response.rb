module VlineUpdates
  class Response

    def initialize xml
      @xml = Nokogiri::XML xml
    end

    def code
      @xml.xpath('//@code').first.value.to_i
    end

    def remaining
      @xml.xpath('//@remaining').first.value.to_i
    end

    def to_s
      "code: #{code}, remaining: #{remaining}"
    end
  end
end
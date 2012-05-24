module VlineUpdates
  class Request

    URL = 'https://www.notifymyandroid.com/publicapi/notify'

    def send payload
      Response.new(RestClient.post(URL, payload, opts))
    end

    def opts
      {
        'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.46 Safari/536.5'
      }
    end
  end
end
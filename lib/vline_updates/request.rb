module VlineUpdates
  class Request
    
    URL = 'https://www.notifymyandroid.com/publicapi/notify'

    def send payload
      Response.new(RestClient.post(URL, payload))
    end
  end
end
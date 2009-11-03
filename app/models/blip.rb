class Blip < ActiveResource::Base
  self.site = 'http://api.blip.pl'
  self.element_name = "update"
  self.user = "naszafaza"
  self.password = "alecool"
  self.headers['X-Blip-API'] = '0.02'
  self.headers['Accept'] = 'application/json'
  self.headers['User-Agent'] = 'nasza-faza'
  self.format = :json
end

class SendsmsController < ApplicationController

	def sendsms
		begin
		
		@clinet = HTTPClient.new('http://site25.way2sms.com/login1.action')
		
		@body = { 'username' => '9960655158', 'password' => '99606551' }
		@res = clnt.post(uri, body)


		rescue Exception=>e
			p "--------------------"
			p e
		end
	end
	def firstpage
	end
end

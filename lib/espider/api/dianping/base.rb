require 'digest/sha1'
require 'httparty'
require 'uri'
module ESpider
	module API
		module Dianping
			class Base
				Domain = "http://api.dianping.com"
				Version = "v1"
				def initialize(appkey,app_secret)
					@appkey = appkey
					@app_secret = app_secret
					@params = {}
				end
				def calc_digest
					@params.delete(:appkey)
					@params.delete(:sign)
					digest = Digest::SHA1.hexdigest(@appkey+@params.sort.map{|e| e[0].to_s+e[1].to_s}.join('')+@app_secret).upcase
					@params[:appkey] = @appkey
					@params[:sign] = digest
				end
				def get
					calc_digest
					@uri.query = URI.encode_www_form(@params)
					res = HTTParty.get @uri.to_s
					res.body
				end
				def next_page
					@params[:page] = @params[:page] + 1
					get
				end
			end
		end
	end
end
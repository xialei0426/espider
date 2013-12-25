module ESpider
	module Front
		module TA
			class TripAdvisor
				attr_accessor	:base_url
				def initialize(ta_id)
					url = base_url+ta_id
					res = HTTParty.get(url)
					@code = res.code
					@page = res.force_encoding("UTF-8")
				end
				def code
					@code
				end
				def rank
					ranks = []
					@page.scan(/(Vendor\(.*\);)$/) do |ota|
						ranks << ota[0].match(/\}\),\s*\".*\",/)[0].sub("}), \"","").sub("\",","")
					end
					ranks
				end
			end
		end
	end
end
require 'espider/front/ta/daodao'
require 'espider/front/ta/advisor'
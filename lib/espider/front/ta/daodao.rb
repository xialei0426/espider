module ESpider
	module Front
		module TA
			class Daodao < TA::TripAdvisor
				def initialize(ta_id)
					@base_url = "http://www.daodao.com/"
					super(ta_id)
				end
				def rank
					ranks = super
					ranks[0...ranks.size/2]
				end
			end
		end
	end
end

module ESpider
	module Front
		module TA
			class Advisor < TA::TripAdvisor
				def initialize(ta_id)
					@base_url = "http://www.tripadvisor.com/"
					super(ta_id)
				end
			end
		end
	end
end
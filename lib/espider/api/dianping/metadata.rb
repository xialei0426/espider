require 'active_support/core_ext/string/inflections'
module ESpider
	module API
		module Dianping
			class Metadata < ESpider::API::Dianping::Base
				BaseUri = File.join(Domain,Version,self.name.demodulize.downcase)
				Methods = [
					'get_cities_with_businesses',
					'get_regions_with_businesses',
					'get_categories_with_businesses',
					'get_cities_with_deals',
					'get_regions_with_deals',
					'get_categories_with_deals',
					'get_cities_with_coupons',
					'get_regions_with_coupons',
					'get_categories_with_coupons'
				]
				Methods.each do |method|
					define_method(method){init_methods(method)}
				end
				def init_methods(method_name)
					@uri = URI File.join(BaseUri,method_name.to_s)
					calc_digest
				end
			end
		end
	end
end
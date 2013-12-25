require 'active_support/core_ext/string/inflections'
module ESpider
	module API
		module Dianping
			class Business < ESpider::API::Dianping::Base
				BaseUri = File.join(Domain,Version,self.name.demodulize.downcase)
				include ESpider::API::Dianping
				def find_businesses(city=Param::EMPTY,region=Param::EMPTY,latitude=Param::EMPTY,longitude=Param::EMPTY)
					return false if city.empty? and (longitude.empty? or latitude.empty?)
					return false if city.empty? and !region.empty?
					@uri = URI File.join(BaseUri,__method__.to_s)
					method(__method__).parameters.each do |e| 
						param_value = eval(e[1].to_s)
						@params[e[1]]=param_value unless param_value.to_s.empty?
					end
					@params[:page] = Param::FIRST_PAGE
					@params[:platform] = Param::WEB_URL
					@params[:out_offset_type] = Param::OUT_GAODE_OFFSET
					@params[:offset_type] = Param::GAODE_OFFSET
					@params[:format] = Param::JSON
					@params[:limit] = Param::DEFAULT_LIMIT
					@params[:sort] = Param::SORT_BY_STAR
					true
				end
				def find_businesses_by_region
					
				end
				def get_single_business(business_id)
					@uri = URI File.join(BaseUri,__method__.to_s)
					@params['business_id'] = business_id
				end
				def set_category(category)
					@params[:category] = category
				end
			end
		end
	end
end
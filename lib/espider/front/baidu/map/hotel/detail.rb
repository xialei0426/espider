require 'nokogiri'
require 'httparty'
require 'uri'
module ESpider
	module Front
		module Baidu
			module Map
				module Hotel
					class Detail
						HotelUri = "http://map.baidu.com/detail"
						def initialize(uid)
							url = HotelUri + "?qt=ninf&uid=#{uid}"
							@hotel = JSON.parse HTTParty.get url
							true
						end
						def hotel_name
							@hotel['content']['name']
						end
						def hotel_addr
							@hotel['content']['addr']
						end
						def hotel_tel
							@hotel['content']['phone']
						end
						def hotel_geo
							@hotel['content']['geo'].split(/;/)[0].sub(/\d+\|/,"").split(',')
						end
						def hotel_star
							@hotel['content']['ext']['rich_info']['level']
						end
						def hotel_category
							@hotel['content']['ext']['rich_info']['category']
						end
						def hotel_price
							@hotel['content']['ext']['detail_info']['price']
						end
						def hotel_facility
							@hotel['content']['ext']['rich_info']['inner_facility']
						end
						def hotel_short_comm
							@hotel['content']['ext']['detail_info']['short_comm']
						end
						def hotel_review
							reviews = []
							@hotel['content']['ext']['review'].each do |r|
								reviews << r if r['name']!='elong'
							end
							reviews
						end
						def hotel_image(uid)
							url = HotelUri + "?qt=img&uid=#{uid}"
							parsed_json = JSON.parse HTTParty.get url
							parsed_json['images'].map{ |i| i['imgUrl']}
						end
					end
				end
			end
		end
	end
end
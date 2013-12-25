require 'nokogiri'
require 'httparty'
module ESpider
	module Front
		module Dianping
			module Hotel
				class List < ESpider::Front::Front
					attr_reader	:total
					BaseUri = "http://www.dianping.com/hotel/search/category"
					def initialize(cityId,areaId='')
						@cityId = cityId
						@areaId = areaId
						url = File.join(BaseUri,cityId,"60?district=#{areaId}")
						@list = Nokogiri::HTML(HTTParty.get(url, :headers => {"User-Agent" => "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)"}))
						@total = @list.css('div.tit span').text.sub(/[\(\)]/,'').to_i
					end
					def areas
						result = []
						areas = @list.css('div.filter-dist div.con div.list-box ul li')
						areas.each do |a|
							areaId = a.css('input').first['data-query-value']
							areaName = a.css('label').first.text.strip
							result << [areaId,areaName] if !result.include?([areaId,areaName])
						end
						areas = @list.css('div.filter-dist div.popup div.con dl dd')
						areas.each do |a|
							areaId = a.css('input').first['data-query-value']
							areaName = a.css('label').first.text.strip
							result << [areaId,areaName] if !result.include?([areaId,areaName])
						end
						result
					end
					def hotels(page)
						url = File.join(BaseUri,@cityId,'60',"p#{page}?district=#{@areaId}")
						@list = Nokogiri::HTML(HTTParty.get(url, :headers => {"User-Agent" => "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)"}))
						result = []
						hotels = @list.css('div.hotel-list-box div.h-list-box ul li.J_hotel-block')
						hotels.each do |hotel|
							hotel_id = hotel['data-shopid']
							hotel_name = hand_str_nil(hotel,'div.tit h4',true)
							hotel_tel = hand_str_nil(hotel,'div.hotel-info p span.tel',true)
							hotel.css('div.hotel-info p span.tel').remove
							hotel_addr = hand_str_nil(hotel,'div.hotel-info p.addr',true)
							hotel_area = hand_str_nil(hotel,'div.hotel-info p.place a',true)
							hotel_classify = hand_str_nil(hotel,'div.hotel-info p.tags em a',true)
							hotel_title = hand_str_nil(hotel,'div.hotel-info p.promo em a',false,'title')
							hotel_price = hand_str_nil(hotel,'div.hotel-remark div.price strong',true).sub('￥','')
							result << [hotel_id,hotel_name,hotel_addr,hotel_tel,hotel_area,hotel_classify,hotel_title,hotel_price]
						end
						result
					end
				end
			end
		end
	end
end
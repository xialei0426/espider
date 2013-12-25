require 'nokogiri'
require 'httparty'
require 'uri'
module ESpider
	module Front
		module Baidu
			module Map
				module Hotel
					class List
						attr_reader :total
						ListUri = "http://map.baidu.com/"
						def initialize(city_cn)
							@wd = URI.encode city_cn + '+' + '酒店'
							@pn=1
							url = ListUri+"?newmap=1&reqflag=pcmap&biz=1&qt=s&wd=#{@wd}&c=1&src=0&wd2=&sug=0&l=4&from=webmap&tn=B_NORMAL_MAP&nn=0&ie=utf-8"
							@hotels = HTTParty.get url
							@total = count_page_num
						end
						def next_page
							return false if (@pn+1)*10 > @total
							@pn += 1
							url = "http://map.baidu.com/?newmap=1&reqflag=pcmap&biz=1&qt=s&wd=#{@wd}&c=1&src=0&sug=0&l=4&from=webmap&rn=10&pl_data_type=hotel&pn=#{@pn}"
							p url
							@hotels = HTTParty.get url
							true
						end
						def list
							parsed_json = JSON.parse @hotels
							results = []
							return nil if parsed_json['content'].nil?
							parsed_json['content'].each do |hotel|
								results << hotel
							end
							results
						end
						private
						def count_page_num
							parsed_json = JSON.parse @hotels
							parsed_json['result']['total']
						end
					end
				end
			end
		end
	end
end
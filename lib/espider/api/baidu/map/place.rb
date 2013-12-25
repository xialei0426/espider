require 'nokogiri'
require 'httparty'
require 'uri'
module ESpider
	module Baidu
		module Map
			module API
				class Place
					FORMAT = {:JSON=>'json',:XML=>'xml'}
					INFO = {:ALL=>2,:BASIC=>1}
					FIRST_PAGE_NUM = -1
					BaseUri = "http://api.map.baidu.com/place/v2/search?"
					def initialize(key,page_size=10,info_type=INFO[:ALL],format=FORMAT[:JSON])
						@key = key
						@page_size = page_size
						@info_type = info_type
						@format = format
					end
					#城市内检索
					# http://api.map.baidu.com/place/v2/search?ak=您的密钥&output=json&query=酒店&page_size=10&page_num=5&scope=2&region=北京
					def search_by_city(query,region)
						@params = {:ak=>@key,:output=>@format,:query=>query,:page_size=>@page_size,:page_num=>FIRST_PAGE_NUM,:scope=>@info_type,:region=>region}
					end
					#矩形区域搜索
					#http://api.map.baidu.com/place/v2/search?ak=您的密钥&output=json&query=酒店&page_size=10&page_num=5&scope=2&bounds=39.915,116.404,39.975,116.414
					def search_by_rect(query,bounds)
						@params = {:ak=>@key,:output=>@format,:query=>query,:page_size=>@page_size,:page_num=>FIRST_PAGE_NUM,:scope=>@info_type,:bounds=>bounds}
					end
					#圆形区域检索
					# http://api.map.baidu.com/place/v2/search?ak=您的密钥&output=json&query=酒店&page_size=10&page_num=5&scope=2&location=39.915,116.404&radius=2000
					def search_by_round(query,location,radius)
						@params = {:ak=>@key,:output=>@format,:query=>query,:page_size=>@page_size,:page_num=>FIRST_PAGE_NUM,:scope=>@info_type,:location=>location,:radius=>radius}
					end
					def next_page
						@params[:page_num] = @params[:page_num] + 1
						get_page
					end
					def get_page
						@page = HTTParty.get File.join(BaseUri + URI.escape(@params.collect{|k,v| "#{k}=#{v}"}.join('&')))
						@page.body
					end
					def page_code
						@page.code
					end
					def total
						parsed_json = JSON.parse @page.body
						parsed_json['total']
					end
				end
			end
		end
	end
end
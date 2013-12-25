require 'nokogiri'
require 'httparty'
module ESpider
	module Front
		module Qunar
			class Hotel
				def initialize(qunar_id)
					@qunar_id = qunar_id
					@city = qunar_id[0..qunar_id.index("_",1)-1]
					url = "http://hotel.qunar.com/city/#{qunar_id[0..qunar_id.rindex("_",-1)-1]}/dt-#{qunar_id[qunar_id.rindex("_",-1)+1..qunar_id.length]}"
					@hotel = Nokogiri::HTML HTTParty.get(url)
				end
				def name
					name_tag = @hotel.search('//dl[@class="eriefinfo"]//dt').first
					return nil if name_tag.nil?
					name_tag.text[0..name_tag.text.index("\n",1)].strip
				end
				def prices
					mixKey = key
					fromDate = Date.today+1
					toDate = Date.today+2
					detailUrl = "http://hotel.qunar.com/render/detailV2.jsp?fromDate=#{fromDate}&toDate=#{toDate}&cityurl=#{@qunar_id[0..@qunar_id.rindex("_",-1)-1]}&HotelSEQ=#{@qunar_id}&lastupdate=-1&basicData=1&cn=1&mixKey=#{mixKey}"
					@detail = HTTParty.get(detailUrl)
					json_str = @detail.to_s.gsub(/\d{1,2}:\d{2}/,"").gsub(/\/\*[\s\S]*\*\//,"").gsub(/[\s\t\n()]/,"").gsub(/(\w+)\s*:/, '"\1":')
					json_str = json_str.gsub(/<em[^>]*>/,"")
					json_str = json_str.gsub(/<span[^>]*>/,"")
					json_str = json_str.gsub(/<\/span>/,"")
					json_str = json_str.gsub(/<\/em>/,"")
					return nil if json_str.length<20
					json_str = json_str[0..json_str.rindex("]",-1)+1]+"}"
					parsed_json = JSON.parse(json_str)
					return {} if parsed_json["result"].nil?
					prices = []
					parsed_json["result"].each do |r|
						no_room_type = r[1][9] 
						room_type=r[1][3] 
						ota=r[1][5]
						ota = "酒店直销" if ota.include?"直销"
						need_yufu = r[1][14]
						need_danbao = r[1][18]
						bao = (r[1][19])?1:0
						discount = r[1][10]
						final_price = r[1][0]
						original_price = discount+final_price
						gettime=Time.now.strftime("%Y-%m-%d %H:%M:%S")
						prices << {
							:hotel_name=>name,
							:room_type=>room_type ,
							:ota=>ota,
							:original_price=>original_price,
							:final_price=>final_price,
							:discount=>discount,
							:need_yufu => need_yufu,
							:need_danbao => need_danbao,
							:bao => bao,
							:star => star,
							:can_order => no_room_type,
							:gettime=>gettime
						} 
					end
					prices
				end
				def detailCode
					@detail.code
				end
				def star
					name_tag = @hotel.search('//dl[@class="eriefinfo"]//dt').first
					return 0 if name_tag.nil?
				  	if name_tag.text.include?'经济型'
				  		1
				  	elsif name_tag.text.include?'舒适型'
				  		3
				  	elsif name_tag.text.include?'高档型'
				  		4
				  	elsif name_tag.text.include?'豪华型'
				  		5
				  	elsif name_tag.text.include?'star20'
				  		2
				  	elsif name_tag.text.include?'star50'
				  		5
				  	else
				  		0
				  	end
				end
				def key
					node = @hotel.search('//span[@id="eyKxim"]').first
					return nil if node.nil?
				  	node.text
				end
				def citynameEn
					@city.strip
				end
				def citynameCn
					match_data = @hotel.to_s.match(/var\s*cityName\s*=\s*\'\p{Han}+\'/u)
					return "" if match_data.nil?
					match_data = match_data[0].match(/\p{Han}+/u)
					return "" if match_data.nil?
					match_data[0].strip
				end
				def id
					@qunar_id
				end
				def address
					address = @hotel.search("div[@class='adress']/span").first
					return "" if address.nil?
					return address['title'].strip
				end
				def phone
					phone ||= @hotel.search("//li[contains(text(),'电话：')]").text.sub('电话：','').strip
					phone
				end
				def desc
					desc = @hotel.search("p[@class='summery less_summery']").text
					desc = @hotel.search("p[@class='summery expan_summery']").text if desc.empty?
					desc.gsub(/[[:space:]]/, '')
				end
				#开业时间
				def insttime
					date ||= @hotel.search("p[@class='insttime']/cite").text.sub("开业时间：","")
					date.strip
				end
				#简略描述
				def abstract_desc
					abstract_desc = @hotel.search("p[@class='h_desc']").first
					return "" if abstract_desc.nil?
					return abstract_desc.text.sub('描述：','').strip
				end
				def brand
					brand ||= @hotel.search("//li[contains(text(),'所属品牌：')]").text.sub('所属品牌：','').strip
					brand.strip
				end
				def reference_price
					match_data = @hotel.to_s.match(/var\s*miniRetailPrice\s*=\s*\'\d+\';/)
					return 0 if match_data.nil?
					match_data = match_data[0].match(/[\d]+/)
					return 0 if match_data.nil?
					match_data[0].strip
				end
				def xy
					xy = @hotel.to_s.match(/hotelPoint=\[(\d+\.\d+),(\d+\.\d+)\];/)
					if xy.nil?
						return [0.0,0.0]
					else
						return [xy[1],xy[2]]
					end
				end
				#设施
				def facilities
					facility = @hotel.search("//div[@class=\"roundmilieu htintroborder\"]").first
					facilities = Array.new()
					unless facility.nil?
					facility.search("dl").each do |dl|
						ele = Hash.new
						facility_cata = dl.search("dt").first.text.delete('：')
						ele1 = Array.new
						dl.search("dd/ul/li").each do |facility_type|
							ele1 << facility_type.text
							end
							ele['name'] = facility_cata
							ele['info'] = ele1
							facilities << ele
						end
					end
					facilities
				end
				#交通信息
				def traffic
					traffic = "http://hotel.qunar.com/detail/detailMapData.jsp?seq=#{@qunar_id}&type=traffic,canguan,jingdian,ent"
					traffic = HTTParty.get traffic
					traffic_data = Array.new()
					if traffic['ret'] == true
					traffic['data']['ent'].each do |line|
						ele = Hash.new
						ele['name'] = line['name']
						ele['distance'] = line['distance']
						traffic_data << ele
						end
					end
					traffic_data
				end
				def decorate_date
					match_data = @hotel.to_s.match(/最后装修时间：\d+年/)
					return "" if match_data.nil?
					match_data[0].strip
				end
				def comments
					url = "http://review.qunar.com/api/h/#{@qunar_id}/detail/rank/v1/page/1"
					comments = HTTParty.get url
					comments = JSON.parse comments
					comments['data']['list'].map{|comment| JSON.parse(comment['content'])['feedContent'] }
				end
				#评论总数
				def total_comment
					url = "http://review.qunar.com/api/h/#{@qunar_id}/detail/rank/page/1?rate=all"
					body = HTTParty.get url
					match_data = body.match(/"count":\d+/)
					return "0" if match_data.nil?
					match_data[0].sub(/\"count\":/,"").strip
				end
				#好评
				def good_comment
					url = "http://review.qunar.com/api/h/#{@qunar_id}/detail/rank/page/1?rate=positive"
					body = HTTParty.get url
					match_data = body.match(/"count":\d+/)
					return "0" if match_data.nil?
					match_data[0].sub(/\"count\":/,"")
				end
				def images
					url = "http://hotel.qunar.com/render/hotelDetailAllImage.jsp?hotelseq=#{@qunar_id}"
					body = HTTParty.get url
					body = JSON.parse(body)
					return body['data']["all"] if(body['ret'])
				end
				def score
					url = "http://review.qunar.com/api/h/#{@qunar_id}/detail"
					body = HTTParty.get url
					begin
						body = JSON.parse body
						return body["data"]["score"].strip
					rescue Exception => e
						return "0.0"
					end	
				end
			end
		end
	end
end
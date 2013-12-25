require 'uri'
require 'httparty'
require 'nokogiri'
module ESpider
  module Front
    module Kuxun
      class Detail
        #id example:
        #beijing-xihuajingzhao
        def initialize(id)
          @id = id
          @host = 'jiudian.kuxun.cn'
          @current_url = URI::HTTP.build(
              :host => @host,
              :path => "/#{@id}-jiudian.html"
          ).to_s
          @options = {
            :headers => {
              "User-Agent" => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.95 Safari/537.36'
            }
          }
          @hotel = Nokogiri::HTML(HTTParty.get(@current_url,@options))
        end

        def name
          @title ||= @hotel.search("h1").first.text.strip
        end

        def address
          @address ||= title_bd.search('p').first.text.gsub!(/\s+/, ' ').squeeze.strip
        end

        def intro
          return '' if title_bd.search('p')[1].nil?
          title_bd.search('p')[1].text.squeeze.gsub('描述：','').strip
        end

        #example:
        #[{:text=>"客房", :small_pic=>"http://s2.static.hotel.kximg.cn/e1310221716/HA/78805a221a988e79ef3f42d7c1029790.I.Q.FH.jpg", :big_pic=>"http://s2.static.hotel.kximg.cn/e1310221716/HA/78805a221a988e79ef3f42d7c1029790.I.Q.FI.jpg"}, {:text=>"客房", :small_pic=>"http://s2.static.hotel.kximg.cn/e1310221716/HA/78805a221a988e79ef3f42d7c1029794.I.Q.FH.jpg", :big_pic=>"http://s2.static.hotel.kximg.cn/e1310221716/HA/78805a221a988e79ef3f42d7c1029794.I.Q.FI.jpg"}, {:text=>"客房", :small_pic=>"http://s2.static.hotel.kximg.cn/e1310221716/HA/78805a221a988e79ef3f42d7c1029795.I.Q.FH.jpg", :big_pic=>"http://s2.static.hotel.kximg.cn/e1310221716/HA/78805a221a988e79ef3f42d7c1029795.I.Q.FI.jpg"}
        def images
          url = URI::HTTP.build(
              :host => @host,
              :path => "/#{@id}-jiudian-tupian.html"
          ).to_s
          options = {
            :headers => {
              "User-Agent" => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.95 Safari/537.36'
            }
          }
          @images = Nokogiri::HTML(HTTParty.get(url,@options))
          results = []
          @images.search("//ul[@id='detail_image_全部']/li").each do |li|
            img = li.search('img').first['src']
            img = li.search('img').first['original'] if img.include?'grey.gif'
            title = li.search('p').first
            results << {
              :text => title.text,
              :small_pic => img,
              :big_pic => img.sub(/H.jpg$/,'I.jpg')
            }
          end
          results
        end
        #example:
        #[{"title"=>"酒店设施", "tags"=>["商务中心", "送餐服务", "洗衣服务", "叫醒服务", "旅游服务", "前台贵重物品保险柜", "收费停车", "外币兑换", "公共区域免费Wi-Fi"]}, {"title"=>"康体娱乐", "tags"=>["电子游戏机室"]}, {"title"=>"会议设施", "tags"=>["多功能厅：剧院式可容纳80人", "另有2个会议室，均容纳30人"]}, {"title"=>"餐饮服务", "tags"=>["中餐厅：主营鲁菜、川菜、可提供北京风味小吃", "西餐厅：可提供中西自助餐、酒水"]}]
        def facilities
          return @facilities if @facilities
          @facilities = []
          @hotel.search("//ul[@class='OpenFacCont']/li").each do |li|
            title = li.search('b').first.text.strip
            tags = li.search('p').first.text.strip.sub(/。$/,'')
            if tags.include?'；'
              tags = tags.split('；')
            else
              tags = tags.split('、')
            end
            @facilities << {
              'title' => title,
              'tags' => tags
            }
          end
          @facilities
        end

        private
        def title_bd
          @TitleBd ||= @hotel.search("//div[@class='TitleBd']").first
        end
      end
    end
  end
end


module ESpider
    module Front
        module Dianping
            module Hotel
                class Detail
                    def initialize(id)
                        @host = 'www.dianping.com'
                        @id = id
                        @current_url = URI::HTTP.build(
                          :host => @host,
                          :path => "/shop/#{id}"
                        ).to_s
                        @options = {
                          :headers => {
                              "User-Agent" => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.95 Safari/537.36'
                          }
                        }
                        @hotel = Nokogiri::HTML(HTTParty.get(@current_url,@options))
                        @js = @hotel.search("//script[@class='J_auto-load']").map{|script|script.inner_html}.join("\n")
                        @js = Nokogiri::HTML(@js)
                    end

                    def name
                        @hotel.search("//h1").first.text
                    end

                    def intro
                        @js.search("//div[@class='intro-txt J_hotel-expand']/span[@class='Hide']").text
                    end

                    #return example:
                    #[{"title"=>"客房设施", "tags"=>["国内长途电话", "国际长途电话", "拖鞋", "雨伞", "书桌", "24小时热水", "电热水壶", "咖啡壶/茶壶", "免费洗漱用品(6样以上)", "免费瓶装水", "迷你吧", "小冰箱", "浴衣", "多种规格电源插座", "110V电压插座", "浴缸", "独立淋浴间", "吹风机", "房内保险箱", "中央空调"]}, {"title"=>"服务项目", "tags"=>["棋牌室", "室内游泳池", "健身室", "按摩室", "桑拿浴室", "足浴", "SPA", "烧烤"]}, {"title"=>"活动设施", "tags"=>["中餐厅", "西餐厅", "酒吧", "前台贵重物品保险柜", "免费停车场", "有可无线上网的公共区域", "大堂吧", "电梯", "有可无线上网的公共区域 免费"]}, {"title"=>"综合设施", "tags"=>["会议厅", "商务中心", "外币兑换服务", "旅游票务服务", "洗衣服务", "送餐服务", "专职行李员", "行李寄存", "叫醒服务", "接机服务"]}]
                    def facilities
                        return @facilities if @facilities
                        @facilities = []
                        @js.search("//div[@class='introd-box']//li").each do |li|
                            facility = {}
                            title = li.search("span[@class='tit']").first
                            next unless title
                            facility['title'] = title.text
                            facility['tags'] = []
                            li.search("span[@class='introd-tag']").each do |tag|
                                facility['tags'] << tag.text
                            end
                            @facilities << facility
                        end
                        @facilities
                    end

                    #return example:
                    #[{:url=>"http://www.dianping.com/photos/38858830", :text=>"门面", :small_pic=>"http://i2.s2.dpfile.com/pc/e96f1f5f242450480d4de87007a1649a(240c180)/thumb.jpg", :big_pic=>"http://i2.s2.dpfile.com/pc/e96f1f5f242450480d4de87007a1649a(700x700)/thumb.jpg"}, {:url=>"http://www.dianping.com/photos/38858827", :text=>"门面", :small_pic=>"http://i3.s2.dpfile.com/pc/f6f8e9d56d045db113cfc2808be5a88a(240c180)/thumb.jpg", :big_pic=>"http://i3.s2.dpfile.com/pc/f6f8e9d56d045db113cfc2808be5a88a(700x700)/thumb.jpg"}, {:url=>"http://www.dianping.com/photos/38858820", :text=>"门面", :small_pic=>"http://i2.s2.dpfile.com/pc/55cbdffa6d8c0d5c51e7b44e5c55cf3d(240c180)/thumb.jpg", :big_pic=>"http://i2.s2.dpfile.com/pc/55cbdffa6d8c0d5c51e7b44e5c55cf3d(700x700)/thumb.jpg"}, {:url=>"http://www.dianping.com/photos/38858806", :text=>"门面", :small_pic=>"http://i2.s2.dpfile.com/pc/5a4c29f16cac2a3149f4f041358d339d(240c180)/thumb.jpg", :big_pic=>"http://i2.s2.dpfile.com/pc/5a4c29f16cac2a3149f4f041358d339d(700x700)/thumb.jpg"}, {:url=>"http://www.dianping.com/photos/38858804", :text=>"门面", :small_pic=>"http://i3.s2.dpfile.com/pc/6d5c9ae960783b449802c8646eb14adc(240c180)/thumb.jpg", :big_pic=>"http://i3.s2.dpfile.com/pc/6d5c9ae960783b449802c8646eb14adc(700x700)/thumb.jpg"}, {:url=>"http://www.dianping.com/photos/38858801", :text=>"门面", :small_pic=>"http://i3.s2.dpfile.com/pc/e5f317a5ba775b05b1e0807492458ce1(240c180)/thumb.jpg", :big_pic=>"http://i3.s2.dpfile.com/pc/e5f317a5ba775b05b1e0807492458ce1(700x700)/thumb.jpg"}, {:url=>"http://www.dianping.com/photos/38858799", :text=>"门面", :small_pic=>"http://i2.s2.dpfile.com/pc/029f661b83bfd0550e858c3f78da8646(240c180)/thumb.jpg", :big_pic=>"http://i2.s2.dpfile.com/pc/029f661b83bfd0550e858c3f78da8646(700x700)/thumb.jpg"}, {:url=>"http://www.dianping.com/photos/38858782", :text=>"门面", :small_pic=>"http://i2.s2.dpfile.com/pc/2de4d7be0ad68aa43b82ba2bfb1f9934(240c180)/thumb.jpg", :big_pic=>"http://i2.s2.dpfile.com/pc/2de4d7be0ad68aa43b82ba2bfb1f9934(700x700)/thumb.jpg"}, {:url=>"http://www.dianping.com/photos/38858781", :text=>"门面", :small_pic=>"http://i1.s2.dpfile.com/pc/43b5d236fe1d2ce03b14b0894feec4c6(240c180)/thumb.jpg", :big_pic=>"http://i1.s2.dpfile.com/pc/43b5d236fe1d2ce03b14b0894feec4c6(700x700)/thumb.jpg"}, {:url=>"http://www.dianping.com/photos/38858777", :text=>"门面", :small_pic=>"http://i3.s2.dpfile.com/pc/4e9c512465435d767aa151068acaa45e(240c180)/thumb.jpg", :big_pic=>"http://i3.s2.dpfile.com/pc/4e9c512465435d767aa151068acaa45e(700x700)/thumb.jpg"}, {:url=>"http://www.dianping.com/photos/38858769", :text=>"门面", :small_pic=>"http://i3.s2.dpfile.com/pc/6a9bfc9811d4575ff3cc192b505e7453(240c180)/thumb.jpg", :big_pic=>"http://i3.s2.dpfile.com/pc/6a9bfc9811d4575ff3cc192b505e7453(700x700)/thumb.jpg"}, {:url=>"http://www.dianping.com/photos/38858762", :text=>"大堂", :small_pic=>"http://i2.s2.dpfile.com/pc/52c4cc845cfbb32b0ca00bf5a3911ee0(240c180)/thumb.jpg", :big_pic=>"http://i2.s2.dpfile.com/pc/52c4cc845cfbb32b0ca00bf5a3911ee0(700x700)/thumb.jpg"}, {:url=>"http://www.dianping.com/photos/38858758", :text=>"门面", :small_pic=>"http://i3.s2.dpfile.com/pc/47a152e45d30b0edf67d17d0a9807fcf(240c180)/thumb.jpg", :big_pic=>"http://i3.s2.dpfile.com/pc/47a152e45d30b0edf67d17d0a9807fcf(700x700)/thumb.jpg"}, {:url=>"http://www.dianping.com/photos/38858752", :text=>"大堂", :small_pic=>"http://i3.s2.dpfile.com/pc/eff2b60723a6d119b9da4e97d6af9639(240c180)/thumb.jpg", :big_pic=>"http://i3.s2.dpfile.com/pc/eff2b60723a6d119b9da4e97d6af9639(700x700)/thumb.jpg"}, {:url=>"http://www.dianping.com/photos/38858748", :text=>"大堂", :small_pic=>"http://i1.s2.dpfile.com/pc/3b5ae0aef1409cbb7196c880473e6142(240c180)/thumb.jpg", :big_pic=>"http://i1.s2.dpfile.com/pc/3b5ae0aef1409cbb7196c880473e6142(700x700)/thumb.jpg"}]
                    def images
                        url = URI::HTTP.build(
                          :host => @host,
                          :path => "/shop/#@id/photos"
                        )
                        images = Nokogiri::HTML(HTTParty.get(url.to_s,@options))
                        results = []
                        images.search("//li[@class='J_list']").each do |image|
                            href = image.search("div/a").first['href']
                            text = image.search("h3/a").text
                            thumb = image.search("img").first['src']
                            results << {
                                :url => URI.join(@current_url,href).to_s,
                                :text => text,
                                :small_pic => thumb,
                                :big_pic => thumb.sub(/\(.+\)/,'(700x700)')
                            }
                        end
                        results
                    end

                    def comments
                       @hotel.search("//div[@class='J_brief-cont']").map{|comment|comment.text.strip}
                    end
                end
            end
        end
    end
end
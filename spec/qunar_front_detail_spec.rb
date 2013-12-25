#coding: UTF-8
require 'spec_helper'
describe "qunar信息抓取测试" do
	qunar_id = "beijing_city_2807"
	city = "beijing_city"
	hotel = ESpider::Front::Qunar::Hotel.new(qunar_id)
	it 'should 被正确实例化' do
		hotel.should be_an_instance_of ESpider::Front::Qunar::Hotel
	end
	it 'should 返回酒店名称' do
		hotel.name.should == '汉庭酒店北京后海店'  
	end
	it 'should 返回正确格式的ota报价信息' do
		hotel.prices.should_not be_empty   
		hotel.prices[0].should have_key(:hotel_name)
		hotel.prices[0].should have_key(:room_type)
		hotel.prices[0].should have_key(:ota)
		hotel.prices[0].should have_key(:original_price)
		hotel.prices[0].should have_key(:final_price)
		hotel.prices[0].should have_key(:discount)
		hotel.prices[0].should have_key(:need_yufu )
		hotel.prices[0].should have_key(:need_danbao ) 
		hotel.prices[0].should have_key(:bao ) 
		hotel.prices[0].should have_key(:star ) 
		hotel.prices[0].should have_key(:can_order ) 
		hotel.prices[0].should have_key(:gettime)
	end
	# it 'should return name' do
	# 	hotel.star.should >= 0
	# 	hotel.star.should <= 5
	# end
	it 'should 返回qunar酒店星级' do
		hotel.star.should == 1
	end
	it 'should 返回qunar酒店城市英文名' do
		hotel.citynameEn.should == 'beijing'
	end
	it 'should 返回qunar酒店id' do
		hotel.id.should == 'beijing_city_2807'
	end
	it 'should 返回qunar酒店地址' do
		hotel.address.should == '北京市东城区交道口南大街菊儿胡同33号'
	end
	it 'should 返回qunar酒店电话' do
		hotel.phone.should == '010-64061188'
	end
	it 'should 返回qunar酒店描述' do
		hotel.desc.class.should == String 
	end
	it 'should 返回qunar酒店开业日期' do
		hotel.insttime.should == '2008年'
	end
	it 'should 返回qunar酒店概述' do
		hotel.abstract_desc.should == '位于北京市东城区菊儿胡同、紧邻北二环主干线。网友评价说“小吃很多也便宜”。'
	end
	it 'should 返回qunar酒店品牌' do
		hotel.brand.should == '汉庭酒店'
	end
	it 'should 返回qunar酒店参考价格' do
		hotel.reference_price.should == '120'
	end
	it 'should 返回qunar酒店google经纬度' do
		hotel.xy.should == ["39.939323", "116.4054"]
	end
	it 'should 返回qunar酒店设施' do
		hotel.facilities.should == [{"name"=>"房间设施", "info"=>["宽带上网", "空调", "暖气", "24小时热水", "吹风机", "国际长途电话"]}, {"name"=>"酒店服务", "info"=>["接待外宾", "叫醒服务", "行李寄存", "洗衣服务", "租车", "早餐服务"]}, {"name"=>"酒店设施", "info"=>["无线上网公共区域", "停车场", "无烟房", "中式餐厅", "会议室", "商务中心"]}]
	end
	# it 'should 返回qunar交通信息' do
	# 	hotel.traffic.should == [{"name"=>"战鼓楼", "distance"=>"594.056489643499"}, {"name"=>"蓬蒿剧场", "distance"=>"395.18496791364"}, {"name"=>"中央戏剧学院实验剧场", "distance"=>"425.239611398247"}, {"name"=>"和中堂足道(交道口店)", "distance"=>"488.729152256305"}, {"name"=>"周末相声俱乐部", "distance"=>"524.822582351895"}, {"name"=>"鲸鱼桌游吧", "distance"=>"790.623187595583"}, {"name"=>"一来二去桌游主题休闲吧", "distance"=>"988.900711965127"}, {"name"=>"东城区文化馆", "distance"=>"606.324700795644"}, {"name"=>"国话小剧场", "distance"=>"757.099876935085"}, {"name"=>"东城区图书馆", "distance"=>"661.53698062375"}]
	# end
	it 'should 返回qunar酒店最后装修时间' do
		hotel.decorate_date.should == ''
	end
	# it 'should 返回qunar酒店评论' do
	# 	hotel.comments.should == ''
	# end
	# it 'should 返回qunar酒店评论总数' do
	# 	hotel.total_comment.should_not = '339'
	# end
	# it 'should 返回qunar酒店评论好评数' do
	# 	hotel.good_comment.should_not = '250'
	# end
	# it 'should 返回qunar酒店图片' do
	# 	hotel.images.should == ''
	# end
	it 'should 返回qunar酒店评分' do
		hotel.score.to_f.should < 10.0
	end
	it 'should 返回qunar酒店城市中文名' do
		hotel.citynameCn.should == '北京'
	end
	it 'should 返回qunar酒店城市英文名' do
		hotel.citynameEn.should == 'beijing'
	end
end

#coding:utf-8
require 'spec_helper'
describe "百度地图酒店信息抓取测试" do 
	hotel_list = ESpider::Front::Baidu::Map::Hotel::List.new('黔西南')
	hotels = hotel_list.list
	hotels_count = hotel_list.total
	page_num = hotels_count/10
	hotel = ESpider::Front::Baidu::Map::Hotel::Detail.new('1258371975449935871')
	it "should 被实例化" do
		hotel_list.should be_an_instance_of ESpider::Front::Baidu::Map::Hotel::List
		hotel.should be_an_instance_of ESpider::Front::Baidu::Map::Hotel::Detail
	end
	it "should 正确解析酒店数量" do 
		hotels_count.should be_an_instance_of Fixnum
	end
	it "should 正确返回酒店列表信息" do
		hotels.should be_an_instance_of Array
		hotels[0].should be_an_instance_of Hash
	end
	it "should 返回酒店名称" do
		hotel.hotel_name.should be_an_instance_of String
	end
	it "should 返回酒店地址" do
		hotel.hotel_addr.should be_an_instance_of String
	end
	it "should 返回酒店电话" do
		hotel.hotel_tel.should be_an_instance_of String
	end
	it "should 返回酒店经纬度" do
		hotel.hotel_geo.should be_an_instance_of Array
	end
	it "should 返回酒店星级" do
		hotel.hotel_star.should be_an_instance_of String
	end
	it "should 返回酒店类别" do
		hotel.hotel_category.should be_an_instance_of String
	end
	it "should 返回酒店价格" do
		hotel.hotel_price.should be_an_instance_of String
	end
	it "should 返回酒店设施" do
		hotel.hotel_facility.should be_an_instance_of String
	end
	it "should 返回酒店短评" do
		hotel.hotel_short_comm.should be_an_instance_of String
	end
	it "should 返回酒店评论" do
		hotel.hotel_review.should be_an_instance_of Array
	end
	it "should 返回酒店图片地址" do
		hotel.hotel_image('669775d035aa1b42fd0eb008').should be_an_instance_of Array
	end
end
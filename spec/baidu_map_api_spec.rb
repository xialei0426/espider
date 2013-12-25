#coding:utf-8
require 'spec_helper'
describe "百度地图api测试" do 
	place = ESpider::Baidu::Map::API::Place.new('KNFShrAjm3BvgNEsNLfPSlAP')
	it "should 被实例化" do
		place.class.should == ESpider::Baidu::Map::API::Place
	end
	it "城市内检索请求" do
		place.search_by_city('酒店', '北京')
		place.next_page.class.should == String
	end
	it "矩形框检索请求" do
		place.search_by_rect('酒店', '39.915,116.404,39.975,116.414')
		place.next_page.class.should == String
	end
	it "圆形框检索请求" do
		place.search_by_city('酒店', '北京')
		place.next_page.class.should == String
	end
	it "http状态码为200" do
		place.page_code.should == 200
	end
	it	"正确翻页" do
		place.next_page.class.should == String
		place.page_code.should == 200
	end
	it "获得查询结果总量" do 
		place.search_by_city('酒店', '北京')
		place.total.class.should == Fixnum
	end
end
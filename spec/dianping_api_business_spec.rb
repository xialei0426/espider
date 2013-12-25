require 'spec_helper'
describe "大众点评api测试,business类api" do 
	# it '正确实例化' do
	# 	busi = ESpider::API::Dianping::Business.new('16935220','0c3d163c8fff4639a3372aea71df52a1')
	# 	busi.class.should == ESpider::API::Dianping::Business
	# end
	# it '正确调用find_businesses接口,传入经纬度信息' do
	# 	busi = ESpider::API::Dianping::Business.new('16935220','0c3d163c8fff4639a3372aea71df52a1')
	# 	busi.find_businesses('上海','','31.18268013000488','121.42769622802734').should == true
	# 	busi.get.class.should == String
	# end
	# it '正确调用find_businesses接口,并翻页' do
	# 	busi = ESpider::API::Dianping::Business.new('16935220','0c3d163c8fff4639a3372aea71df52a1')
	# 	busi.find_businesses('上海','','31.18268013000488','121.42769622802734').should == true
	# 	busi.get.class.should == String
	# 	p busi.get
	# 	busi.next_page.class.should == String
	# end
	# it '正确调用find_businesses接口，加入分类信息' do
	# 	busi = ESpider::API::Dianping::Business.new('16935220','0c3d163c8fff4639a3372aea71df52a1')
	# 	busi.find_businesses('上海','','31.18268013000488','121.42769622802734').should == true
	# 	busi.set_category('酒店')
	# 	busi.next_page.class.should == String
	# end
	it '正确调用/get_single_business接口，返回单个商户信息' do
		busi = ESpider::API::Dianping::Business.new('16935220','0c3d163c8fff4639a3372aea71df52a1')
		busi.get_single_business('8733744').should be_instance_of String
	end
end
require 'spec_helper'
describe "ESpider::Front::Dianping::Hotel::List" do
	list = ESpider::Front::Dianping::Hotel::List.new('1')
	it '实例化' do
		list.should be_instance_of ESpider::Front::Dianping::Hotel::List
	end
	it '返回名称' do
		list.should be_instance_of ESpider::Front::Dianping::Hotel::List
	end
	it '返回酒店列表' do
		list.hotels(1).should be_instance_of Array
	end
	it '正确计算酒店数量' do
		list = ESpider::Front::Dianping::Hotel::List.new('2','1489')
		list.total.should be_instance_of Fixnum
	end
end
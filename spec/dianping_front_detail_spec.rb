require 'spec_helper'
describe "ESpider::Front::Dianping::Hotel::Detail" do
	it '实例化' do
		detail = ESpider::Front::Dianping::Hotel::Detail.new('2136037')
		detail.should be_instance_of ESpider::Front::Dianping::Hotel::Detail
	end
	it '返回酒店名称' do
		detail = ESpider::Front::Dianping::Hotel::Detail.new('2136037')
		detail.name.should be_instance_of String
	end
	it '返回酒店描述' do
		detail = ESpider::Front::Dianping::Hotel::Detail.new('2869420')
		detail.intro.should be_instance_of String
	end
	it '返回酒店设施' do
		detail = ESpider::Front::Dianping::Hotel::Detail.new('2869420')
		detail.facilities.should be_instance_of Array
	end
	it '返回酒店图片' do
		detail = ESpider::Front::Dianping::Hotel::Detail.new('2869420')
		detail.images.should be_instance_of Array
	end
	it '返回酒店评论' do
		detail = ESpider::Front::Dianping::Hotel::Detail.new('2869420')
		detail.comments.should be_instance_of Array
	end
end
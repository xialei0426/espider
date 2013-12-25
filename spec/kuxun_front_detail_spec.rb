require 'spec_helper'
describe "ESpider::Front::Kuxun::Detail" do
	detail = ESpider::Front::Kuxun::Detail.new('beijing-tangfuzhongshiwenhua')
	it '实例化' do
		detail.should be_instance_of ESpider::Front::Kuxun::Detail
	end
	it '返回酒店名称' do
		detail.name.should be_instance_of String
	end
	it '返回酒店地址' do
		detail.address.should be_instance_of String
	end
	it '返回酒店描述' do
		detail.intro.should be_instance_of String
	end
	it '返回酒店设施' do
		detail.facilities.should be_instance_of Array
	end
	it '返回酒店图片' do
		detail.images.should be_instance_of Array
	end
end
require 'spec_helper'
describe 'Advisor' do
	it '正确实例化' do
		ad = ESpider::Front::TA::Advisor.new('199326')
		ad.should be_an_instance_of ESpider::Front::TA::Advisor
	end
	it '正确解析排名数据' do
		ad = ESpider::Front::TA::Advisor.new('199326')
		ad.rank.should be_an_instance_of Array
	end
end
require 'spec_helper'
describe 'Daodao' do
	it '正确实例化' do
		dd = ESpider::Front::TA::Daodao.new('199326')
		dd.should be_an_instance_of ESpider::Front::TA::Daodao
	end
	it '正确解析排名数据' do
		dd = ESpider::Front::TA::Daodao.new('199326')
		dd.rank.should be_an_instance_of Array
	end
end
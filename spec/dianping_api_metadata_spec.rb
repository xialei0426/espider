#coding:utf-8
require 'spec_helper'
describe "大众点评api测试,metadata类api" do 
	mdata = ESpider::API::Dianping::Metadata.new('16935220','0c3d163c8fff4639a3372aea71df52a1')
	it '正确实例化' do
		mdata.class.should == ESpider::API::Dianping::Metadata
	end
	it '获取支持商户搜索的最新城市列表' do
		mdata.get_cities_with_businesses
		mdata.get.class.should == String
	end
	it '获取支持商户搜索的最新城市下属区域列表 ' do
		mdata.get_regions_with_businesses
		mdata.get.class.should == String
	end
	it '获取支持商户搜索的最新分类列表 ' do
		mdata.get_categories_with_businesses
		mdata.get.class.should == String
	end
	it '获取支持团购搜索的最新城市列表 ' do
		mdata.get_cities_with_deals
		mdata.get.class.should == String
	end
	it '获取支持团购搜索的最新城市下属区域列表 ' do
		mdata.get_regions_with_deals
		mdata.get.class.should == String
	end
	it '获取支持团购搜索的最新分类列表 ' do
		mdata.get_categories_with_deals
		mdata.get.class.should == String
	end
	it '获取支持优惠券搜索的最新城市列表 ' do
		mdata.get_cities_with_coupons
		mdata.get.class.should == String
	end
	it '获取支持优惠券搜索的最新城市下属区域列表 ' do
		mdata.get_regions_with_coupons
		mdata.get.class.should == String
	end
	it '获取支持优惠券搜索的最新分类列表 ' do
		mdata.get_categories_with_coupons
		mdata.get.class.should == String
	end
end
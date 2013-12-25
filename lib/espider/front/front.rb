module ESpider
	module Front
		class Front
			def hand_str_nil(src,rule,is_text,attr_name=nil)
				if is_text
					node = src.css(rule).first
					if node.nil?
						''
					else
						node.text.strip
					end
				else
					node = src.css(rule).first
					if node.nil?
						''
					else
						node[attr_name]
					end
				end
			end
		end
	end
end
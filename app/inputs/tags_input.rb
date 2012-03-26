class TagsInput < Formtastic::Inputs::StringInput
	def to_html
		puts "this is my modified version of StringInput"
		input_wrapping do
			label_html <<
      builder.hidden_field(method, input_html_options) + "<ul class='tags_input'></ul>".html_safe
		end
	end
	
	def tags_html
		content_tag(:ul, :class => "list") do
			collection.collect do |member|
				content_tag(:li, :id => member.name.gsub(' ', '-').downcase.strip) do
					member.name
				end
			end
		end
	end
end

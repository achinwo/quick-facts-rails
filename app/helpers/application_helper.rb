module ApplicationHelper

	APP_TITLE = "Quick Facts"

	def get_page_title(page_title='')
		if !page_title.empty?
			app_title = "#{APP_TITLE} | #{page_title}"
		else
			app_title = APP_TITLE
		end
	end
end

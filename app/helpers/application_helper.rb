module ApplicationHelper

	def org_count
		@app_books_count
	end
#book is user here
	def display_my_html(book, opts={})

		if book == 999
			name = 'Reach user'
		else	
		  theid = book.id
		  name = book.email.upcase
		  html_class = opts.key?(:html_class) ? opts[:html_class] : "normal"

	  	end
	  render "shared/chatbot", name: name, theid: theid, html_class: html_class
	end
end

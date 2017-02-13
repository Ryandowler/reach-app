class BooksController < ApplicationController

	#impressionist actions: [:show], unique: [:session_hash]
	impressionist actions: [:show]




	#this is a 'before action', it gets ran before any of these actions are used
	#it uses the method i made (find_book) thats down the end
	#only want it to run for certain actions though
	before_action :find_book, only: [:show, :edit, :update, :destroy]

	def payment_cancel
	  @payment_cancel = "payment_cancel"
	end


	def index
		if params[:category].blank?
			@books = Book.all.order("page_count ASC")
			@books_no_order = Book.all.order(created_at: :desc).limit(10)



			#@myyy = @book.impressionist_count(:start_date=>Date.today)
			#@orgs_category_of_the_day = Book.where(["page_count > ?", 100])


		else
			@category_id = Category.find_by(name: params[:category]).id
			@books = Book.where(:category_id => @category_id).order("created_at DESC")
		end
	end 

	def show
		@book = Book.find(params[:id])
		@resources = Resource.all.map { |c| [c.tittle, c.id] }
		#@resy1 = Resource.find(params[:id]) 
		@resy2 = Resource.where(:book_id => params[:id])

		# -- get user that created current resource --
		@user = User.find(@book.user_id)

		#works too
		#@resy4 = Resource.find_by book_id: params[:id]

		#being used (gets the resources with the FK book_id the same as the current book's id PK)
		@resy5 = Resource.where(["book_id = ?", params[:id]])

		impressionist(@book)
	end

	def new
		if signed_in?
			@book = current_user.books.build
			@categories = Category.all.map { |c| [c.name, c.id] }
			@resources = Resource.all.map { |r| [r.tittle, r.id] }
		end	
	end

	def create
		@book = current_user.books.build(book_params)
		@book.category_id = params[:category_id]
		@book.my_file = params[:file]
		if @book.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
		@categories = Category.all.map { |c| [c.name, c.id] }
		
	end

	def update
		@book.category_id = params[:category_id]
		if @book.update(book_params)
			redirect_to book_path(@book)
		else
			render 'edit'
		end
	end

	def destroy
		@book.destroy
		redirect_to root_path

	end

	private

		def book_params
			params.require(:book).permit(:title, :description, :author, :category_id, :my_file, :address)
		end

		def find_book
			@book = Book.find(params[:id])

			#if the view is being requested for a org thats been eithe deleted or never existed
			#redirect back to front feed
			rescue ActiveRecord::RecordNotFound
  			redirect_to root_path, :flash => { :error => 
  				"<div class='col-md-12' style='margin-left: -20px; padding-bottom: 3em;'>
					<div class='col-md-6 noOrgsError' onclick='scrollToFeed()'>
						<h2 class='col-md-11'>We cant find that Organization</h2>
						<h3 class='col-md-11'>But there are lots down there</h3>
						<h2 class='col-md-1'><span class='glyphicon glyphicon-arrow-down'></span></h2>
					</div>
				</div>"}
		end





end

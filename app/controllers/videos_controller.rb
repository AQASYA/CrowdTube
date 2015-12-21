class VideosController < ApplicationController

	def home
		@videos = Video.all
		@videos = @videos.reverse # list newest videos first
		@numToList = 4
	end

	def index
		# for list.html
		@videos = Video.all
		@videos = @videos.reverse # list newest videos first
		@numToList = -1 # -1 means "show all"
	end
	
	def show
		@video = Video.find(params[:id])
		@video.views = @video.views + 1
		@video.save
		# for list.html
		@videos = Video.all
		@videos = @videos.reverse # list newest videos first
		@videos.each do |video|
			if video.id == @video.id
				@videos.delete(video) # don't list currently shown video
			end
		end
		@numToList = 4
	end

	def new
		@video = Video.new
	end
	
	def create
		@video = Video.new(video_params)
		@video.views = 0
		@video.youtubeId = Video.getYoutubeId(@video.url)
		if @video.save
			redirect_to @video
		else
			render 'new'
		end
	end	
	
	def edit
		@video = Video.find(params[:id])
	end
	
	def update
		@video = Video.find(params[:id])
		@params = Hash.new
		@params[:title] = video_params[:title]
		@params[:url] = video_params[:url]
		@params[:youtubeId] = Video.getYoutubeId(video_params[:url])
		if @video.update(@params)
			redirect_to @video
		else
			render 'edit'
		end
	end
	
	def destroy
		@video = Video.find(params[:id])
		if @video
			@video.destroy
			redirect_to videos_path
		else
		end
	end
	
	private
		def video_params
			params.require(:video).permit(:title, :url, :views, :youtubeId)
		end
end
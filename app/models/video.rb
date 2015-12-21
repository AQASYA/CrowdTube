class Video < ActiveRecord::Base

	validates :title, presence: true,
					length: { minimum: 1, maximum: 200 }
	validates :url, presence: true
  
	def self.getYoutubeId(url)
		@beginning = url.index('watch?v=')
		$videoID = ''
		if @beginning != nil
			@end = url.index('&')
			if @end == nil
				@end = url.index('#')
			end
			if @end == nil
				@end = url.size - 1
			end
			@videoID = url[@beginning + 8, @end - (@beginning + 8) + 1]
		else
			@videoID = nil
		end
		return @videoID
	end
  
end

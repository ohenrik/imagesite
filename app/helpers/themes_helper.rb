module ThemesHelper


	def theme_preview_image(theme)
		File.join(File.dirname(theme.zip_url), "theme_files", "preview.png").to_s
	end



end

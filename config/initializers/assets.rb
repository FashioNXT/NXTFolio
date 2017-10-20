# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( bootstrap.css )
Rails.application.config.assets.precompile += %w( font-awesome.css )
<<<<<<< HEAD
Rails.application.config.assets.precompile += %w( grayscale.css )
Rails.application.config.assets.precompile += %w( grid.css )
=======
Rails.application.config.assets.precompile += %w( grayscale.css.erb )
>>>>>>> 2ffd14f79ce54d91724876d0e5a244892cc6ce46
Rails.application.config.assets.precompile += %w( grayscale.min.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.css )
Rails.application.config.assets.precompile += %w( jquery.min.js )

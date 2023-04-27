# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join("node_modules/bootstrap-icons/font")

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( bootstrap.css )
Rails.application.config.assets.precompile += %w( font-awesome.css )
Rails.application.config.assets.precompile += %w( grayscale.css )
Rails.application.config.assets.precompile += %w( grid.css )
Rails.application.config.assets.precompile += %w( grayscale.min.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.css )
Rails.application.config.assets.precompile += %w( font-awesome.min.css )
Rails.application.config.assets.precompile += %w( notifications.css )
Rails.application.config.assets.precompile += %w( magnific-popup.css )
Rails.application.config.assets.precompile += %w( profile.css )
Rails.application.config.assets.precompile += %w( grayscale.css.erb )
Rails.application.config.assets.precompile += %w( navbar.css.erb )
Rails.application.config.assets.precompile += %w( grayscale.js )
Rails.application.config.assets.precompile += %w( location.js )
Rails.application.config.assets.precompile += %w( starrating.js )
Rails.application.config.assets.precompile += %w( jquery.raty.js )
Rails.application.config.assets.precompile += %w( initializer.js )
Rails.application.config.assets.precompile += %w( homepage_logic.js )
Rails.application.config.assets.precompile += %w( pagination.js.coffee )
Rails.application.config.assets.precompile += %w( professionPicker.js )
Rails.application.config.assets.precompile += %w( bootstrap.js )
Rails.application.config.assets.precompile += %w( jquery.min.js )
Rails.application.config.assets.precompile += %w( Chart.js )
Rails.application.config.assets.precompile += %w( smoothscroll.js )
Rails.application.config.assets.precompile += %w( popper.min.js )
Rails.application.config.assets.precompile += %w( jquery.easing.min.js )
Rails.application.config.assets.precompile += %w( scrollreveal.min.js)
Rails.application.config.assets.precompile += %w( jquery.magnific-popup.min.js )
Rails.application.config.assets.precompile += %w( creative.min.js )
Rails.application.config.assets.precompile += %w( stylesheet.css )
Rails.application.config.assets.precompile += %w( icon.css )
Rails.application.config.assets.precompile += %w( loader.css )
Rails.application.config.assets.precompile += %w( search_engine.css )
Rails.application.config.assets.precompile += %w( search_button.css )
Rails.application.config.assets.precompile += %w( dropdown.css )
Rails.application.config.assets.precompile += %w( adv_search.css )
Rails.application.config.assets.precompile += %w( idangerous.swiper.css )
Rails.application.config.assets.precompile += %w( jquery-ui.css )
Rails.application.config.assets.precompile += %w( jquery-ui.js )
Rails.application.config.assets.precompile += %w( jquery.viewportchecker.min.js )
Rails.application.config.assets.precompile += %w( jquery.mixitup.js )
Rails.application.config.assets.precompile += %w( idangerous.swiper.min.js )
Rails.application.config.assets.precompile += %w( filters.js )
Rails.application.config.assets.precompile += %w( global.js )
Rails.application.config.assets.precompile += %w( jquery-2.1.4.min.js )



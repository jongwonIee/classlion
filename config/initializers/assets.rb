# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Javascript
Rails.application.config.assets.precompile += %w(nav/nav_jquery.menu-aim.js nav/nav_modernizr.js nav/nav_main.js jquery.barrating.js jquery.autocomplete.js)
Rails.application.config.assets.precompile += %w(tinymce/tinymce.min.js tinymce/jquery.tinymce.min.js)

# Stylesheet
Rails.application.config.assets.precompile += %w(theme/bars-movie.css.scss theme/bootstrap-stars.css.scss theme/css-stars.css.scss theme/fontawesome-stars.css.scss theme/fontawesome-stars-o.css.scss)
Rails.application.config.assets.precompile += %w(nav_reset.css.scss nav_style.css.scss style.css.scss)
Rails.application.config.assets.precompile += %w( mySessions.js )
# cd-arrow.svg cd-logo.svg cd-nav-icons.svg cd-search.svg lion_1.svg lion_icon.svg mail.svg mail_icon.svg nav_logo.svg sav_logo_mini.svg
# nav_off.svg nav_on.svg nav_point.svg nav_user.svg reply.svg siren.svg
# )

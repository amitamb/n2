require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module N2
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.active_record.schema_format = :sql

    # These should be included in the application.sass or application.js file, instead
    # of each page requesting them.  Then the below would go away.
    css = %w( grid
              text
              anytimec
              tablesorter
              fb_grid
              admin
              admin_grid
              superfish
              cards
              base
              scaffold
              m/jqt/theme
              ui-lightness/jquery-ui-1.7.2.custom
              m/jqtouch
              jquery.wysiwyg
              tags_input ).map { |f| "#{f}.css" }
    config.assets.precompile += css

    config.assets.precompile << '*.js'

    Dir[Rails.root.join('config/routes/*.rb')].each do |route_file|
      config.paths["config/routes"] << route_file
    end
  end
end

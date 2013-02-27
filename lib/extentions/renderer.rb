module Extentions
  class Renderer < AbstractController::Base
    include AbstractController::Rendering
    include AbstractController::Helpers
    include AbstractController::Translation
    include AbstractController::AssetPaths
    include ActionController::UrlFor
    include Rails.application.routes.url_helpers

    def initialize(extention)
      lookup_context.view_paths = Rails.root + "app/extentions/#{extention.to_token}/views"
    end
  end
end

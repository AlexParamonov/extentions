module Extentions
  module ExtentionsHelper
    def extentions_for(model, context=self)
      Extentions.extentions_for(model, context)
    end

    def presenter_for(model, context = self)
      extentions_for(model, context).build_presenter
    end
  end
end


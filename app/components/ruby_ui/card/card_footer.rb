# frozen_string_literal: true

module RubyUI
  class CardFooter < Base
    def view_template(&block)
      div(**merged_attrs, &block)
    end

    private

    def default_attrs
      {
        class: "flex items-center p-6 pt-0"
      }
    end
  end
end

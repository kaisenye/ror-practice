# frozen_string_literal: true

module RubyUI
  class CardContent < Base
    def view_template(&block)
      div(**merged_attrs, &block)
    end

    private

    def default_attrs
      {
        class: "p-6"
      }
    end
  end
end

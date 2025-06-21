# frozen_string_literal: true

module RubyUI
  class CardTitle < Base
    def view_template(&block)
      h3(**merged_attrs, &block)
    end

    private

    def default_attrs
      {
        class: "font-semibold leading-none tracking-tight"
      }
    end
  end
end

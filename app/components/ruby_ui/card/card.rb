# frozen_string_literal: true

module RubyUI
  class Card < Base
    def view_template(&block)
      div(**merged_attrs, &block)
    end

    private

    def default_attrs
      {
        class: "rounded-xl border bg-white shadow-sm"
      }
    end
  end
end

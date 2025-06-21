# frozen_string_literal: true

module RubyUI
  class CardDescription < Base
    def view_template(&block)
      p(**merged_attrs, &block)
    end

    private

    def default_attrs
      {
        class: "text-sm text-muted-foreground"
      }
    end
  end
end

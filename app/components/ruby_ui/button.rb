# frozen_string_literal: true

module RubyUI
  class Button < Base
    def initialize(variant: :primary, size: :default, **attrs)
      @variant = variant
      @size = size
      super(**attrs)
    end

    def view_template(&block)
      button(**merged_attrs, &block)
    end

    private

    attr_reader :variant, :size

    def default_attrs
      {
        class: class_names
      }
    end

    def class_names
      base_classes = "inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50"

      variant_classes = case variant
      when :primary
        "bg-blue-600 text-white hover:bg-blue-700"
      when :outline
        "border border-gray-300 bg-white text-gray-700 hover:bg-gray-50"
      when :ghost
        "text-gray-700 hover:bg-gray-100"
      else
        "bg-blue-600 text-white hover:bg-blue-700"
      end

      size_classes = case size
      when :sm
        "h-9 px-3"
      when :lg
        "h-11 px-8"
      else
        "h-10 px-4 py-2"
      end

      [ base_classes, variant_classes, size_classes ].join(" ")
    end
  end
end

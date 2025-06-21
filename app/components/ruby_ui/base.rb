# frozen_string_literal: true

module RubyUI
  class Base < Phlex::HTML
    def initialize(**attrs)
      @attrs = attrs
    end

    private

    attr_reader :attrs

    def merged_attrs
      default_attrs.merge(attrs) do |key, default, given|
        if key == :class
          [ default, given ].compact.join(" ")
        else
          given
        end
      end
    end

    def default_attrs
      {}
    end
  end
end

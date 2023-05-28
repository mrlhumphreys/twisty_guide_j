module Jekyll
  class Text < Liquid::Tag
    FONT_FAMILY = "'Century Gothic', Arial, sans-serif"
    FONT_SIZE = 20

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      x, y, t = @input.split('|')
      "<text x=\"#{x}\" y=\"#{y}\" font-family=\"#{FONT_FAMILY}\" font-size=\"#{FONT_SIZE}\">#{t}</text>"
    end
  end
end

Liquid::Template.register_tag('text', Jekyll::Text)

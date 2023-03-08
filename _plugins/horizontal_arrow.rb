require 'grid_generator'
module Jekyll
  class HorizontalArrow < Liquid::Tag
    COLOURS = {
      medium: "#707070",
      white: "#ffffff"
    }

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      x, y, length, direction, colour = @input.split('|')
      horizontal_arrow = GridGenerator.horizontal_arrow(x: x.to_i, y: y.to_i, length: length.to_i, direction: direction.strip.to_sym, colour: COLOURS[(colour ? colour.strip.to_sym : :white)])

      render_arrow(horizontal_arrow)
    end

    def render_arrow(arrow)
      "<polygon points=\"#{arrow.points_string}\" style=\"stroke:black;fill:#{arrow.colour};\" />"
    end
  end
end

Liquid::Template.register_tag('horizontal_arrow', Jekyll::HorizontalArrow)

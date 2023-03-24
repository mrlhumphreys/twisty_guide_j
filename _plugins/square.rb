require 'grid_generator' 

module Jekyll
  class Square < Liquid::Tag
    COLOURS = {
      fill: "#d0d0d0",
      stroke: "#404040"
    }

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      args = parse_input(@input)
      square = GridGenerator.square(**args)
      render_square(square)
    end

    private

    def parse_input(input)
      x, y, side, units, face = input.split('|')
      { 
        x: x.to_i, 
        y: y.to_i, 
        side: side.strip.to_sym, 
        units: units.to_i, 
        face: face.strip
      }
    end

    def render_square(square)
      "<polygon points=\"#{square.points_string}}\" style=\"fill:#{square.colour};stroke:#{COLOURS[:stroke]};stroke-width:1;opacity:#{square.opacity}\" />"
    end
  end
end

Liquid::Template.register_tag('square', Jekyll::Square)

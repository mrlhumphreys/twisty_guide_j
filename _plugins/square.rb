require 'grid_generator' 

module Jekyll
  class Square < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      args = parse_input(@input)
      square = GridGenerator.square(**args)
      square.to_svg
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
  end
end

Liquid::Template.register_tag('square', Jekyll::Square)

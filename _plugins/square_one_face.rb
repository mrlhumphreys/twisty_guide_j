require 'grid_generator' 

module Jekyll
  class SquareOneFace < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      args = parse_input(@input)
      square_one_face = GridGenerator.square_one_face(**args)
      square_one_face.to_svg
    end

    private

    def parse_input(input)
      x, y, units, elements, axis_direction = input.split('|')
      {
        x: x.to_i, 
        y: y.to_i, 
        units: units.to_i, 
        elements: elements.strip, 
        axis_direction: (axis_direction ? axis_direction.strip.to_sym : nil )
      }
    end
  end
end

Liquid::Template.register_tag('square_one_face', Jekyll::SquareOneFace)

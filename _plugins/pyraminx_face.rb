require 'grid_generator' 

module Jekyll
  class PyraminxFace < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      args = parse_input(@input)
      pyraminx_face = GridGenerator.pyraminx_face(**args)
      pyraminx_face.to_svg
    end

    private

    def parse_input(input)
      x, y, units, elements, rotation_angle, vertical_scale = input.split('|')
      {
        x: x.to_i, 
        y: y.to_i, 
        units: units.to_i, 
        elements: elements.strip, 
        rotation_angle: (rotation_angle ? Math::PI * 2 * rotation_angle.to_f : 0),
        vertical_scale: (vertical_scale ? vertical_scale.to_f : 1)
      }
    end
  end
end

Liquid::Template.register_tag('pyraminx_face', Jekyll::PyraminxFace)

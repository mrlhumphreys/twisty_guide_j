require 'grid_generator' 

module Jekyll
  class MegaminxFaceProjection < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      args = parse_input(@input)
      megaminx_projection = GridGenerator.megaminx_face_projection(**args)
      megaminx_projection.to_svg
    end

    private

    def parse_input(input)
      x, y, units, front_face_elements, top_right_face_elements, right_face_elements, down_face_elements, left_face_elements, top_left_face_elements, rotation_offset = input.split('|')
      { 
        x: x.to_i, 
        y: y.to_i, 
        units: units.to_i, 
        front_face_elements: front_face_elements.to_s.strip, 
        top_right_face_elements: top_right_face_elements.to_s.strip,
        right_face_elements: right_face_elements.to_s.strip,
        down_face_elements: down_face_elements.to_s.strip,
        left_face_elements: left_face_elements.to_s.strip,
        top_left_face_elements: top_left_face_elements.to_s.strip,
        rotation_offset: rotation_offset && 2 * Math::PI * rotation_offset.to_f || 0
      } 
    end
  end
end

Liquid::Template.register_tag('megaminx_face_projection', Jekyll::MegaminxFaceProjection)

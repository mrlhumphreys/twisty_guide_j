require 'grid_generator' 

module Jekyll
  class MegaminxFace < Liquid::Tag
    COLOURS = {
      fill: "#d0d0d0",
      stroke: "#404040"
    }

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      x, y, units, elements, rotation_offset, label = @input.split('|')
      megaminx_face = GridGenerator.megaminx_face(x: x.to_i, y: y.to_i, units: units.to_i, elements: elements, rotation_offset: Math::PI*(rotation_offset.to_f), label: label&.strip)

      render_face(megaminx_face)
    end

    def render_face(face)
      output = "<polygon points=\"#{ face.outline_string }\" style=\"fill:#{ COLOURS[:fill] };stroke:#{ COLOURS[:stroke] };stroke-width:1\" />"
      output += "<polygon points=\"#{ face.inline_string }\" style=\"fill:none;stroke:#{ COLOURS[:stroke] };stroke-width:1\" />"

      face.element_shapes.map do |shape|
        output += "<polygon points=\"#{ shape.points_string }\" style=\"fill:#{ shape.colour };stroke:#{ COLOURS[:stroke] };stroke-width:1;opacity:#{ shape.opacity }\" />"
      end

      if face.label
        output += "<text x=\"#{ face.label_position[:x] }\" y=\"#{ face.label_position[:y] }\" style=\"color:#{ COLOURS[:stroke] };font-size:#{ face.label_size }px;font-family: Helvetica, Arial, sans-serif\">#{ face.label }</text>"
      end

      output
    end
  end
end

Liquid::Template.register_tag('megaminx_face', Jekyll::MegaminxFace)

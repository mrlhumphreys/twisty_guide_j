require 'grid_generator' 

module Jekyll
  class PyraminxFace < Liquid::Tag
    COLOURS = {
      fill: "#d0d0d0",
      stroke: "#404040"
    }

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      x, y, units, elements, rotation_angle, vertical_scale = @input.split('|')
      pyraminx_face = GridGenerator.pyraminx_face(x: x.to_i, y: y.to_i, units: units.to_i, elements: elements.strip, rotation_angle: (rotation_angle ? Math::PI * 2 * rotation_angle.to_f : 0), vertical_scale: (vertical_scale ? vertical_scale.to_f : 1))

      render_face(pyraminx_face)
    end

    def render_face(face)
      output = "<polygon points=\"#{ face.points_string }\" style=\"fill:#{ COLOURS[:fill] };stroke:#{ COLOURS[:stroke] };stroke-width:1\" />"

      for line in face.vertical_lines do
        output += "<line x1=\"#{line.x1}\" y1=\"#{line.y1}\" x2=\"#{line.x2}\" y2=\"#{line.y2}\" style=\"stroke:#{COLOURS[:stroke]};stroke-width:1\" />"
      end

      for line in face.diagonal_up_lines do
        output += "<line x1=\"#{line.x1}\" y1=\"#{line.y1}\" x2=\"#{line.x2}\" y2=\"#{line.y2}\" style=\"stroke:#{COLOURS[:stroke]};stroke-width:1\" />"
      end

      for line in face.diagonal_down_lines do
        output += "<line x1=\"#{line.x1}\" y1=\"#{line.y1}\" x2=\"#{line.x2}\" y2=\"#{line.y2}\" style=\"stroke:#{COLOURS[:stroke]};stroke-width:1\" />"
      end

      face.element_shapes.map do |shape|
        output += "<polygon points=\"#{ shape.points_string }\" style=\"fill:#{ shape.colour };stroke:#{ COLOURS[:stroke] };stroke-width:1;opacity:#{ shape.opacity }\" />"
      end

      output
    end
  end
end

Liquid::Template.register_tag('pyraminx_face', Jekyll::PyraminxFace)

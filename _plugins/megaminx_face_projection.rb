require 'grid_generator' 

module Jekyll
  class MegaminxFaceProjection < Liquid::Tag
    COLOURS = {
      fill: "#d0d0d0",
      stroke: "#404040"
    }

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      x, y, units, front_face_elements, top_right_face_elements, right_face_elements, down_face_elements, left_face_elements, top_left_face_elements, rotation_offset = @input.split('|')
      megaminx_projection = GridGenerator.megaminx_face_projection(
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
      )

      render_projection(megaminx_projection)
    end

    def render_projection(projection)
      output = "<polygon points=\"#{ projection.decagon_points_string }\" style=\"fill:#{ COLOURS[:fill] };stroke:#{ COLOURS[:stroke] };stroke-width:1\" />"
      output += "<polygon points=\"#{ projection.pentagon_points_string }\" style=\"fill:none;stroke:#{ COLOURS[:stroke] };stroke-width:1\" />"

      for line in projection.connecting_lines do
        output += "<line x1=\"#{line.x1}\" y1=\"#{line.y1}\" x2=\"#{line.x2}\" y2=\"#{line.y2}\" style=\"stroke:#{COLOURS[:stroke]};stroke-width:1\" />"
      end

      for line in projection.front_face_lines do
        output += "<line x1=\"#{line.x1}\" y1=\"#{line.y1}\" x2=\"#{line.x2}\" y2=\"#{line.y2}\" style=\"stroke:#{COLOURS[:stroke]};stroke-width:1\" />"
      end

      for face in projection.outside_face_lines do
        for line in face do
          output += "<line x1=\"#{line.x1}\" y1=\"#{line.y1}\" x2=\"#{line.x2}\" y2=\"#{line.y2}\" style=\"stroke:#{COLOURS[:stroke]};stroke-width:1\" />"
        end
      end

      for shape in projection.front_face_element_shapes do
        output += "<polygon points=\"#{shape.points_string}\" style=\"fill:#{shape.colour};stroke:#{COLOURS[:stroke]};stroke-width:1;opacity:#{shape.opacity}\" />"
      end

      for face in projection.outside_face_element_shapes do
        for shape in face do
          output += "<polygon points=\"#{shape.points_string}\" style=\"fill:#{shape.colour};stroke:#{COLOURS[:stroke]};stroke-width:1;opacity:#{shape.opacity}\" />"
        end
      end

      output
    end
  end
end

Liquid::Template.register_tag('megaminx_face_projection', Jekyll::MegaminxFaceProjection)

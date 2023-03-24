require 'grid_generator' 

module Jekyll
  class SquareOneFace < Liquid::Tag
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
      square_one_face = GridGenerator.square_one_face(**args)

      render_face(square_one_face)
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

    def render_face(face)
      output = ""
      face.element_shapes.each do |element|
        if element.opacity == 0.4 
          output += "<polygon points=\"#{ element.points_string }\" style=\"fill:#{ COLOURS[:fill] };stroke:#{ COLOURS[:stroke] };stroke-width:1;opacity:1;]\" />"
        end
        output += "<polygon points=\"#{ element.points_string }\" style=\"fill:#{ element.colour };stroke:#{ COLOURS[:stroke] };stroke-width:1;opacity:#{ element.opacity };\" />"
       end

      output += "<line x1=\"#{ face.axis.x1 }\" y1=\"#{ face.axis.y1 }\" x2=\"#{ face.axis.x2 }\" y2=\"#{ face.axis.y2 }\" style=\"stroke:#{ COLOURS[:stroke] };stroke-width:5\" />"

      output
    end
  end
end

Liquid::Template.register_tag('square_one_face', Jekyll::SquareOneFace)

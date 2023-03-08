require 'grid_generator' 

module Jekyll
  class IsoView < Liquid::Tag
    COLOURS = {
      fill: "#d0d0d0",
      stroke: "#404040"
    }

    def initialize(tag_name, input, tokens) 
      super
      @input = input
    end

    def render(context)
      x, y, units, top_squares, front_squares, right_squares = @input.split('|')
      iso_view = GridGenerator.iso_view(x: x.to_i, y: y.to_i, units: units.to_i, top_squares: top_squares.strip, front_squares: front_squares.strip, right_squares: right_squares.strip)
       
      output = render_grid(iso_view.top)
      output += render_grid(iso_view.front)
      output += render_grid(iso_view.right)

      output
    end

    private

    def render_grid(grid)
      output = "<polygon points=\"#{grid.points_string}\" style=\"fill:#{COLOURS[:fill]};stroke:#{COLOURS[:stroke]};stroke-width:1\" />"

      for row in grid.rows do
        output += "<line x1=\"#{row.x1}\" y1=\"#{row.y1}\" x2=\"#{row.x2}\" y2=\"#{row.y2}\" style=\"stroke:#{COLOURS[:stroke]};stroke-width:1\" />"
      end

      for col in grid.columns do
        output += "<line x1=\"#{col.x1}\" y1=\"#{col.y1}\" x2=\"#{col.x2}\" y2=\"#{col.y2}\" style=\"stroke:#{COLOURS[:stroke]};stroke-width:1\" />"
      end

      for shape in grid.element_shapes do
        output += "<polygon points=\"#{shape.points_string}\" style=\"fill:#{shape.colour};stroke:#{COLOURS[:stroke]};stroke-width:1;opacity:#{shape.opacity}\" />"
      end

      output
    end
  end
end

Liquid::Template.register_tag('iso_view', Jekyll::IsoView)


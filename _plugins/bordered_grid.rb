require 'grid_generator' 

module Jekyll
  class BorderedGrid < Liquid::Tag
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
      bordered_grid = GridGenerator.bordered_grid(**args)
      render_grid(bordered_grid)
    end

    private

    def parse_input(input)
      x, y, units, squares = input.split('|')
      {
        x: x.to_i,
        y: y.to_i,
        units: units.to_i,
        squares: squares
      }
    end

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

Liquid::Template.register_tag('bordered_grid', Jekyll::BorderedGrid)

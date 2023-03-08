module Jekyll
  class LeftSkewbGrid < Liquid::Tag
    COLOURS = {
      fill: "#d0d0d0",
      stroke: "#404040"
    }

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      x, y, units, elements = @input.split('|')
      left_skewb_grid = GridGenerator.left_skewb_grid(x: x.to_i, y: y.to_i, units: units.to_i, elements: elements)
      render_grid(left_skewb_grid)
    end

    def render_grid(grid)
      output = "<polygon points=\"#{grid.border_points_string}\" style=\"fill:#{COLOURS[:fill]};stroke:#{COLOURS[:stroke]};stroke-width:1\" />"

      grid.rows.each do |row|
        output += "<line x1=\"#{row.x1}\" y1=\"#{row.y1}\" x2=\"#{row.x2}\" y2=\"#{row.y2}\" style=\"stroke:#{COLOURS[:stroke]};stroke-width:1\" />"
      end

      grid.columns.each do |col|
        output += "<line x1=\"#{col.x1}\" y1=\"#{col.y1}\" x2=\"#{col.x2}\" y2=\"#{col.y2}\" style=\"stroke:#{COLOURS[:stroke]};stroke-width:1\" />"
      end

      grid.element_shapes.each do |element|
        if element
          output += "<polygon points=\"#{element.points_string}\" style=\"fill:#{element.colour};stroke:#{COLOURS[:stroke]};stroke-width:1;opacity:#{element.opacity}\" />"
        end
      end

      output
    end
  end
end

Liquid::Template.register_tag('left_skewb_grid', Jekyll::LeftSkewbGrid)


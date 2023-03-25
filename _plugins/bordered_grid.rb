require 'grid_generator' 

module Jekyll
  class BorderedGrid < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      args = parse_input(@input)
      bordered_grid = GridGenerator.bordered_grid(**args)
      bordered_grid.to_svg
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
  end
end

Liquid::Template.register_tag('bordered_grid', Jekyll::BorderedGrid)

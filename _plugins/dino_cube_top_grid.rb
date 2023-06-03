module Jekyll
  class DinoCubeTopGrid < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      args = parse_input(@input)
      top_dino_cube_grid = GridGenerator.dino_cube_top_grid(**args)
      top_dino_cube_grid.to_svg
    end

    private

    def parse_input(input)
      x, y, units, elements = input.split('|')
      {
        x: x.to_i,
        y: y.to_i,
        units: units.to_i,
        elements: elements
      }
    end
  end
end

Liquid::Template.register_tag('dino_cube_top_grid', Jekyll::DinoCubeTopGrid)

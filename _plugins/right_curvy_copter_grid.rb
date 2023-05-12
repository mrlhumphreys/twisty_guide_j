module Jekyll
  class RightCurvyCopterGrid < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      args = parse_input(@input)
      right_curvy_copter_grid = GridGenerator.curvy_copter_right_grid(**args)
      right_curvy_copter_grid.to_svg
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

Liquid::Template.register_tag('right_curvy_copter_grid', Jekyll::RightCurvyCopterGrid)

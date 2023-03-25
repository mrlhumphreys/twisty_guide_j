module Jekyll
  class LeftSkewbGrid < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      args = parse_input(@input)
      left_skewb_grid = GridGenerator.left_skewb_grid(**args)
      left_skewb_grid.to_svg
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

Liquid::Template.register_tag('left_skewb_grid', Jekyll::LeftSkewbGrid)


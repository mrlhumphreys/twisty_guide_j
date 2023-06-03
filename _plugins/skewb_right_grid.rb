module Jekyll
  class SkewbRightGrid < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      x, y, units, elements = @input.split('|')
      args = parse_input(@input)
      right_skewb_grid = GridGenerator.skewb_right_grid(**args)
      right_skewb_grid.to_svg
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

Liquid::Template.register_tag('skewb_right_grid', Jekyll::SkewbRightGrid)



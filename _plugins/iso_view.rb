require 'grid_generator' 

module Jekyll
  class IsoView < Liquid::Tag
    def initialize(tag_name, input, tokens) 
      super
      @input = input
    end

    def render(context)
      args = parse_input(@input)
      iso_view = GridGenerator.iso_view(**args)
      iso_view.to_svg
    end

    private

    def parse_input(input)
      x, y, units, top_squares, front_squares, right_squares = @input.split('|')
      {
        x: x.to_i,
        y: y.to_i,
        units: units.to_i,
        top_squares: top_squares.strip,
        front_squares: front_squares.strip,
        right_squares: right_squares.strip
      }
    end
  end
end

Liquid::Template.register_tag('iso_view', Jekyll::IsoView)


module Jekyll
  class Arrow < Liquid::Tag
    COLOURS = {
      black: '#404040',
      grey: '#808080',
      white: '#ffffff',
    }

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      x1, y1, x2, y2, direction, colour_code, stroke_width = @input.split('|')
      colour = COLOURS[colour_code.strip.to_sym]      

      output = ""

      if direction.strip.to_sym == :both
        output += "<polyline points=\"#{x1},#{y1} #{x2},#{y2}\" fill=\"none\" stroke=\"#{colour}\" stroke-width=\"#{stroke_width.nil? ? 4 : stroke_width.strip}\" marker-start=\"url(#arrow_#{colour_code.strip})\" marker-end=\"url(#arrow_#{colour_code.strip})\" />" 
      else
        output += "<polyline points=\"#{x1},#{y1} #{x2},#{y2}\" fill=\"none\" stroke=\"#{colour}\" stroke-width=\"#{stroke_width.nil? ?  4 : stroke_width.strip}\" marker-end=\"url(#arrow_#{colour_code.strip})\" />" 
      end

      output
    end
  end
end

Liquid::Template.register_tag('arrow', Jekyll::Arrow)

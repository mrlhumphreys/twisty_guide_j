module Jekyll
  class Arrow < Liquid::Tag
    COLOURS = {
      black: '#404040',
      grey: '#808080',
      white: '#ffffff',
    }
    DEFAULT_STROKE_WIDTH = 4

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      x1, y1, x2, y2, direction, colour_code, stroke_width = @input.split('|')
      colour = COLOURS[colour_code.strip.to_sym]      

      # border arrow def
      output = "<marker id=\"arrow_black\" viewBox=\"0 0 2 4\" refX=\"1\" refY=\"2\" markerWidth=\"2\" markerHeight=\"4\" orient=\"auto-start-reverse\"><path d=\"M 0 0 L 2 2 L 0 4 z\" fill=\"#{COLOURS[:black]}\" /></marker>" 
      if direction.strip.to_sym == :both
        output += "<polyline points=\"#{x1},#{y1} #{x2},#{y2}\" fill=\"none\" stroke=\"#{COLOURS[:black]}\" stroke-width=\"#{sanitize_stroke_width(stroke_width) + 2 }\" marker-start=\"url(#arrow_black)\" marker-end=\"url(#arrow_black)\" stroke-linecap=\"square\" />" 
        output += "<polyline points=\"#{x1},#{y1} #{x2},#{y2}\" fill=\"none\" stroke=\"#{colour}\" stroke-width=\"#{sanitize_stroke_width(stroke_width)}\" marker-start=\"url(#arrow_#{colour_code.strip})\" marker-end=\"url(#arrow_#{colour_code.strip})\" stroke-linecap=\"square\" />" 
      else
        output += "<polyline points=\"#{x1},#{y1} #{x2},#{y2}\" fill=\"none\" stroke=\"#{COLOURS[:black]}\" stroke-width=\"#{sanitize_stroke_width(stroke_width) + 2 }\" marker-end=\"url(#arrow_black)\" stroke-linecap=\"square\" />" 
        output += "<polyline points=\"#{x1},#{y1} #{x2},#{y2}\" fill=\"none\" stroke=\"#{colour}\" stroke-width=\"#{sanitize_stroke_width(stroke_width)}\" marker-end=\"url(#arrow_#{colour_code.strip})\" stroke-linecap=\"square\" />" 
      end

      output
    end

    def sanitize_stroke_width(width)
      width.nil? ? DEFAULT_STROKE_WIDTH : width.strip.to_i
    end
  end
end

Liquid::Template.register_tag('arrow', Jekyll::Arrow)

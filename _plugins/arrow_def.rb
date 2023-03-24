module Jekyll
  class ArrowDef < Liquid::Tag
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
      args = parse_input(@input)
      render_arrow_def(args)
    end

    private

    def parse_input(input)
      { colour_code: input.strip.to_sym }
    end

    def render_arrow_def(args)
      "<marker id=\"arrow_#{args[:colour_code]}\" viewBox=\"0 0 2 4\" refX=\"1\" refY=\"2\" markerWidth=\"2\" markerHeight=\"4\" orient=\"auto-start-reverse\"><path d=\"M 0 0 L 2 2 L 0 4 z\" fill=\"#{COLOURS[args[:colour_code]]}\" /></marker>" 
    end
  end
end

Liquid::Template.register_tag('arrow_def', Jekyll::ArrowDef)


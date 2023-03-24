module Jekyll
  class Clock < Liquid::Tag
    COLOURS = {
      white: "#d0d0d0",
      black: "#202020",
      yellow: "#ffff00",
      blue: "#000080",
      light_blue: "#8080ff"
    }

    # 20
    HAND_OFFSETS = [
      [0, -20],      
      [9.999, -17.320],
      [17.320, -9.999],  
      [20, 0],  
      [17.320, 9.999],
      [9.999, 17.320],
      [0, 20],
      [-9.999, 17.320],
      [-17.320, 9.999],
      [-20, 0],
      [-17.320, -9.999],
      [-9.999, -17.320],
      [0, -20]
    ]

    # faces
    FACE_RADIUS = 28 
    FACE_OFFSET = 30
    FACE_STROKE_SIZE = 6 
    HAND_STROKE_SIZE = 4 

    # whole puzzle
    BORDER = 15 
    RADIUS = BORDER + 3*FACE_OFFSET

    # buttons
    BUTTON_OFFSET = FACE_OFFSET*2
    BUTTON_SIZE = 5

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end
   
    def render(context)
      args = parse_input(@input)
      render_clock(args)
    end

    private

    def parse_input(input)
      x_string, y_string, face_string, button_string, reverse_string = @input.split('|')

      if reverse_string&.strip == '1' 
        primary = COLOURS[:light_blue] 
        secondary = COLOURS[:blue] 
      else
        primary = COLOURS[:blue] 
        secondary = COLOURS[:light_blue] 
      end

      {
        x: x_string.to_i,
        y: y_string.to_i,
        faces: face_string.strip.split('\n').map { |row| row.split(',') },
        buttons: button_string.strip.split('\n').map { |row| row.split(',') },
        primary: primary,
        secondary: secondary,
        hand_colour: COLOURS[:yellow]
      }
    end

    def render_clock(args)
      output = render_back(args[:x], args[:y], args[:primary])

      args[:faces].each_with_index do |row, row_index|
        row.each_with_index do |column, column_index|
          output += render_face(args[:x], args[:y], row_index, column_index, column, args[:primary], args[:secondary], args[:hand_colour])
        end
      end

      args[:buttons].each_with_index do |row, row_index|
        row.each_with_index do |column, column_index|
          output += render_button(args[:x], args[:y], row_index, column_index, args[:column], args[:secondary])
        end
      end

      output
    end

    def render_back(x, y, primary)
      center_x = x + RADIUS  
      center_y = y + RADIUS
      "<circle cx=\"#{center_x}\" cy=\"#{center_y}\" r=\"#{RADIUS}\" fill=\"#{primary}\" />"
    end

    def render_face(x, y, row_index, column_index, column, primary, secondary, hand_colour)
      output = ""

      face_x = x + BORDER + FACE_OFFSET + column_index*FACE_OFFSET*2
      face_y = y + BORDER + FACE_OFFSET + row_index*FACE_OFFSET*2 
      if column.match?(/\d{1,2}\*?/)
        _, number_string, highlight_string = column.match(/(\d{1,2})(\*?)/).to_a
        number = number_string.to_i
        highlight = highlight_string == '*'
        hand_end_x = face_x + HAND_OFFSETS[number][0] 
        hand_end_y = face_y + HAND_OFFSETS[number][1] 
        face_BORDER_colour = highlight ? COLOURS[:yellow] : primary
        output += "<circle cx=\"#{face_x}\" cy=\"#{face_y}\" r=\"#{FACE_RADIUS}\" fill=\"#{secondary}\" stroke=\"#{face_BORDER_colour}\" stroke-width=\"#{FACE_STROKE_SIZE}\" />"    
        output += "<line x1=\"#{face_x}\" y1=\"#{face_y}\" x2=\"#{hand_end_x}\" y2=\"#{hand_end_y}\" stroke=\"#{hand_colour}\" stroke-width=\"#{HAND_STROKE_SIZE}\" stroke-linecap=\"round\" />"
      else
        output += "<circle cx=\"#{face_x}\" cy=\"#{face_y}\" r=\"#{FACE_RADIUS}\" fill=\"#{secondary}\" stroke=\"#{primary}\" stroke-width=\"#{FACE_STROKE_SIZE}\" />"    
      end

      output += "<circle cx=\"#{face_x}\" cy=\"#{face_y}\" r=\"4\" fill=\"#{secondary}\" stroke=\"#{hand_colour}\" stroke-width=\"2\" />"    
      output += "<circle cx=\"#{face_x}\" cy=\"#{face_y - FACE_RADIUS}\" r=\"2\" fill=\"#{hand_colour}\" />"    

      output
    end

    def render_button(x, y, row_index, column_index, column, secondary)
      button = column.to_i
      button_x = x + BORDER + BUTTON_OFFSET + column_index*BUTTON_OFFSET
      button_y = y + BORDER + BUTTON_OFFSET + row_index*BUTTON_OFFSET 

      if button == 1
        "<circle cx=\"#{button_x}\" cy=\"#{button_y}\" r=\"#{BUTTON_SIZE}\" fill=\"#{secondary}\" stroke=\"#{COLOURS[:yellow]}\" stroke-width=\"2\" />"    
      else
        "<circle cx=\"#{button_x}\" cy=\"#{button_y}\" r=\"#{BUTTON_SIZE}\" fill=\"#{secondary}\" />"    
      end
    end
  end
end

Liquid::Template.register_tag('clock', Jekyll::Clock)

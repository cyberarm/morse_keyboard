module MorseKeyboard
  module States
    class Keyboard < CyberarmEngine::GameState
      def setup
        @trigger_key = Gosu::KbSpace

        @morse_code = MorseCode.new
        @history    = []
        @current_letter = []
        @last_keyed = Gosu.milliseconds

        @history_text = CyberarmEngine::Text.new("", x: 10, y: 10)
        @morse_code_text = CyberarmEngine::Text.new("", y: 10, size: 20)

        projected_letter_height = 256
        @current_letter_text   = CyberarmEngine::Text.new("", size: projected_letter_height, x: window.width/2 - projected_letter_height/2, y: window.height/2 + projected_letter_height/2)
        @projected_letter_text = CyberarmEngine::Text.new("", size: projected_letter_height, x: window.width/2 - projected_letter_height/2, y: window.height/2 - projected_letter_height/2)

        @morse_code_text.text = @morse_code.code.map { |letter, code| ["<c=ff5500>#{letter}</c>", code.map { |encoded| encoded == :dot ? "." : "-" }.join].join(": ") }.join("\n")
        @morse_code_text.x = window.width - (@morse_code_text.width + 10)
      end

      def draw
        super

        fill(0xff111111)
        @history_text.draw
        @current_letter_text.draw
        @projected_letter_text.draw
        @morse_code_text.draw
      end

      def update
        @history_text.text = @history.join

        @current_letter_text.text = @current_letter.map { |code| code == :dot ? "." : "-" }.join
        @current_letter_text.x = window.width / 2 - @current_letter_text.width / 2

        letter = decode_letter
        @projected_letter_text.text = letter ? letter.first : ""
        @projected_letter_text.x = window.width / 2 - @projected_letter_text.width / 2

        if @current_letter.size > 0 && Gosu.milliseconds - @last_keyed >= @morse_code.short

          @history << letter.first if letter
          @current_letter.clear
        end
      end

      def decode_letter
        @morse_code.code.detect do |letter, code|
          @current_letter == code
        end
      end

      def button_down(id)
        return unless id == @trigger_key
        @last_keyed = Gosu.milliseconds
      end

      def button_up(id)
        return unless id == @trigger_key

        if key_time <= @morse_code.dot
          @current_letter << :dot
        elsif key_time > @morse_code.dot && key_time <= @morse_code.dash
          @current_letter << :dash
        elsif key_time > @morse_code.short
          @history << " "
        end
      end

      def key_time
        Gosu.milliseconds - @last_keyed
      end
    end
  end
end
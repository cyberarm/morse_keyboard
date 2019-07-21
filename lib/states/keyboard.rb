module MorseKeyboard
  module States
    class Keyboard < CyberarmEngine::GameState
      def setup
        @trigger_key = Gosu::KbSpace

        @morse_code = MorseCode.new
        @history    = []
        @current_letter = []
        @last_keyed = Gosu.milliseconds
      end

      def draw
        super

        fill(0xff552211)
      end

      def update
        if @current_letter.size > 0 && Gosu.milliseconds - @last_keyed >= @morse_code.short
          decode_letter
        end
      end

      def decode_letter
        pp @current_letter

        letter = @morse_code.code.detect do |letter, code|
          @current_letter == code
        end

        p letter

        @current_letter.clear
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
        else
          puts "Held to long!"
        end
      end

      def key_time
        Gosu.milliseconds - @last_keyed
      end
    end
  end
end
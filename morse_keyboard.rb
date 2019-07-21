begin
  require_relative "../cyberarm_engine/lib/cyberarm_engine"
rescue LoadError
  require "cyberarm_engine"
end

require_relative "lib/window"
require_relative "lib/morse_code"
require_relative "lib/states/keyboard"

MorseKeyboard::Window.new.show
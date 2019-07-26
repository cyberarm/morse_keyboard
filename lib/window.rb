module MorseKeyboard
  class Window < CyberarmEngine::Engine
    def initialize
      super(width: 800, height: 750)
      self.caption = "Morse Keyboard"

      push_state(MorseKeyboard::States::Keyboard)
    end
  end
end
module MorseKeyboard
  class Window < CyberarmEngine::Engine
    def initialize(*args)
      super(*args)

      push_state(MorseKeyboard::States::Keyboard)
    end
  end
end
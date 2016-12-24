module FormHintHelper
  def form_hint_for(word, keyboard_shortcut)
    case keyboard_shortcut
    when "Enter"
      return "Нажмите #{keyboard_shortcut}, чтобы отправить #{word}, Shift+Enter – для переноса строки"
    when "Shift+Enter", "Ctrl+Enter"
      return "Нажмите #{keyboard_shortcut}, чтобы отправить #{word}, Enter – для переноса строки"
    end
  end
end

module FormHintHelper
  def form_hint_for(word)
      "Нажмите Shift+Enter, чтобы отправить #{word}, Enter – для переноса строки"
  end

  def markdown_hint_link
    "Поддерживается #{ link_to 'markdown', markdown_modal_path,  {:remote => true, 'data-toggle' =>
    'modal', 'data-target' => '#modal-window'} }".html_safe
  end
end

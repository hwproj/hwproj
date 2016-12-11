jQuery(document).on 'click', '[data-behavior~=update-has_grade]', (_this) ->
  $.ajax
  has_grade = _this.target.checked
  curDiv = _this.target.parentNode
  for node in curDiv.childNodes
    if (node.id == "grade")
      grade = node
  if (has_grade)
    grade.removeAttribute("style")
    grade.childNodes.item(1).childNodes.item(1).value = 2
  else
    grade.style.display = 'none'
    grade.childNodes.item(1).childNodes.item(1).value = 1

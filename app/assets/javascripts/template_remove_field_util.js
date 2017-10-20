function removeFields() {
    var form_element = document.getElementById("prof_form_group")
    var numberOfChildren = form_element.getElementsByTagName('input').length
    var len = form_element.childNodes.length
    if(len > 5)
    form_element.removeChild(form_element.childNodes[len -1])
}

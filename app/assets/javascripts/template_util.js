function addFields() {
    var new_field = document.createElement("div");
    var form_element = document.getElementById("prof_form_group")
    var numberOfChildren = form_element.getElementsByTagName('input').length + 1
    var field_name = "field_name_"+(numberOfChildren/2)
    var field_type = "field_type_"+(numberOfChildren/2)
    new_field.innerHTML = '<label for="text">Field name:</label><input type="text" class="form-control" id="p_name" name="'+'field_name[]'+'" >';
    new_field.innerHTML += '<label for="text">Field type:</label><input type="text" class="form-control" id="p_name" name="'+'field_type[]'+'" >';
    form_element.appendChild(new_field);
}

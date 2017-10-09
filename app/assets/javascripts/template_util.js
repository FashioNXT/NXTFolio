function addFields() {
    var new_field = document.createElement("div");
    new_field.innerHTML = '<label for="text">Professional name:</label><input type="text" class="form-control" id="p_name">';
    document.getElementById("prof_form_group").appendChild(new_field);
}

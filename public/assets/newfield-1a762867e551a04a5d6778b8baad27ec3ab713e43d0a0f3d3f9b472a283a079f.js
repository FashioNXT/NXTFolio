$(document).ready(function(){
    $("#addNewTag").click(function(){
        $("#skillSet").append($("#new_skills_form").html());
    });
});

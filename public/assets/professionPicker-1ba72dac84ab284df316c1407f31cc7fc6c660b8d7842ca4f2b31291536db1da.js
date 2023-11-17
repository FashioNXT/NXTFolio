$('#general_info_industry').on('change', function(e) {

    const creator_array=["Brand Owner", "Designer", "Other Creator"]
    const service_array=["Model", "Photographer", "Sales", "Marketing", "Retail", "Visual", "Content Creator", "Blogger", "Influencer", "Forecasting", "Finances", "Other Services"]
    const maker_array=["Manufacturing", "Materials", "Other Makers"]
    var values = $(this).val()
    console.log("Four friends")
    $("#general_info_job_name option").hide() //hide all options
    //$('#job_name').selectpicker('deselectAll') //if want to remove all selcted optn
    if (values =='Creators') {
        $('#general_info_job_name').empty();
        $('#general_info_job_name').append('<option>' +'Select One'+ '</option>');
        for (var i = 0; i < 3; i++) {
            //$("#profession option[value="' + creator_array[i] + '"]").show()
            $('#general_info_job_name').append('<option>' +creator_array[i]+ '</option>');
        }
    }else if (values =='Services') {
        $('#general_info_job_name').empty();
        $('#general_info_job_name').append('<option>' +'Select One'+ '</option>');
        for (var i = 0; i < 12; i++) {
            //$("#profession option[value="' + creator_array[i] + '"]").show()
            $('#general_info_job_name').append('<option>' +service_array[i]+ '</option>');
        }
    }else if (values =='Makers') {
        $('#general_info_job_name').empty();
        $('#general_info_job_name').append('<option>' +'Select One'+ '</option>');
        for (var i = 0; i < 3; i++) {
            //$("#profession option[value="' + creator_array[i] + '"]").show()
            $('#general_info_job_name').append('<option>' +maker_array[i]+ '</option>');
        }
    }
    else {
        // dont show anything
        $("#general_info_job_name option").hide()
        //$("#general_info_job_name option").show() //show all options
    }
    //$('#job_name').selectpicker('refresh'); //refresh selctpicker
});

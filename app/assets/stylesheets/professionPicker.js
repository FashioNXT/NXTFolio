$('#general_info_industry').on('change', function(e) {
    const options = {
        'Creators': ["Brand Owner", "Designer", "Other Creator"],
        'Services': ["Model", "Photographer", "Sales", "Marketing", "Retail", "Visual", "Content Creator", "Blogger", "Influencer", "Forecasting", "Finances", "Other Services"],
        'Makers': ["Manufacturing", "Materials", "Other Makers"]
    };

    const selectedValue = $(this).val();
    const jobDropdown = $('#general_info_job_name');
    
    // Clear and reset the dropdown
    jobDropdown.empty();
    if (options[selectedValue]) {
        jobDropdown.append('<option>Select One</option>'); // Default option
        options[selectedValue].forEach(option => {
            jobDropdown.append(`<option>${option}</option>`);
        });
    } else {
        // If no valid selection, show a default option or hide all
        jobDropdown.append('<option>Select a valid category</option>');
    }
});

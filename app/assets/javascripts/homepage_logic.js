$(document).on('turbolinks:load', function() {
if (typeof $ === 'undefined') {
    console.error("jQuery is not loaded on this page.");
}

const indicator = localStorage.getItem('buttonpressed');

// Mapping sections and buttons to their respective indicators
const sections = {
    model: ".modeldiv",
    brand: ".branddiv",
    photographer: ".photographerdiv",
    othercreator: ".othercreatordiv",
    influencer: ".influencerdiv",
    blogger: ".bloggingdiv",
    content: ".contentdiv",
    sales: ".salesdiv",
    marketing: ".marketingdiv",
    retail: ".retaildiv",
    financing: ".financingdiv",
    otherservices: ".otherservicesdiv",
    manufacturing: ".manufacturingdiv",
    materials: ".materialsdiv",
    othermakers: ".othermakersdiv",
    agent: ".agentdiv",
    designer: ".designerdiv",
    everyone: ".everyonediv",
    stylist: ".stylistdiv",
    forecasting: ".forecastingdiv",
    visual: ".visualdiv"
};

// Function to reset visibility and active states
function resetSections() {
    Object.values(sections).forEach(selector => $(selector).hide());
    $(".alldiv").hide();
    $(".active").removeClass("active");
}

// Function to show a specific section and activate the corresponding button
function activateSection(key) {
    resetSections();
    if (sections[key]) {
        $(sections[key]).show();
        $(`.${key}button`).addClass("active");
        localStorage.setItem('buttonpressed', key);
    }
}

// Initialize the view based on the stored indicator
if (indicator === 'false') {
    resetSections();
} else {
    activateSection(indicator);
}

// Example of usage to change indicator when a new button is pressed
// $('.some-button').on('click', () => activateSection('some-key'));
});
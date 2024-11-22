var indicator = localStorage.getItem('buttonpressed');

// Mapping sections and buttons to their respective indicators
const sections = {
    model: ".model",
    brand: ".brand",
    photographer: ".photographer",
    othercreator: ".othercreator",
    influencer: ".influencer",
    blogger: ".blogging",
    content: ".content",
    sales: ".sales",
    marketing: ".marketing",
    retail: ".retail",
    financing: ".financing",
    otherservices: ".otherservices",
    manufacturing: ".manufacturing",
    materials: ".materials",
    othermakers: ".othermakers",
    agent: ".agent",
    designer: ".designer",
    everyone: ".everyone",
    stylist: ".stylist",
    forecasting: ".forecasting",
    visual: ".visual"
};

// Function to reset visibility and active states
function resetSections() {
    Object.values(sections).forEach(selector => $(selector + "div").hide());
    $(".alldiv").hide();
    Object.values(sections).forEach(selector => $(selector + "button").removeClass("active"));
}

// Function to show a specific section and activate the corresponding button
function activateSection(key) {
    console.log(sections[key])
    resetSections();
    if (sections[key]) {
        $(sections[key]).show();
        $("." + key + "button").addClass("active");
        localStorage.setItem('buttonpressed', key);
    }
}

// Initialize the view based on the stored indicator
if (indicator == 'false') {
    resetSections();
} else {
    activateSection(indicator);
}

// Example of usage to change indicator when a new button is pressed
// $('.some-button').on('click', () => activateSection('some-key'));

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets.sprockets-directives) for details
// about supported directives.
//

// A $( document ).ready() block.

// Function hides all changing divs
function hideAll() {
    $(".alldiv").hide();
    $(".bloggingdiv").hide();
    $(".salesdiv").hide();
    $(".contentdiv").hide();
    $(".influencerdiv").hide();
    $(".othercreatordiv").hide();
    $(".designerdiv").hide();
    $(".photographerdiv").hide();
    $(".branddiv").hide();
    $(".marketingdiv").hide();
    $(".retaildiv").hide();
    $(".financingdiv").hide();
    $(".otherservicesdiv").hide();
    $(".manufacturingdiv").hide();
    $(".materialsdiv").hide();
    $(".othermakersdiv").hide();
    $(".visualdiv").hide();
    $(".modeldiv").hide();
    $(".agentdiv").hide();
    $(".everyonediv").hide();
    $(".stylistdiv").hide();
    $(".forecastingdiv").hide();
}

// Function removes active from all relevent buttons
function deactivateAll() {
    $(".marketingbutton").removeClass("active");
    $(".visualbutton").removeClass("active");
    $(".retailbutton").removeClass("active");
    $(".financingbutton").removeClass("active");
    $(".otherservicesbutton").removeClass("active");
    $(".manufacturingbutton").removeClass("active");
    $(".materialsbutton").removeClass("active");
    $(".othermakersbutton").removeClass("active");
    $(".everyonebutton").removeClass("active");
    $(".agentbutton").removeClass("active");
    $(".modelbutton").removeClass("active");
    $(".brandbutton").removeClass("active");
    $(".photographerbutton").removeClass("active");
    $(".designerbutton").removeClass("active");
    $(".othercreatorbutton").removeClass("active");
    $(".influencerbutton").removeClass("active");
    $(".contentbutton").removeClass("active");
    $(".salesbutton").removeClass("active");
    $(".bloggerbutton").removeClass("active");
    $(".stylistbutton").removeClass("active");
    $(".forecastingbutton").removeClass("active");
}

// Function combines hide and deactivate
function cleanButtonDiv() {
    hideAll();
    deactivateAll();
}

$( document ).ready(function() {
    hideAll();

    function setupButton(buttonType) {
        $(`.${buttonType}button`).click(function () {
            localStorage.setItem('buttonpressed', buttonType);
            cleanButtonDiv();
            $(`.${buttonType}div`).show();
            $(`.${buttonType}button`).addClass("active");
        });
    }
    
    // Call setupButton for each button type
    setupButton("brand");
    setupButton("photographer");
    setupButton("designer");
    setupButton("othercreator");
    setupButton("influencer");
    setupButton("content");
    setupButton("sales");
    setupButton("blogger");
    setupButton("marketing");
    setupButton("retail");
    setupButton("financing");
    setupButton("otherservices");
    setupButton("manufacturing");
    setupButton("materials");
    setupButton("othermakers");
    setupButton("visual");
    setupButton("model");
    setupButton("agent");
    setupButton("everyone");
    setupButton("stylist");
    setupButton("forecasting");
});





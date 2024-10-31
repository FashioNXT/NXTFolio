
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

console.log("Javascript update testing");

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
    console.log("I am inside document function");
    hideAll();
    console.log("Printing Button Status:..")

    $(".modelbutton").on("click", function(){
        localStorage.setItem('buttonpressed', 'model');
        cleanButtonDiv();
        $(".modeldiv").show();
        $(".modelbutton").addClass("active");
    });
    $(".brandbutton").click(function () {
        localStorage.setItem('buttonpressed', 'brand');
        cleanButtonDiv();
        $(".branddiv").show();
        $(".brandbutton").addClass("active");
    });

    $(".photographerbutton").click(function () {
        localStorage.setItem('buttonpressed', 'photographer');
        cleanButtonDiv();
        $(".photographerdiv").show();
        $(".photographerbutton").addClass("active");
    });

    $(".designerbutton").click(function () {
        localStorage.setItem('buttonpressed', 'designer');
        cleanButtonDiv();
        $(".designerdiv").show();
        $(".designerbutton").addClass("active");
    });

    $(".othercreatorbutton").click(function () {
        localStorage.setItem('buttonpressed', 'othercreator');
        cleanButtonDiv();
        $(".othercreatordiv").show();
        $(".othercreatorbutton").addClass("active");
    });

    $(".influencerbutton").click(function () {
        localStorage.setItem('buttonpressed', 'influencer');
        cleanButtonDiv();
        $(".influencerdiv").show();
        $(".influencerbutton").addClass("active");
    });

    $(".contentbutton").click(function () {
        localStorage.setItem('buttonpressed', 'content');
        cleanButtonDiv();
        $(".contentdiv").show();
        $(".contentbutton").addClass("active");
    });

    $(".salesbutton").click(function () {
        localStorage.setItem('buttonpressed', 'sales');
        cleanButtonDiv();
        $(".salesdiv").show();
        $(".salesbutton").addClass("active");
    });

    $(".bloggerbutton").click(function () {
        localStorage.setItem('buttonpressed', 'blogger');
        cleanButtonDiv();
        $(".bloggingdiv").show();
        $(".bloggerbutton").addClass("active");
    });

    $(".marketingbutton").click(function () {
        localStorage.setItem('buttonpressed', 'marketing');
        cleanButtonDiv();
        $(".marketingdiv").show();
        $(".marketingbutton").addClass("active");
    });

    $(".retailbutton").click(function () {
        localStorage.setItem('buttonpressed', 'retail');
        cleanButtonDiv();
        $(".retaildiv").show();
        $(".retailbutton").addClass("active");
    });

    $(".visualbutton").click(function () {
        localStorage.setItem('buttonpressed', 'visual');
        cleanButtonDiv();
        $(".visualdiv").show();
        $(".visualbutton").addClass("active");
    });

    $(".financingbutton").click(function () {
        localStorage.setItem('buttonpressed', 'financing');
        cleanButtonDiv();
        $(".financingdiv").show();
        $(".financingbutton").addClass("active");
    });

    $(".forecastingbutton").click(function () {
        localStorage.setItem('buttonpressed', 'forecasting');
        cleanButtonDiv();
        $(".forecastingdiv").show();
        $(".forecastingbutton").addClass("active");
    });

    $(".stylistbutton").click(function () {
        localStorage.setItem('buttonpressed', 'stylist');
        cleanButtonDiv();
        $(".stylistdiv").show();
        $(".stylistbutton").addClass("active");
    });

    $(".otherservicesbutton").click(function () {
        localStorage.setItem('buttonpressed', 'otherservices');
        cleanButtonDiv();
        $(".otherservicesdiv").show();
        $(".otherservicesbutton").addClass("active");
    });

    $(".manufacturingbutton").click(function () {
        localStorage.setItem('buttonpressed', 'manufacturing');
        cleanButtonDiv();
        $(".manufacturingdiv").show();
        $(".manufacturingbutton").addClass("active");
    });

    $(".materialsbutton").click(function () {
        localStorage.setItem('buttonpressed', 'materials');
        cleanButtonDiv();
        $(".materialsdiv").show();
        $(".materialsbutton").addClass("active");
    });

    $(".othermakersbutton").click(function () {
        localStorage.setItem('buttonpressed', 'othermakers');
        cleanButtonDiv();
        $(".othermakersiv").show();
        $(".othermakersbutton").addClass("active");
    });
});





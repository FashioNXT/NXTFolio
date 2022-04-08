// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

// A $( document ).ready() block.
$( document ).ready(function() {
    //$("#Model1").show();
    //$("#Model").addClass("active");
    $("#Photographer1").hide();
    $("#Agent1").hide();
    $("#Designer1").hide();
    $("#Everyone1").hide();
    $("#Brand").click(function () {

        $("#brand1").show();
        $("#Model1").hide();
        $("#Photographer1").hide();
        $("#Agent1").hide();
        $("#Designer1").hide();
        $("#Everyone1").hide();
        $("#othercreator1").hide();
        $("#influencer1").hide();
        $("#content1").hide();
        $("#sales1").hide();
        $("#retail1").hide();
        $("#visual1").hide();
        $("#blogging1").hide();
        $("#financing1").hide();
        $("#marketing1").hide();
        $("#manufacturing1").hide();
        $("#materials1").hide();
        $("#othermakers1").hide();
        $("#otherservices1").hide();
        $("#Designer").removeClass("active");
        $("#Other_creator").removeClass("active");
        $("#Everyone").removeClass("active");
        $("#Influencer").removeClass("active");
        $("#Blogger").removeClass("active");
        $("#Financing").removeClass("active");
        $("#Sales").removeClass("active");
        $("#Marketing").removeClass("active");
        $("#Retial").removeClass("active");
        $("#Visual").removeClass("active");
        $("#Blogger").removeClass("active");
        $("#Financing").removeClass("active");
        $("#Manufacturing").removeClass("active");
        $("#Materials").removeClass("active");
        $("#Other_makers").removeClass("active");
        $("#Other_services").removeClass("active");
        $("#Agent").removeClass("active");
        $("#Photographer").removeClass("active");
        $("#Model").removeClass("active");
        $("#Brand").addClass("active");
    });
    $("#Model").click(function () {
        $("#Model1").show();
        $("#Photographer1").hide();
        $("#Agent1").hide();
        $("#Brand1").hide();
        $("#Designer1").hide();
        $("#Everyone1").hide();
        $("#Designer").removeClass("active");
        $("#Everyone").removeClass("active");
        $("#Agent").removeClass("active");
        $("#Brand").removeClass("active");
        $("#Photographer").removeClass("active");
        $("#Model").addClass("active");
    });
    $("#Photographer").click(function () {
        $("#Model1").hide();
        $("#Model").removeClass("active");
        $("#Designer").removeClass("active");
        $("#Everyone").removeClass("active");
        $("#Agent").removeClass("active");
        $("#Photographer").addClass("active");
        $("#Photographer1").show();
        $("#Agent1").hide();
        $("#Designer1").hide();
        $("#Everyone1").hide();
    });
    $("#Agent").click(function () {
        $("#Model1").hide();
        $("#Model").removeClass("active");
        $("#Designer").removeClass("active");
        $("#Everyone").removeClass("active");
        $("#Photographer").removeClass("active");
        $("#Agent").addClass("active");
        $("#Photographer1").hide();
        $("#Agent1").show();
        $("#Designer1").hide();
        $("#Everyone1").hide();
    });
    $("#Designer").click(function () {
        $("#Model1").hide();
        $("#Model").removeClass("active");
        $("#Photographer").removeClass("active");
        $("#Agent").removeClass("active");
        $("#Designer").addClass("active");
        $("#Everyone").removeClass("active");
        $("#Photographer1").hide();
        $("#Agent1").hide();
        $("#Everyone1").hide();
        $("#Designer1").show();
    });
    $("#Everyone").click(function () {
        $("#Model1").hide();
        $("#Model").removeClass("active");
        $("#Photographer").removeClass("active");
        $("#Agent").removeClass("active");
        $("#Designer").removeClass("active");
        $("#Photographer1").hide();
        $("#Everyone").addClass("active");
        $("#Agent1").hide();
        $("#Designer1").hide();
        $("#Everyone1").show();
    });
    
});




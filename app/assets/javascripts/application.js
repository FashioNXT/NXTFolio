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
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require template_util

$( document ).ready(function() {
    $("#Model1").show();
    $("#Model").addClass("active");

    $("#Photographer1").hide();
    $("#Agent1").hide();
    $("#Designer1").hide();
    $("#Model").click(function () {
        $("#Model1").show();
        $("#Photographer1").hide();
        $("#Agent1").hide();
        $("#Designer1").hide();
        $("#Designer").removeClass("active");
        $("#Agent").removeClass("active");
        $("#Photographer").removeClass("active");
        $("#Model").addClass("active");
    });
    $("#Photographer").click(function () {
        $("#Model1").hide();
        $("#Model").removeClass("active");
        $("#Designer").removeClass("active");
        $("#Agent").removeClass("active");
        $("#Photographer").addClass("active");
        $("#Photographer1").show();
        $("#Agent1").hide();
        $("#Designer1").hide();
    });
    $("#Agent").click(function () {
        $("#Model1").hide();
        $("#Model").removeClass("active");
        $("#Designer").removeClass("active");
        $("#Photographer").removeClass("active");
        $("#Agent").addClass("active");
        $("#Photographer1").hide();
        $("#Agent1").show();
        $("#Designer1").hide();
    });
    $("#Designer").click(function () {
        $("#Model1").hide();
        $("#Model").removeClass("active");
        $("#Photographer").removeClass("active");
        $("#Agent").removeClass("active");
        $("#Designer").addClass("active");
        $("#Photographer1").hide();
        $("#Agent1").hide();
        $("#Designer1").show();
    });
});
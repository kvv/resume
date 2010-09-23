// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// $(".cities").load('/choose_city.js')*/

function choose_city() {
  $("#choose_city").click(function(){
    $.get("/choose_city.js", function(data) {
      var selector = $("a#choose_city");
      selector.after(data);
      selector.before('Выберите ваш город в списке  ');
      selector.remove();
    });
    return false;
  });
};

function choose_category() {
  $(".choose_category").click(function(){
    $.get($(this).attr('href').replace('.html')+'.js', function(data) {
      $("#main").html(data);
    });
    /*alert('Дошло');*/
    return false;
  });
};

function close_flash() {
  $("#close_flash").click(function () {
    $("#flash").slideUp(500);
  });
};

function change_password() {
  $("#change_password").click(function () {
    $("#passwords").load('/get_passwords.js');
    /*$("#user_submit").attr('disabled', 'disabled');*/
    return false;
  });
};

function ajaxStart() {
  $('#ajax_indicator').ajaxStart(function() {
    $(this).show();
  }).ajaxStop(function(){
    $(this).hide();
  });
  $("#message").ajaxComplete(function(){
    $(this).show();
  });
};

$(document).ready(function() {
  ajaxStart();
  choose_city();
  choose_category();
  close_flash();
  change_password();
});


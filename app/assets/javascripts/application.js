// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .
//= require highcharts
//= require ./admin/admin
//= require ./agent/agent


$(function() {
  $("#agents th a, #agents .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });

  $("#users th a, #users .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });

  $("#on_going th a, #on_going .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });

  $("#completed th a, #completed .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  
});

$(document).ready(function(){
   $( ".datepicker-dob" ).datepicker({ changeYear: true, dateFormat: 'dd/mm/yy', minDate: '-100Y',
     maxDate: '-2Y', yearRange: '-100' } );
    // changeMonth: true,
    // changeYear: true,
    // showOn: 'button',
    // // buttonImage: 'images/calendar.gif',
    // buttonImageOnly: true,
    // dateFormat: 'dd/mm/yy',
    // minDate: '-100Y',
    // maxDate: '-2Y', 
    // yearRange: '-100',
  // });
 
  $('#claim_ids_').click(function(){
    
  });



});





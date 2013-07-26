$(document).ready(function(){
   $('.success_agent').hide();
  $('.new-user-btn').click(function(){
    $('.new-user-div').show();

    // $(this).hide();
  });
  $('#new-user-submit').click(function(){
    $.ajax({
      url: "/agent/create_user",
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: $('.new_user').serializeArray(),
      dataType: "json",
      type: "POST",
      success: function(data){
       $('#new-user-div').load('/agent/add_claim?id='+data.userid);
        $('.error-msg').remove();
        $('.new_user').closest('form').find("input[type=text], textarea").val("");
   
        $('.success_agent').show();
        $('<p> User Added Successfully </p>').appendTo($('.success_agent'));
       
     },
      error: function(xhr){
        $('.error-msg').remove();
        $('.new-user-errors').text('');
        var errors = $.parseJSON(xhr.responseText).errors
        $.each(errors, function(index, value) {
          switch(value){
             case 'First name can\'t be blank':
             $('<p class="error-msg">'+value+'</p>').appendTo($('#usr-first-name'));
             break;
             case 'Last name can\'t be blank':
              $('<p class="error-msg">'+value+'</p>').appendTo($('#usr-last-name'));
             break;
             case 'User name can\'t be blank':
              $('<p class="error-msg">'+value+'</p>').appendTo($('#usr-user-name'));
             break;
             case 'Location can\'t be blank':
              $('<p class="error-msg">'+value+'</p>').appendTo($('#usr-location'));
             break;
             case 'Zip is not a number':
              $('<p class="error-msg">'+value+'</p>').appendTo($('#usr-zip'));
             break;
             case 'Address can\'t be blank':
              $('<p class="error-msg">'+value+'</p>').appendTo($('#usr-address'));
             break;
             case 'Dob translation missing: en.activerecord.errors.models.user.attributes.dob.invalid_date':
              $('<p class="error-msg">DOB format.. (Ex: 25/03/2000)</p>').appendTo($('#usr-dob'));
             break;
            case 'Email can\'t be blank':
              $('<p class="email-error1">'+value+'</p>').appendTo($('#usr-email'));
              break;
              // case 'Email can\'t be blank':
              // $('<p class="email-error1">'+value+'</p>').appendTo($('#usr-email'));
              // break;

            case 'Email is invalid':
                if($('p').hasClass('email-error1')){
                  $('.email-error1').remove();
                  $('<p class="error-msg">'+value+'</p>').appendTo($('#usr-email'));
                   // $('<p>Email InValid</p>').append($('.email-error1'));
                }else{
                $('.error-msg').remove();
                 $('<p class="error-msg">'+value+'</p>').appendTo($('#usr-email'));
               }
             break;
             case "Mobile is too long (maximum is 10 characters)":
               $('<p class="error-msg">'+value+'</p>').appendTo($('#usr-mobile'));
              break;
              case "Mobile is too short (minimum is 10 characters)":
               $('<p class="error-msg">'+value+'</p>').appendTo($('#usr-mobile'));
              break;
             case 'Mobile is not a number':
              $('<p class="error-msg">'+value+'</p>').appendTo($('#usr-mobile'));
             break;
             case 'Dob must be at least 18 years old':
              $('<p class="error-msg">'+value+'</p>').appendTo($('#usr-dob'));
             break;
            }
           // $('<p>'+ index + ':' + value + '</p>').appendTo($('.new-user-errors'));
        });
      }
      // must be at least 18 years old
    }); 

    return false;
  })
  
  $('.close-usr-form').click(function(){
     $('.new-user-btn').show();
     $('.new_user').closest('form').find("input[type=text], textarea").val("");
     $('.new-user-div').hide();
     $('.error-msg').remove();
  })

})

$(function() {
  $("#agents th a, #agents .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });

  $("#agent_users th a, #agent_users .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });

  $("#in_process_claims th a, #in_process_claims .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });

  $("#products_search input").keyup(function() {
    $.get($("#products_search").attr("action"), $("#products_search").serialize(), null, "script");
    return false;
  });

});

$(function() {
  $( "#datepicker-dob1" ).datepicker( { dateFormat: 'dd/mm/yy', 
    // changeMonth: true,
    changeYear: true, minDate: '-100Y',
    maxDate: '-2Y', 
    yearRange: '-100', });
  //getter
  // var yearRange = $( "#datepicker-dob1" ).datepicker( {
  //   changeMonth: true,
  //   changeYear: true,
  //   showOn: 'button',
  //   // buttonImage: 'images/calendar.gif',
  //   buttonImageOnly: true,
  //   dateFormat: 'dd/mm/yy',
  //   minDate: '-100Y',
  //   maxDate: '-2Y', 
  //   yearRange: '-100',
  // });
 
});

 $(document).ready(function(){
   $("#customer_claims_attributes_0_is_damage_occur_your_home").live('click', function(){
    if($(this).is(':checked')){ 
        $(".f1").css('display','block');
        $(".f1 input").addClass("fields");
       }
    else { 
        $(".f1").hide();
        $(".f1 input").removeClass("fields");
    }
   });
$("#customer_claims_attributes_0_is_home_or_any_part_lent_or_sublet").live('click', function(){
    if($(this).is(':checked')){ 
        $(".f2").show();
        $(".f2 input").addClass("fields");
       }
    else { 
        $(".f2").hide();
        $(".f2 input").removeClass("fields");
    }
   });
$("#customer_claims_attributes_0_have_made_any_claim_before").live('click', function(){
    if($(this).is(':checked')){ 
        $(".f3").show();
        $(".f3 input").addClass("fields");
       }
    else { 
        $(".f3").hide();
        $(".f3 input").removeClass("fields");
    }
   });
$("#customer_claims_attributes_0_are_you_owner_of_lost").live('click', function(){
    if($(this).is(':checked')){ 
        $(".f4").show();
        $(".f4 input").addClass("fields");
       }
    else { 
        $(".f4").hide();
        $(".f4 input").removeClass("fields");
    }
   });

$("#customer_claims_attributes_0_occupied_home_as_tenant").live('click', function(){
    if($(this).is(':checked')){ 
        $(".f5").show();
        $(".f5 input").addClass("fields");
       }
    else { 
        $(".f5").hide();
        $(".f5 input").removeClass("fields");
    }
   });
   
   $("#customer_claims_attributes_0_are_you_responsible_for_tenancy_agreement").live('click', function(){
    if($(this).is(':checked')){ 
        $(".f6").show();
        $(".f6 input").addClass("fields");
       }
    else { 
        $(".f6").hide();
        $(".f6 input").removeClass("fields");
    }
   });

$("#customer_claims_attributes_0_are_you_responsible_for_tenancy_agreement").live('click', function(){
    if($(this).is(':checked')){ 
        $(".f7").show();
        $(".f7 input").addClass("fields");
       }
    else { 
        $(".f7").hide();
        $(".f7 input").removeClass("fields");
    }
   });

$("#customer_claims_attributes_0_have_estimates").live('click', function(){
    if($(this).is(':checked')){ 
        $(".f8").show();
        $(".f8 input").addClass("fields");
       }
    else { 
        $(".f8").hide();
        $(".f8 input").removeClass("fields");
    }
   });

$("#customer_claims_attributes_0_are_estimates_sent_late_date").live('click', function(){
    if($(this).is(':checked')){ 
        $(".f9").show();
        $(".f9 input").addClass("fields");
       }
    else { 
        $(".f9").hide();
        $(".f9 input").removeClass("fields");
    }
   });
 });

$(document).ready(function(){
   claimform('userid');
 });

function claimform(userid){
  $('#edit_customer_'+userid ).submit(function(){ 
    var valid = true;
    $('input.fields').each(function (n,element) {
      if (!$.trim(this.value)) {
        $("#errormsg").html("Please fill all required fields ");
        if ($(element).val() == "" ) {
          $(element).css('background-color','pink');
          valid = false;
        }
      }
    });
    if (!valid) {
      // Cancel submission
      return false;
    }
  });
  $('input.fields').each(function (n,element) {
    $(element).focus(function() {
      var value = $(this).val();
      }).blur(function (){
      var value = $(this).val();
      if (value == ""){
        $(this).css('background-color','pink');
      }else{
        $(this).css('background-color','');
      }
    });
  });
}

// $("#customer_claims_attributes_0_is_damage_occur_your_home").c

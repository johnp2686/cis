 $(document).ready(function() {
  $('.success_agent').hide();
   $('#add-new-agent').hide();
   $('#create-agent').click(function(){
      $.ajax({
        url: "/users/create_agent",
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        data: $('#new-agent-form').serializeArray(),
        dataType: "json",
        type: "POST",
        success: function(data){
          $('.new-agent-errors').text('');
          $('#new-agent-form').closest('form').find("input[type=text], textarea").val("");
          $('#add-new-agent').hide();
          $("#list-agents").last().append($("<tr><td>" + data.user_name + "</td><td>" + data.first_name + "</td><td>" + data.last_name + "</td><td>" + data.email + "</td><td>" + data.mobile + "</td></tr>"));
          $('.success_agent').show();
          $('<p> Agent Added Successfully </p>').appendTo($('.success_agent'));
          console.log(data);

        },
        error: function(xhr){
          $('.new-agent-errors').text('');
          var errors = $.parseJSON(xhr.responseText).errors
           if($('td').hasClass('error-msg')){
            $('.error-msg').remove();
          }
          $.each(errors, function(index, value) {
            switch(value){

              case 'Emp has already been taken':
              $('<td class="error-msg">'+value+'</td>').appendTo($('#agent-emp-id'));
              break;
              case 'Emp can \'t be blank':
              $('<td class="error-msg">'+value+'</td>').appendTo($('#agent-emp-id'));
              break;
             case 'First name can\'t be blank':
             $('<td class="error-msg">'+value+'</td>').appendTo($('#agent-first-name'));
             break;
             case 'Last name can\'t be blank':
              $('<td class="error-msg">'+value+'</td>').appendTo($('#agent-last-name'));
             break;
             case 'User name can\'t be blank':
              $('<td class="error-msg">'+value+'</td>').appendTo($('#agent-user-name'));
             break;
             case 'Location can\'t be blank':
              $('<td class="error-msg">'+value+'</td>').appendTo($('#agent-location'));
             break;
             case 'Zip is not a number':
              $('<td class="error-msg">'+value+'</td>').appendTo($('#agent-zip'));
             break;
             case 'Address can\'t be blank':
              $('<td class="error-msg">'+value+'</td>').appendTo($('#agent-address'));
             break;
             case 'Dob translation missing: en.activerecord.errors.models.user.attributes.dob.invalid_date':
              $('<td class="error-msg">DOB format.. (Ex: 25/03/2000)</td>').appendTo($('#agent-dob'));
             break;
            case 'Email can\'t be blank':
              $('<td class="email-error1">'+value+'</td>').appendTo($('#agent-email'));
              break;
            case 'Email is invalid':
                if($('td').hasClass('email-error1')){
                  $('.email-error1').remove();
                  $('<td class="error-msg">'+value+'</td>').appendTo($('#agent-email'));
                   // $('<td>Email InValid</td>').append($('.email-error1'));
                }else{
                $('.error-msg').remove();
                 $('<td class="error-msg">'+value+'</td>').appendTo($('#agent-email'));
               }
             break;
             case 'Mobile is too short (minimum is 10 characters':
               $('<td class="error-msg">'+value+'</td>').appendTo($('#agent-mobile'));
             case 'Mobile is not a number':
              $('<td class="error-msg">'+value+'</td>').appendTo($('#agent-mobile'));
             break;
            }
             // $('<p>'+ index + ':' + value + '</p>').appendTo($('.new-agent-errors'));
          });
       }
      }); 
    return false;
   });

  $('#add-agent-btn').click(function(){
    $(this).hide();
    $('#add-new-agent').show();
  })
  $('.close-agent-form').click(function(){
    $('#add-agent-btn').show();
    $('.error-msg').remove();
    $('.new-agent-errors').text('');
    $('#new-agent-form').closest('form').find("input[type=text], textarea").val("");
    $('#add-new-agent').hide();
  })
});

// $('#pagination_click').click(function(){
//     $('.success_agent').hide();
//    $('#add-new-agent').hide();
// })


 $(function() {
  $("#claims th a, #claims .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });

});
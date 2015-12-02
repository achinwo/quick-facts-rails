// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//require tether
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

$(function (){
    $('a.load-more').click(function (e) {

        // prevent the default click action
        e.preventDefault();

        // hide load more link
        $('.load-more').hide();

        // show loading gif
        $('.loading-gif').show();

        // get the last id and save it in a variable 'last-id'
        var last_id = $('.search-result').last().attr('data-id');

        // make an ajax call passing along our last user id
        $.ajax({

            // make a get request to the server
            type: "GET",
            // get the url from the href attribute of our link
            url: $(this).attr('href'),
            // send the last id to our rails app
            data: {
                id: last_id,
                query: $('#search-text').val()
            },
            // the response will be a script
            dataType: "script",

            // upon success 
            success: function (data) {
            	console.log(data);
                // hide the loading gif
                
            }
        });

    });
});


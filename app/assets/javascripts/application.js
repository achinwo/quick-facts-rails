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
//= require tether
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function EvaluateForm()
{	
	var str = document.getElementById('searchText').value;
    if( str.substr(-1, 1) == '?'){
    	document.getElementById('searchText').value = str.substr(0, str.length-1);
        document.ajaxSearchFrm.method = "GET";
        var elem = document.getElementById("auth_token");
 		elem.parentElement.removeChild(elem);
        console.log("getting...");
    }
    else{
        document.ajaxSearchFrm.method = "POST";
        document.ajaxSearchFrm.action = "add_fact";
        console.log("Posting...");
    }
    document.forms["ajaxSearchFrm"].submit();

    return false;
}
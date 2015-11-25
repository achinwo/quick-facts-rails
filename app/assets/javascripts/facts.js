

$(function(){
	$('[data-submit-on-enter=true]').on('keyup', function(e){
		if (e.which == 13){
			$(e.target.form).find(':submit').click();
			e.target.value = '';
		} 
	});

	console.log('bound enter key!!');
});


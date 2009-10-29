
$(document).ready(function () {
	$(".sidebar ul").sortable({
		items: 'li',
		handle: '.drag-handle',
		axis: 'y',
		opacity: 0.6,
		cursor: 'move',
		scroll: false,
		scrollSpeed: 0
	}).disableSelection();
	
	$(".sidebar h3 a").toggle(function() {
		$(this).text('Anuluj');
		$(this).parent('h3').next('ul').find('.drag-handle').show();
	}, function() {
		$(this).text('Więcej');
		$(this).parent('h3').next('ul').find('.drag-handle').hide();
	});

});

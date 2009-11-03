$(document).ready(function () {
	$('#recipe_ingredient_list, #ingredients').autocomplete('/ingredients/auto_complete', {
	  minChars: 2,
		multiple: true,
		multipleSeparator: ","
	});
	
	$('#delicious').click(function () {
		window.open('http://delicious.com/save?v=5&noui&jump=close&url='+encodeURIComponent(location.href)+'&title='+encodeURIComponent(document.title), 'delicious','toolbar=no,width=550,height=550'); 
		return false;
	});
	
	$('.delete').click(function () {
		var self = $(this);
		$.post(this.href, { _method: 'delete' }, function () {
			self.parents('li').slideUp();
		}, "script");
		return false;
	});
	
	$('.popup').mouseover(function () {
		$(this).find('ul').show();
	}).mouseleave(function () {
		$(this).find('ul').fadeOut('fast');
	});
	/*$(".sidebar ul").sortable({
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
	});*/

});

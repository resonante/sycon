$ ->
	restvalue = rest_value
	sum = 0
	oc = 0
	$(".calculate").on "keyup", ->
		sum = parseFloat($(this).val()) + parseFloat($('#acb-'+$(this).attr('data-index')).html().replace(".", "").replace(",", "."))
		oc = parseFloat($('#oc-'+$(this).attr('data-index')).html().replace(".", "").replace(",", "."))
		$('#acc-'+$(this).attr('data-index')).html(sum)
		$(this).parent().append('<div id="alrt-msg-'+$(this).attr('data-index')+'" style="display:none;" class="alert alert-danger alert-dismissible fade in" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button><strong>Alerta!</strong></div>')
		if (sum > oc)
			$('#alrt-msg-'+$(this).attr('data-index')).show()
		else
			$('#alrt-msg-'+$(this).attr('data-index')).hide()
		return false
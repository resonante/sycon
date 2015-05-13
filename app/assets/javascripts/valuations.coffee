$ ->
	restvalue = rest_value
	sum = 0
	oc = 0
	$(".calculate").on "keyup", ->
		quantitytotal = parseFloat($('#quantity-'+$(this).attr('data-index')).html().replace(".", "").replace(",", "."))
		quantityresult = parseFloat($(this).val()) + parseFloat($('#aq-'+$(this).attr('data-index')).html().replace(".", "").replace(",", "."))
		$('#acc-'+$(this).attr('data-index')).html(sum)
		if (quantityresult > quantitytotal)
			$('#myModal').modal('show')
			$('#introq').html(quantityresult)
			$('#totalq').html(quantitytotal)
		return false
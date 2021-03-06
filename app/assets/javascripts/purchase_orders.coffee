$ ->
	for i in [0..purchase_order_items_count]
		$("#purchase_order_purchase_order_items_attributes_"+i+"_total").autoNumeric('init');

	item = purchase_order_items_count
	$("#new-item").on "click", ->
		item = item + 1
		html = '<tr id="item-'+item+'">
					<td><a class="remove_item" href="#"><i class="glyphicon glyphicon-trash"></i></a></td>
					<td>
					<input class="form-control" name="purchase_order[purchase_order_items_attributes]['+item+'][item]" id="purchase_order_purchase_order_items_'+item+'_item" type="hidden" value="'+item+'">
					<textarea rows="6" cols="50" class="form-control" name="purchase_order[purchase_order_items_attributes]['+item+'][description]" id="purchase_order_purchase_order_items_'+item+'_description"></textarea></td>
					<td><input class="form-control" name="purchase_order[purchase_order_items_attributes]['+item+'][unit]" id="purchase_order_purchase_order_items_'+item+'_unit" type="text"></td>
					<td><input class="form-control calculate" name="purchase_order[purchase_order_items_attributes]['+item+'][quantity]" id="purchase_order_purchase_order_items_attributes_'+item+'_quantity" type="text" value="0"></td>
					<td><input class="form-control calculate" name="purchase_order[purchase_order_items_attributes]['+item+'][price]" id="purchase_order_purchase_order_items_attributes_'+item+'_price" type="text" value="0"></td>
					<td><input class="form-control calculate" name="purchase_order[purchase_order_items_attributes]['+item+'][total]" id="purchase_order_purchase_order_items_attributes_'+item+'_total" type="text" disabled="disabled" value="0.0"></td>
				</tr>'
		$("#items-table").append html
		$("#new-item").blur()

		$("#purchase_order_purchase_order_items_attributes_"+item+"_total").autoNumeric('init');

		$(".remove_item").on "click", ->
			$(this).parent().parent().remove()
			return false

		$(".calculate").on "keyup", ->
			if ($(this).attr('id').match('price'))
				total = ($(this).val() * $('#' + $(this).attr('id').replace('price', 'quantity')).val()).toFixed(2)
				$('#' + $(this).attr('id').replace('price', 'total')).autoNumeric('set', total)
			else
				total = ($(this).val() * $('#' + $(this).attr('id').replace('quantity', 'price')).val()).toFixed(2)
				$('#' + $(this).attr('id').replace('quantity', 'total')).autoNumeric('set', total)
			return false

		return false

	$(".remove_item").on "click", ->
		$(this).parent().parent().remove()
		return false

	$(".calculate").on "keyup", ->
		if ($(this).attr('id').match('price'))
			total = ($(this).val() * $('#' + $(this).attr('id').replace('price', 'quantity')).val()).toFixed(2)
			$('#' + $(this).attr('id').replace('price', 'total')).autoNumeric('set', total)
		else
			total = ($(this).val() * $('#' + $(this).attr('id').replace('quantity', 'price')).val()).toFixed(2)
			$('#' + $(this).attr('id').replace('quantity', 'total')).autoNumeric('set', total)
		return false

	$(".ajax_remove_item").on "click", ->
		obj = $(this)
		id = $(this).attr('data-itemid')
		$.ajax
			url: "/purchase_order_items/" + id
			method: "DELETE",
			data: { format : 'json' },
			dataType: "js"
			error: (jqXHR, textStatus, errorThrown) ->
		    	$('body').append "AJAX Error: #{textStatus}"
			success: (data, textStatus, jqXHR) ->
		    	obj.parent().parent().remove()		
		return false

	$(".d_remove_item").on "click", ->
		id = $(this).attr('data-itemid')
		$('#purchase_order_purchase_order_items_attributes_'+id+'__destroy').val('1')
		$(this).parent().parent().hide()	
		return false


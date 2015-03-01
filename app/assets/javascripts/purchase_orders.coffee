$ ->
	item = purchase_order_items_count
	$("#new-item").on "click", ->
		item = item + 1
		html = '<tr>
					<td><input class="form-control" name="purchase_order[purchase_order_items_attributes]['+item+'][item]" id="purchase_order_purchase_order_items_item" type="text"></td>
					<td><textarea class="form-control" name="purchase_order[purchase_order_items_attributes]['+item+'][description]" id="purchase_order_purchase_order_items_description"></textarea></td>
					<td><input class="form-control" name="purchase_order[purchase_order_items_attributes]['+item+'][unit]" id="purchase_order_purchase_order_items_unit" type="text"></td>
					<td><input class="form-control" name="purchase_order[purchase_order_items_attributes]['+item+'][quantity]" id="purchase_order_purchase_order_items_quantity" type="text"></td>
					<td><input class="form-control" name="purchase_order[purchase_order_items_attributes]['+item+'][price]" id="purchase_order_purchase_order_items_price" type="text"></td>
					<td></td>
				</tr>'
		$("#items-table").append html
		return false
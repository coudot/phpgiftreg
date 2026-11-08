{*
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*}

<!DOCTYPE html>
<html lang="{$opt.language}">
<head>
	<title>{$messages.tpl.receive.title}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script src="js/giftreg.js"></script>
	
	<script language="JavaScript" type="text/javascript">
		$(document).ready(function() {
			$("#receiverform").validate({
				highlight: validate_highlight,
				success: validate_success,
				rules: {
					buyer: {
						required: true
					},
					quantity: {
						required: true,
						digits: true,
						min: 1,
						max: {$quantity}
					}
				},
				messages: {
					buyer: {
						required: "{$messages.tpl.receive.buyer_required|escape:'javascript'}"
					},
					quantity: {
						required: "{$messages.tpl.receive.quantity_required|escape:'javascript'}",
						digits: "{$messages.tpl.receive.quantity_digits|escape:'javascript'}",
						min: "{$messages.tpl.receive.quantity_min|escape:'javascript'}",
						max: "{$messages.tpl.receive.quantity_max|replace:'%s':$quantity|escape:'javascript'}"
					}
				}
			});
		});
	</script>
</head>
<body>
	{include file='navbar.tpl' isadmin=$isadmin}

	<div class="container" style="padding-top: 60px;">
		<div class="row">
			<div class="col-md-8 offset-md-2">
<form name="receiverform" id="receiverform" method="get" action="receive.php" class="card p-3">
	<input type="hidden" name="action" value="receive">
	<input type="hidden" name="itemid" value="{$itemid}">
	<fieldset>
		<legend>{$messages.tpl.receive.legend}</legend>
		<div class="row mb-3">
			<label class="col-sm-3 col-form-label" for="buyer">{$messages.tpl.receive.buyer}</label>
			<div class="col-sm-9">
				<select id="buyer" name="buyer" class="form-select">
					<option value="">{$messages.tpl.receive.select_buyer}</option>
					{foreach from=$buyers item=row}
						<option value="{$row.userid}">{$row.fullname|escape:'htmlall'}</option>
					{/foreach}
				</select>
			</div>
		</div>
		<div class="row mb-3">
			<label class="col-sm-3 col-form-label" for="quantity">{$messages.tpl.receive.quantity_label|replace:'%s':$quantity}</label>
			<div class="col-sm-9">
				<input type="text" id="quantity" name="quantity" value="1" maxlength="3">
				<p class="form-text">{$messages.tpl.receive.help}</p>
			</div>
		</div>
		<div class="d-flex gap-2">
			<button type="submit" class="btn btn-primary">{$messages.tpl.receive.receive_button}</button>
			<button type="button" class="btn btn-secondary" onClick="document.location.href='index.php';">{$messages.tpl.common.cancel}</button>
		</div>
	</fieldset>
</form>
			</div>
		</div>
	</div>
</body>
</html>

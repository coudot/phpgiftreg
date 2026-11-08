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
	<title>{$messages.tpl.item.title}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script src="js/giftreg.js"></script>

	<script language="JavaScript" type="text/javascript">
		$(document).ready(function() {
			$("#imagefile").change(function() {
				$("#ifnew, #ifreplace").attr('CHECKED', 'CHECKED');	
			});

			$("#itemform").validate({
				highlight: validate_highlight,
				success: validate_success,
				rules: {
					description: {
						required: true,
						maxlength: 255
					},
					/*category: {
						required: true
					},*/
					price: {
						required: true,
						min: 0,
						"number": true
					},
					source: {
						required: true,
						maxlength: 255
					},
					ranking: {
						required: true
					},
					quantity: {
						required: true,
						digits: true,
						min: 1
					},
					url: {
						url: true
					}
				},
				messages: {
					description: {
						required: "{$messages.tpl.item.description_required|escape:'javascript'}",
						maxlength: "{$messages.tpl.item.description_maxlength|escape:'javascript'}"
					},
					/*category: {
						required: "{$messages.tpl.item.category_required|escape:'javascript'}"
					},*/
					price: {
						required: "{$messages.tpl.item.price_required|escape:'javascript'}",
						min: "{$messages.tpl.item.price_min|escape:'javascript'}",
						"number": "{$messages.tpl.item.price_number|escape:'javascript'}"
					},
					source: {
						required: "{$messages.tpl.item.source_required|escape:'javascript'}",
						maxlength: "{$messages.tpl.item.source_maxlength|escape:'javascript'}"
					},
					ranking: {
						required: "{$messages.tpl.item.ranking_required|escape:'javascript'}"
					},
					quantity: {
						required: "{$messages.tpl.item.quantity_required|escape:'javascript'}",
						digits: "{$messages.tpl.item.quantity_digits|escape:'javascript'}",
						min: "{$messages.tpl.item.quantity_min|escape:'javascript'}"
					},
					url: {
						url: "{$messages.tpl.item.url_invalid|escape:'javascript'}"
					}
				}
			});
		});
	</script>
</head>
<body>
	{include file='navbar.tpl' isadmin=$isadmin}

	<div class="container" style="padding-top: 60px;">
	{if $opt.show_helptext}
		<div class="row">
			<div class="col-12">
				<div class="alert alert-info">
		{$messages.tpl.item.help_title}
		<ul>
			<li>{$messages.tpl.item.help_url}</li>
			<li>{$messages.tpl.item.help_comment}</li>
			<li>{$messages.tpl.item.help_price}</li>
			<li>{$messages.tpl.item.help_ranking}</li>
			{if $opt.allow_multiples}
				<li>{$messages.tpl.item.help_quantity}</li>
			{/if}
		</ul>
				</div>
			</div>
		</div>
	{/if}
	<div class="row">
		<div class="col-md-8 offset-md-2">
			<form name="itemform" id="itemform" method="POST" action="item.php" enctype="multipart/form-data" class="card p-3">
				<fieldset>
					<legend>{if $action == 'edit' || (isset($haserror) && $action == 'update')}{$messages.tpl.item.edit_legend}{else}{$messages.tpl.item.add_legend}{/if}</legend>
					{if $action == 'edit' || (isset($haserror) && $action == 'update')}
						<input type="hidden" name="itemid" value="{$itemid}">
						<input type="hidden" name="action" value="update">
					{elseif $action == "add" || (isset($haserror) && $action == 'insert')}
						<input type="hidden" name="action" value="insert">
					{/if}
					<div class="row mb-3 {if isset($description_error)}text-danger{/if}">
						<label class="col-sm-3 col-form-label" for="description">{$messages.tpl.item.description}</label>
						<div class="col-sm-9">
							<input id="description" name="description" type="text" value="{$description|escape:'htmlall'}" class="form-control" placeholder="{$messages.tpl.item.description|escape:'htmlall'}" maxlength="255">
							{if isset($description_error)}
								<span class="invalid-feedback d-block">{$description_error}</span>
							{/if}
						</div>
					</div>
					<div class="row mb-3 {if isset($category_error)}text-danger{/if}">
						<label class="col-sm-3 col-form-label" for="category">{$messages.tpl.item.category}</label>
						<div class="col-sm-9">
							<select id="category" name="category" class="form-select">
								<option value="" {if $category == NULL}SELECTED{/if}>{$messages.tpl.item.uncategorized}</option>
								{foreach from=$categories item=row}
									<option value="{$row.categoryid}" {if $row.categoryid == $category}SELECTED{/if}>{$row.category|escape:'htmlall'}</option>
								{/foreach}
							</select>
							{if isset($category_error)}
								<span class="invalid-feedback d-block">{$category_error}</span>
							{/if}
						</div>
					</div>
					<div class="row mb-3 {if isset($price_error)}text-danger{/if}">
						<label class="col-sm-3 col-form-label" for="price">{$messages.tpl.item.price} ({$opt.currency_symbol})</label>
						<div class="col-sm-9">
							<input id="price" name="price" type="text" value="{$price|escape:'htmlall'}" class="form-control" placeholder="0.00">
							{if isset($price_error)}
								<span class="invalid-feedback d-block">{$price_error}</span>
							{/if}
						</div>
					</div>
					<div class="row mb-3 {if isset($source_error)}text-danger{/if}">
						<label class="col-sm-3 col-form-label" for="source">{$messages.tpl.item.source}</label>
						<div class="col-sm-9">
							<input id="source" name="source" type="text" value="{$source|escape:'htmlall'}" class="form-control" maxlength="255" placeholder="{$messages.tpl.item.source_placeholder|escape:'htmlall'}">
							{if isset($source_error)}
								<span class="invalid-feedback d-block">{$source_error}</span>
							{/if}
						</div>
					</div>
					<div class="row mb-3 {if isset($ranking_error)}text-danger{/if}">
						<label class="col-sm-3 col-form-label" for="ranking">{$messages.tpl.item.ranking}</label>
						<div class="col-sm-9">
							<select id="ranking" name="ranking" multiple="multiple" class="form-select">
								{foreach from=$ranks item=row}
									<option value="{$row.ranking}" {if $row.ranking == $ranking}SELECTED{/if}>{$row.title}</option>
								{/foreach}
							</select>
							{if isset($ranking_error)}
								<span class="invalid-feedback d-block">{$ranking_error}</span>
							{/if}
						</div>
					</div>
					{if $opt.allow_multiples}
						<div class="row mb-3 {if isset($quantity_error)}text-danger{/if}">
							<label class="col-sm-3 col-form-label" for="quantity">{$messages.tpl.item.quantity}</label>
							<div class="col-sm-9">
								<input id="quantity" name="quantity" type="text" value="{$quantity|escape:'htmlall'}" class="form-control" maxlength="3">
								{if isset($quantity_error)}
									<span class="invalid-feedback d-block">{$quantity_error}</span>
								{/if}
							</div>
						</div>
					{else}
						<input type="hidden" name="quantity" value="1">
					{/if}
					<div class="row mb-3 {if isset($url_error)}text-danger{/if}">
						<label class="col-sm-3 col-form-label" for="url">{$messages.tpl.item.url_optional}</label>
						<div class="col-sm-9">
							<input id="url" name="url" type="text" value="{$url|escape:'htmlall'}" class="form-control" maxlength="255">
							{if isset($url_error)}
								<span class="invalid-feedback d-block">{$url_error}</span>
							{/if}
						</div>
					</div>
					{if $opt.allow_images}
						<div class="row mb-3">
							<label class="col-sm-3 col-form-label" for="image">{$messages.tpl.item.image_optional}</label>
							<div class="col-sm-9">
								{if $image_filename == ''}
									<input type="radio" name="image" value="none" CHECKED>
									{$messages.tpl.item.no_image}<br />
									<input type="radio" name="image" value="upload" id="ifnew">
									{$messages.tpl.item.upload_image}
									<input class="form-control" type="file" id="imagefile" name="imagefile">
								{else}
									<input type="radio" name="image" value="remove">
									{$messages.tpl.item.remove_image}<br />
									<input type="radio" name="image" value="keep" CHECKED>
									{$messages.tpl.item.keep_image}<br />
									<input type="radio" name="image" value="replace" id="ifreplace">
									{$messages.tpl.item.replace_image}
									<input class="form-control" type="file" id="imagefile" name="imagefile">
								{/if}
							</div>
						</div>
					{/if}
					<div class="row mb-3">
						<label class="col-sm-3 col-form-label" for="comment">{$messages.tpl.item.comment}</label>
						<div class="col-sm-9">
							<textarea id="comment" name="comment" class="form-control" rows="2" cols="40">{$comment|escape:'htmlall'}</textarea>
						</div>
					</div>
					<div class="d-flex gap-2">
						<button type="submit" class="btn btn-primary">{$messages.tpl.common.save}</button>
						<button type="button" class="btn btn-secondary" onclick="document.location.href='index.php';">{$messages.tpl.common.cancel}</button>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
	</div>
</body>
</html>

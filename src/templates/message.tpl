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
	<title>{$messages.tpl.message.title}</title>
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link </head>
<body>
	{include file='navbar.tpl' isadmin=$isadmin}
	
	<div class="container" style="padding-top: 60px;">
		<div class="row">
			<div class="col-12">
				<form name="message" method="get" action="message.php" class="card p-3">
					<input type="hidden" name="action" value="send">
					<fieldset>
						<legend>{$messages.tpl.message.send}</legend>
						<div class="row mb-3">
							<label class="col-sm-3 col-form-label" for="recipients[]">{$messages.tpl.message.recipients}</label>
							<div class="col-sm-9">
								<select name="recipients[]" size="{$rcount}" MULTIPLE class="form-select">
									{foreach from=$recipients item=row}
										<option value="{$row.userid}">{$row.fullname|escape:'htmlall'}</option>
									{/foreach}
								</select>
							<p class="form-text">{$messages.tpl.message.select_help}</p>
							</div>
						</div>
						<div class="row mb-3">
							<label class="col-sm-3 col-form-label" for="msg">{$messages.tpl.message.message}</label>
							<div class="col-sm-9">
								<textarea id="msg" name="msg" rows="5" cols="40" class="form-control"></textarea>
							</div>
						</div>
						<div class="d-flex gap-2">
							<button type="submit" class="btn btn-primary">{$messages.tpl.message.send_button}</button>
							<button type="button" class="btn btn-secondary" onClick="document.location.href='index.php';">{$messages.tpl.common.cancel}</button>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>

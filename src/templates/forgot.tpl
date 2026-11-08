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
	<title>{$messages.tpl.forgot.title}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script src="js/giftreg.js"></script>

	<script language="JavaScript" type="text/javascript">
		$(document).ready(function() {
			$("#forgotform").validate({
				highlight: validate_highlight,
				success: validate_success,
				rules: {
					username: {
						required: true
					},
				},
				messages: {
					username: {
						required: "{$messages.tpl.forgot.username_required|escape:'javascript'}"
					}
				}
			});
		});
	</script>
</head>
<body>
	<div class="container" style="padding-top: 30px;">

	{if isset($action) && $action == "forgot" && $error == ""}
		<div class="row">
			<div class="col-12">
				<div class="card p-3">
					<p>{$messages.tpl.forgot.sent}</p>
					<p>{$messages.tpl.forgot.login_link}</p>
				</div>
			</div>
		</div>
	{else}
		<div class="row">
			<div class="col-12">
				<form name="forgotform" id="forgotform" method="post" action="forgot.php" class="card p-3">
					<input type="hidden" name="action" value="forgot">
					<fieldset>
						<legend>{$messages.tpl.forgot.legend}</legend>
						<div class="row mb-3 {if isset($error)}text-danger{/if}">
							<label class="col-sm-3 col-form-label" for="username">{$messages.tpl.forgot.username}</label>
							<div class="col-sm-9">
								<input id="username" name="username" type="text" class="form-control" value="{$username|escape:'htmlall'}">
								{if isset($error)}
									<span class="invalid-feedback d-block">{$error|escape:'htmlall'}</span>
								{/if}
								<p class="form-text">
									{$messages.tpl.forgot.help}
								</p>
							</p>
						</div>
						<div class="d-flex gap-2">
							<button type="submit" class="btn btn-primary">{$messages.tpl.common.submit}</button>
							<button type="button" class="btn btn-secondary" onClick="document.location.href='login.php';">{$messages.tpl.common.cancel}</button>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	{/if}
	</div>
</body>
</html>

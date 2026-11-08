{*
This program is free software; you can redistribute it and/or modify
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
	<title>{$messages.tpl.profile.title}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script src="js/giftreg.js"></script>

	<script language="JavaScript" type="text/javascript">
		$(document).ready(function() {
			$("#changepwdform").validate({
				highlight: validate_highlight,
				success: validate_success,
				rules: {
					newpwd: {
						required: true,
						maxlength: 50
					},
					confpwd: {
						required: true,
						maxlength: 50,
						equalTo: "#newpwd"
					}
				},
				messages: {
					newpwd: {
						required: "{$messages.tpl.profile.password_required|escape:'javascript'}",
						maxlength: "{$messages.tpl.profile.password_maxlength|escape:'javascript'}"
					},
					confpwd: {
						required: "{$messages.tpl.profile.confirmation_required|escape:'javascript'}",
						maxlength: "{$messages.tpl.profile.confirmation_maxlength|escape:'javascript'}",
						equalTo: "{$messages.tpl.profile.password_mismatch|escape:'javascript'}"
					}
				}
			});
			$("#profileform").validate({
				highlight: validate_highlight,
				success: validate_success,
				rules: {
					fullname: {
						required: true,
						maxlength: 50
					},
					email: {
						required: true,
						maxlength: 255,
						email: true
					}
				},
				messages: {
					fullname: {
						required: "{$messages.tpl.profile.fullname_required|escape:'javascript'}",
						maxlength: "{$messages.tpl.profile.fullname_maxlength|escape:'javascript'}"
					},
					email: {
						required: "{$messages.tpl.profile.email_required|escape:'javascript'}",
						maxlength: "{$messages.tpl.profile.email_maxlength|escape:'javascript'}",
						email: "{$messages.tpl.profile.email_invalid|escape:'javascript'}"
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
			<div class="span8 offset2">
<form name="changepwdform" id="changepwdform" action="profile.php" method="POST" class="well form-horizontal">
	<input type="hidden" name="action" value="changepwd">
	<fieldset>
		<legend>{$messages.tpl.profile.change_password}</legend>
		<div class="control-group">
			<label class="control-label" for="newpwd">{$messages.tpl.profile.new_password}</label>
			<div class="controls">
				<input type="password" id="newpwd" name="newpwd" class="input-xlarge">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="confpwd">{$messages.tpl.profile.confirm_password}</label>
			<div class="controls">
				<input type="password" id="confpwd" name="confpwd" class="input-xlarge">
			</div>
		</div>
		<div class="form-actions">
			<button type="submit" class="btn btn-primary">{$messages.tpl.profile.change_password}</button>
			<button type="button" class="btn" onclick="document.location.href='index.php';">{$messages.tpl.common.cancel}</button>
		</div>
	</fieldset>
</form>
			</div>
		</div>
		<div class="row">
			<div class="span8 offset2">
<form name="profileform" id="profileform" action="profile.php" method="POST" class="well form-horizontal">
	<input type="hidden" name="action" value="save">
	<fieldset>
		<legend>{$messages.tpl.profile.update_profile}</legend>
		<div class="control-group">
			<label class="control-label" for="fullname">{$messages.tpl.profile.fullname}</label>
			<div class="controls">
				<input type="text" id="fullname" name="fullname" class="input-xlarge" value="{$fullname|escape:'htmlall'}">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="email">{$messages.tpl.profile.email}</label>
			<div class="controls">
				<input type="text" id="email" name="email" class="input-xlarge" value="{$email|escape:'htmlall'}">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="email_msgs">{$messages.tpl.profile.copy_msg}</label>
			<div class="controls">
				<input type="checkbox" id="email_msgs" name="email_msgs" {if $email_msgs}CHECKED{/if}>
				{$messages.tpl.profile.email_copy}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="comment">{$messages.tpl.profile.comments}</label>
			<div class="controls">
				<textarea id="comment" name="comment" rows="5" cols="40">{$comment|escape:'htmlall'}</textarea>
			</div>
		</div>
		<div class="form-actions">
			<button type="submit" class="btn btn-primary">{$messages.tpl.profile.update_profile}</button>
			<button type="button" class="btn" onclick="document.location.href='index.php';">{$messages.tpl.common.cancel}</button>
		</div>
	</fieldset>
</form>
		</div>
	</div>
</div>
</body>
</html>

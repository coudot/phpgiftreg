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
	<title>{$messages.tpl.signup.title}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script src="js/giftreg.js"></script>

	<script language="JavaScript" type="text/javascript">
		$(document).ready(function() {
			$("#signupform").validate({
				highlight: validate_highlight,
				success: validate_success,
				rules: {
					username: {
						required: true,
						maxlength: 20
					},
					fullname: {
						required: true,
						maxlength: 50
					},
					email: {
						required: true,
						email: true,
						maxlength: 255
					},
					familyid: {
						required: true
					}
				},
				messages: {
					username: {
						required: "{$messages.tpl.signup.username_required|escape:'javascript'}",
						maxlength: "{$messages.tpl.signup.username_maxlength|escape:'javascript'}"
					},
					fullname: {
						required: "{$messages.tpl.signup.fullname_required|escape:'javascript'}",
						maxlength: "{$messages.tpl.signup.fullname_maxlength|escape:'javascript'}"
					},
					email: "{$messages.tpl.signup.email_required|escape:'javascript'}",
					familyid: "{$messages.tpl.signup.family_required|escape:'javascript'}"
				}
			});
		});
	</script>
</head>
<body>
	<div class="container" style="padding-top: 30px;">
		{if isset($error)}
			<div class="row">
				<div class="span8 offset2">
					<div class="alert alert-block">{$error|escape:'htmlall'}</div>
				</div>
			</div>
		{/if}
		{if isset($action) && $action == "signup" && !isset($error)}
			<div class="row">
				<div class="span8 offset2">
					<div class="well">
						<p>{$messages.tpl.signup.success}</p>
						{if $opt.newuser_requires_approval}
							<p>{$messages.tpl.signup.approval_notice}</p>
						{else}
							<p>{$messages.tpl.signup.password_notice}</p>
						{/if}
						<p>{$messages.tpl.signup.login_link}</p>
					</div>
				</div>
			</div>
		{else}
			<div class="row">
				<div class="span8 offset2">
					<div class="alert alert-info">
						<p>{$messages.tpl.signup.intro}</p>
						{if $opt.newuser_requires_approval}
							<p>{$messages.tpl.signup.approval_help}</p>
							<p>{$messages.tpl.signup.decision_help}</p>
						{else}
							<p>{$messages.tpl.signup.password_help}</p>
						{/if}
					</div>
				</div>
			</div>

			<div class="row">
				<div class="span8 offset2">
					<form name="signupform" id="signupform" method="post" action="signup.php" class="well form-horizontal">	
						<input type="hidden" name="action" value="signup">
						<fieldset>
							<legend>{$messages.tpl.signup.legend}</legend>
							<div class="control-group">
								<label class="control-label" for="username">{$messages.tpl.signup.username}</label>
								<div class="controls">
									<input id="username" name="username" type="text" class="input-xlarge" value="{$username|escape:'htmlall'}" placeholder="{$messages.tpl.signup.username|escape:'htmlall'}">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="fullname">{$messages.tpl.signup.fullname}</label>
								<div class="controls">
									<input id="fullname" name="fullname" type="text" class="input-xlarge" value="{$fullname|escape:'htmlall'}" placeholder="{$messages.tpl.signup.fullname|escape:'htmlall'}">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="email">{$messages.tpl.signup.email}</label>
								<div class="controls">
									<input id="email" name="email" type="text" class="input-xlarge" value="{$email|escape:'htmlall'}" placeholder="{$messages.tpl.signup.email_placeholder|escape:'htmlall'}">
								</div>
							</div>
							{if $familycount > 1}
								<div class="control-group">
									<label class="control-label" for="familyid">{$messages.tpl.signup.family}</label>
									<div class="controls">
										<select name="familyid">
											<option value="">{$messages.tpl.signup.select_family}</option>
											{foreach from=$families item=row}
												<option value="{$row.familyid}">{$row.familyname|escape:'htmlall'}</option>
											{/foreach}
										</select>
									</div>
								</div>
							{else}
								<input type="hidden" name="familyid" value="{$familyid}">
							{/if}
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">{$messages.tpl.common.submit}</button>
								<button type="button" class="btn" onClick="document.location.href='login.php';">{$messages.tpl.common.cancel}</button>
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		{/if}
	</div>
</body>
</html>

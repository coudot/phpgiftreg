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
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.bundle.min.js"></script>
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
				<div class="col-md-8 offset-md-2">
					<div class="alert alert-info">{$error|escape:'htmlall'}</div>
				</div>
			</div>
		{/if}
		{if isset($action) && $action == "signup" && !isset($error)}
			<div class="row">
				<div class="col-md-8 offset-md-2">
					<div class="card p-3">
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
				<div class="col-md-8 offset-md-2">
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
				<div class="col-md-8 offset-md-2">
					<form name="signupform" id="signupform" method="post" action="signup.php" class="card p-3">
						<input type="hidden" name="action" value="signup">
						<fieldset>
							<legend>{$messages.tpl.signup.legend}</legend>
							<div class="row mb-3">
								<label class="col-sm-3 col-form-label" for="username">{$messages.tpl.signup.username}</label>
								<div class="col-sm-9">
									<input id="username" name="username" type="text" class="form-control" value="{$username|escape:'htmlall'}" placeholder="{$messages.tpl.signup.username|escape:'htmlall'}">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-3 col-form-label" for="fullname">{$messages.tpl.signup.fullname}</label>
								<div class="col-sm-9">
									<input id="fullname" name="fullname" type="text" class="form-control" value="{$fullname|escape:'htmlall'}" placeholder="{$messages.tpl.signup.fullname|escape:'htmlall'}">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-3 col-form-label" for="email">{$messages.tpl.signup.email}</label>
								<div class="col-sm-9">
									<input id="email" name="email" type="text" class="form-control" value="{$email|escape:'htmlall'}" placeholder="{$messages.tpl.signup.email_placeholder|escape:'htmlall'}">
								</div>
							</div>
							{if $familycount > 1}
								<div class="row mb-3">
									<label class="col-sm-3 col-form-label" for="familyid">{$messages.tpl.signup.family}</label>
									<div class="col-sm-9">
										<select class="form-select" name="familyid">
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

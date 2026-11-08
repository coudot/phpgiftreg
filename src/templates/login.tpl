{*
This program is free software; you can redistribute it and/or modify
t under the terms of the GNU General Public License as published by
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
	<title>{$messages.tpl.login.title}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script src="js/giftreg.js"></script>

	<script language="JavaScript" type="text/javascript">
		$(document).ready(function() {
			$("#loginform").validate({
				highlight: validate_highlight,
				success: validate_success,
				rules: {
					username: {
						required: true
					},
					password: {
						required: true
					}
				},
				messages: {
					username: {
						required: "{$messages.tpl.login.username_required|escape:'javascript'}"
					},
					password: {
						required: "{$messages.tpl.login.password_required|escape:'javascript'}"
					}
				}
			});
		});
	</script>
</head>
<body>
	<div class="container" style="padding-top: 30px;">
		<div class="row">
			<div class="col-md-8 offset-md-2">
			<h1>{$messages.tpl.gift_registry}</h1>
		<form name="loginform" id="loginform" method="post" action="login.php" class="card p-3">
			<fieldset>
				{if isset($username)}
					<div class="alert alert-danger">{$messages.tpl.login.bad_login}</div>
				{/if}
				<div class="row mb-3">
					<label class="col-sm-3 col-form-label" for="username">{$messages.tpl.login.username}</label>
					<div class="col-sm-9">
						<input id="username" name="username" type="text" class="form-control" placeholder="{$messages.tpl.login.username|escape:'htmlall'}" />
					</div>
				</div>
				<div class="row mb-3">
					<label class="col-sm-3 col-form-label" for="password">{$messages.tpl.login.password}</label>
					<div class="col-sm-9">
						<input id="password" name="password" type="password" class="form-control" placeholder="{$messages.tpl.login.password|escape:'htmlall'}" />
					</div>
				</div>
				<div class="d-flex gap-2">
					<button type="submit" class="btn btn-primary">{$messages.tpl.login.login}</button>
				</div>
			</fieldset>
		</form>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 offset-md-2">
				<div class="card p-3">
					<a href="signup.php">{$messages.tpl.login.need_account}</a>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card p-3">
					<a href="forgot.php">{$messages.tpl.login.forgot_password}</a>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-8 offset-md-2" style="text-align: right;">
				<a href="//sourceforge.net/projects/phpgiftreg">{$messages.tpl.login.version}</a>
			</div>
		</div>
	</div>
</body>
</html>

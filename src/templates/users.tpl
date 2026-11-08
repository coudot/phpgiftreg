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
	<title>{$messages.tpl.users.title}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script src="js/giftreg.js"></script>
	
	<script language="JavaScript" type="text/javascript">
		$(document).ready(function() {
			$('a[rel=confirmdeleteuser]').click(function(event) {
				var u = $(this).attr('data-content');
				if (!window.confirm('{$messages.tpl.users.delete_confirm|escape:'javascript'}' + u + '?')) {
					event.preventDefault();
				}
			});

			$("#theform").validate({
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
						maxlength: 255,
						email: true
					}
				},
				messages: {
					username: {
						required: "{$messages.tpl.users.username_required|escape:'javascript'}",
						maxlength: "{$messages.tpl.users.username_maxlength|escape:'javascript'}"
					},
					fullname: {
						required: "{$messages.tpl.users.fullname_required|escape:'javascript'}",
						maxlength: "{$messages.tpl.users.fullname_maxlength|escape:'javascript'}"
					},
					email: {
						required: "{$messages.tpl.users.email_required|escape:'javascript'}",
						maxlength: "{$messages.tpl.users.email_maxlength|escape:'javascript'}",
						email: "{$messages.tpl.users.email_invalid|escape:'javascript'}"
					}
				}
			});
		});
	</script>
</head>
<body>
	{include file='navbar.tpl' isadmin=$isadmin}

	<div class="container" style="padding-top: 60px;">
		
		{if isset($message)}
			<div class="row">
				<div class="span12">
    				<div class="alert alert-block">{$message|escape:'htmlall'}</div>
				</div>
			</div>
		{/if}

		<div class="row">
			<div class="span12">
				<div class="well">
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>{$messages.tpl.users.username}</th>
								<th>{$messages.tpl.users.fullname}</th>
								<th>{$messages.tpl.users.email}</th>
								<th>{$messages.tpl.users.email_messages_question}</th>
								<th>{$messages.tpl.users.approved_question}</th>
								<th>{$messages.tpl.users.admin_question}</th>
								<th>&nbsp;</th>
							</tr>
						</thead>
						<tbody>
							{foreach from=$users item=row}
								<tr>
									<td>{$row.username}</td>
									<td>{$row.fullname}</td>
									<td>{$row.email}</td>
									<td>{if $row.email_msgs}{$messages.tpl.users.yes}{else}{$messages.tpl.users.no}{/if}</td>
									<td>{if $row.approved}{$messages.tpl.users.yes}{else}{$messages.tpl.users.no}{/if}</td>
									<td>{if $row.admin}{$messages.tpl.users.yes}{else}{$messages.tpl.users.no}{/if}</td>
									<td align="right">
										<a href="users.php?action=edit&userid={$row.userid}#userform"><img alt="{$messages.tpl.users.edit|escape:'htmlall'}" src="images/pencil.png" border="0" title="{$messages.tpl.users.edit|escape:'htmlall'}" /></a>
										<a rel="confirmdeleteuser" data-content="{$row.fullname|escape:'htmlall'}" href="users.php?action=delete&userid={$row.userid}"><img alt="{$messages.tpl.users.delete|escape:'htmlall'}" src="images/bin.png" border="0" title="{$messages.tpl.users.delete|escape:'htmlall'}" /></a>
										{if $row.email != ''}
											<a href="users.php?action=reset&userid={$row.userid}&email={$row.email|escape:'htmlall'}"><img alt="{$messages.tpl.users.reset_password|escape:'htmlall'}" src="images/key.png" border="0" title="{$messages.tpl.users.reset_password|escape:'htmlall'}" /></a>
										{else}
											{$messages.tpl.users.reset_short}
										{/if}
									</td>
								</tr>
							{/foreach}
						</tbody>
					</table>
					<h5><a href="users.php">{$messages.tpl.users.add_link}</a></h5>
				</div>
			</div>
		</div>

		<a name="userform">
		<div class="row">
			<div class="span12">
				<form name="theform" id="theform" method="get" action="users.php" class="well form-horizontal">	
					{if $action == "edit" || (isset($haserror) && $action == "update")}
						<input type="hidden" name="userid" value="{$edituserid}">
						<input type="hidden" name="action" value="update">
					{else if $action == "" || (isset($haserror) && $action == "insert")}
						<input type="hidden" name="action" value="insert">
					{/if}
					<fieldset>
						<legend>{if $action == "edit" || $action == "update"}{$messages.tpl.users.edit}{else}{$messages.tpl.users.add_legend}{/if}</legend>
						<div class="control-group {if isset($username_error)}warning{/if}">
							<label class="control-label" for="username">{$messages.tpl.users.username}</label>
							<div class="controls">
								<input id="username" name="username" type="text" class="input-xlarge" value="{$username|escape:'htmlall'}" maxlength="255">
								{if isset($username_error)}
									<span class="help-inline">{$username_error|escape:'htmlall'}</span>
								{/if}
							</div>
						</div>
						<div class="control-group {if isset($fullname_error)}warning{/if}">
							<label class="control-label" for="fullname">{$messages.tpl.users.fullname}</label>
							<div class="controls">
								<input id="fullname" name="fullname" type="text" class="input-xlarge" value="{$fullname|escape:'htmlall'}" maxlength="255">
								{if isset($fullname_error)}
									<span class="help-inline">{$fullname_error|escape:'htmlall'}</span>
								{/if}
							</div>
						</div>
						<div class="control-group {if isset($email_error)}warning{/if}">
							<label class="control-label" for="email">{$messages.tpl.users.email}</label>
							<div class="controls">
								<input id="email" name="email" type="text" class="input-xlarge" value="{$email|escape:'htmlall'}" maxlength="255">
								{if isset($email_error)}
									<span class="help-inline">{$email_error|escape:'htmlall'}</span>
								{/if}
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">{$messages.tpl.users.flags}</label>
							<div class="controls">
								<input type="checkbox" name="email_msgs" {if $email_msgs}CHECKED{/if}>
								{$messages.tpl.users.email_messages}
								<input type="checkbox" name="approved" {if $approved}CHECKED{/if}>
								{$messages.tpl.users.approved}
								<input type="checkbox" name="admin" {if $userisadmin}CHECKED{/if}>
								{$messages.tpl.users.administrator}
							</div>
						</div>
						<div class="form-actions">
							<button type="submit" class="btn btn-primary">{if $action == "" || $action == "insert"}{$messages.tpl.common.add}{else}{$messages.tpl.common.update}{/if}</button>
							<button type="button" class="btn" onClick="document.location.href='users.php';">{$messages.tpl.common.cancel}</button>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</body>
</html>

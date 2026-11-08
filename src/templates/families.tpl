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
	<title>{$messages.tpl.families.title}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script src="js/giftreg.js"></script>

	<script language="JavaScript" type="text/javascript">
		$(document).ready(function() {
			$("#theform").validate({
				highlight: validate_highlight,
				success: validate_success,
				rules: {
					familyname: {
						required: true,
						maxlength: 255
					}
				},
				messages: {
					familyname: {
						required: "{$messages.tpl.families.required|escape:'javascript'}",
						maxlength: "{$messages.tpl.families.maxlength|escape:'javascript'}"
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

		{if $opt.show_helptext}
			<div class="row">
				<div class="span12">
					<div class="alert alert-info">
						{$messages.tpl.families.help}
						{$messages.tpl.families.help_edit}
					</div>
				</div>
			</div>
		{/if}

		<div class="row">
			<div class="span12">
				<div class="well">
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>{$messages.tpl.families.family}</th>
								<th>{$messages.tpl.families.member_count}</th>
								<th>&nbsp;</th>
							</tr>
						</thead>
						<tbody>
							{foreach from=$families item=row}
								<tr>
									<td>{$row.familyname|escape:'htmlall'}</td>
									<td>{$row.members}</td>
									<td>
										<a href="families.php?action=edit&familyid={$row.familyid}#familyform"><img src="images/pencil.png" alt="{$messages.tpl.families.edit|escape:'htmlall'}" title="{$messages.tpl.families.edit|escape:'htmlall'}" border="0" /></a>
										<a href="families.php?action=delete&familyid={$row.familyid}"><img src="images/bin.png" alt="{$messages.tpl.families.delete|escape:'htmlall'}" title="{$messages.tpl.families.delete|escape:'htmlall'}" border="0" /></a>
									</td>
								</tr>
							{/foreach}
						</tbody>
					</table>
					<h5><a href="families.php">{$messages.tpl.families.add_link}</a></h5>
				</div>
			</div>
		</div>

		<a name="familyform">
		<div class="row">
			<div class="span6">
				<form name="theform" id="theform" method="get" action="families.php" class="well form-horizontal">	
					{if $action == "edit" || (isset($haserror) && $action == "update")}
						<input type="hidden" name="familyid" value="{$familyid}">
						<input type="hidden" name="action" value="update">
					{elseif $action == "" || (isset($haserror) && $action == "insert")}
						<input type="hidden" name="action" value="insert">
					{/if}
					<fieldset>
						<legend>{if $action == "edit" || $action == "update"}{$messages.tpl.families.edit_legend|replace:'%s':$familyname|escape:'htmlall'}{else}{$messages.tpl.families.add_legend}{/if}</legend>
						<div class="control-group {if isset($familyname_error)}warning{/if}">
							<label class="control-label" for="familyname">{$messages.tpl.families.field}</label>
							<div class="controls">
								<input id="familyname" name="familyname" type="text" class="input-xlarge" value="{$familyname|escape:'htmlall'}" maxlength="255">
								{if isset($familyname_error)}
									<span class="help-inline">{$familyname_error|escape:'htmlall'}</span>
								{/if}
							</div>
						</div>
						<div class="form-actions">
							<button type="submit" class="btn btn-primary">{if $action == "" || $action == "insert" || $action == "update"}{$messages.tpl.common.add}{else}{$messages.tpl.common.update}{/if}</button>
							<button type="button" class="btn" onClick="document.location.href='families.php';">{$messages.tpl.common.cancel}</button>
						</div>
					</fieldset>
				</form>
			</div>

			{if $action == "edit"}
				<div class="span6">
					<form name="membership" method="get" action="families.php" class="well form-horizontal">	
						<input type="hidden" name="familyid" value="{$familyid}">
						<input type="hidden" name="action" value="members">
						<fieldset>
							<legend>{$messages.tpl.families.members_legend|replace:'%s':$familyname|escape:'htmlall'}</legend>
							<div class="control-group">
								<label class="control-label" for="members[]">{$messages.tpl.families.members}</label>
								<div class="controls">
									<select name="members[]" size="10" multiple>
										{foreach from=$nonmembers item=row}
											<option value="{$row.userid}" {if $row.familyid != ''}SELECTED{/if}>{$row.fullname|escape:'htmlall'}</option>
										{/foreach}
									</select>
									<p class="help-block">{$messages.tpl.families.select_help}</p>
								</div>
							</div>
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">{$messages.tpl.common.save}</button>
								<button type="button" class="btn" onClick="document.location.href='families.php';">{$messages.tpl.common.cancel}</button>
							</div>
						</fieldset>
					</form>
				</div>
			{/if}

		</div>
	</div>
</body>
</html>

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
	<title>{$messages.tpl.ranks.title}</title>
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
					title: {
						required: true,
						maxlength: 50
					},
					rendered: {
						required: true,
						maxlength: 255
					}
				},
				messages: {
					title: {
						required: "{$messages.tpl.ranks.title_required|escape:'javascript'}",
						maxlength: "{$messages.tpl.ranks.title_maxlength|escape:'javascript'}"
					},
					rendered: {
						required: "{$messages.tpl.ranks.html_required|escape:'javascript'}",
						maxlength: "{$messages.tpl.ranks.html_maxlength|escape:'javascript'}"
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
					<h3>{$messages.tpl.ranks.heading}</h3>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>{$messages.tpl.ranks.title_label}</th>
								<th>{$messages.tpl.ranks.html_label}</th>
								<th>{$messages.tpl.ranks.order}</th>
							</tr>
						</thead>
						<tbody>
							{foreach from=$ranks item=row}
								<tr>
									<td>{$row.title|escape:'htmlall'}</td>
									<td>{$row.rendered}</td>
									<td>{$row.rankorder}</td>
									<td>
										<a href="ranks.php?action=edit&ranking={$row.ranking}#rankform"><img src="images/pencil.png" border="0" alt="{$messages.tpl.ranks.edit|escape:'htmlall'}" title="{$messages.tpl.ranks.edit|escape:'htmlall'}" /></a>
										<a href="ranks.php?action=delete&ranking={$row.ranking}"><img src="images/bin.png" border="0" alt="{$messages.tpl.ranks.delete|escape:'htmlall'}" title="{$messages.tpl.ranks.delete|escape:'htmlall'}" /></a>
										<a href="ranks.php?action=promote&ranking={$row.ranking}&rankorder={$row.rankorder}"><img src="images/arrow-up.png" border="0" alt="{$messages.tpl.ranks.promote|escape:'htmlall'}" title="{$messages.tpl.ranks.promote|escape:'htmlall'}" /></a>
										<a href="ranks.php?action=demote&ranking={$row.ranking}&rankorder={$row.rankorder}"><img src="images/arrow-down.png" border="0" alt="{$messages.tpl.ranks.demote|escape:'htmlall'}" title="{$messages.tpl.ranks.demote|escape:'htmlall'}" /></a>
									</td>
								</tr>
							{/foreach}
						</tbody>
					</table>
					<h5><a href="ranks.php#rankform">{$messages.tpl.ranks.add_link}</a></h5>
				</div>
			</div>
		</div>

		<a name="rankform">
		<div class="row">
			<div class="span12">
				<form name="theform" id="theform" method="get" action="ranks.php" class="well form-horizontal">	
					{if $action == "edit" || (isset($haserror) && $action == "update")}
						<input type="hidden" name="ranking" value="{$ranking}">
						<input type="hidden" name="action" value="update">
					{elseif $action == "" || (isset($haserror) && $action == "insert")}
						<input type="hidden" name="action" value="insert">
					{/if}
					<fieldset>
						<legend>{if $action == "edit"}{$messages.tpl.ranks.edit_legend|replace:'%s':$title|escape:'htmlall'}{else}{$messages.tpl.ranks.add_legend}{/if}</legend>
						<div class="control-group {if isset($title_error)}warning{/if}">
							<label class="control-label" for="title">{$messages.tpl.ranks.title_label}</label>
							<div class="controls">
								<input id="title" name="title" class="input-xlarge" type="text" value="{$title|escape:'htmlall'}" maxlength="255">
								{if isset($title_error)}
									<span class="help-inline">{$title_error|escape:'htmlall'}</span>
								{/if}
							</div>
						</div>
						<div class="control-group {if isset($rendered_error)}warning{/if}">
							<label class="control-label" for="rendered">{$messages.tpl.ranks.html}</label>
							<div class="controls">
								<textarea id="rendered" name="rendered" class="input-xlarge" rows="4" cols="40">{$rendered|escape:'htmlall'}</textarea>
								{if isset($rendered_error)}
									<span class="help-inline">{$rendered_error|escape:'htmlall'}</span>
								{/if}
							</div>
						</div>
						<div class="form-actions">
							<button type="submit" class="btn btn-primary">{if $action == "" || $action == "insert"}{$messages.tpl.common.add}{else}{$messages.tpl.common.update}{/if}</button>
							<button type="button" class="btn" onClick="document.location.href='ranks.php';">{$messages.tpl.common.cancel}</button>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</body>
</html>

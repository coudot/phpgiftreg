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
	<title>{$messages.tpl.event.title}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<link href="datepicker/css/datepicker.css" rel="stylesheet">
	<script src="datepicker/js/bootstrap-datepicker.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script src="js/giftreg.js"></script>

	<script language="JavaScript" type="text/javascript">
		$(document).ready(function() {
			$('#eventdate').datepicker({
				format: '{$messages.datepicker.format}',
				weekStart: {$messages.datepicker.weekStart},
				dates: {$datepicker_json}
			});

			$('#eventform').validate({
				highlight: validate_highlight,
				success: validate_success,
				rules: {
					description: {
						required: true,
						maxlength: 255
					},
					eventdate: {
						required: true,
						"date": true
					}
				},
				messages: {
					description: {
						required: "{$messages.tpl.event.description_required|escape:'javascript'}",
						maxlength: "{$messages.tpl.event.description_maxlength|escape:'javascript'}"
					},
					eventdate: {
						required: "{$messages.tpl.event.date_required|escape:'javascript'}",
						"date": "{$messages.tpl.event.date_invalid|replace:'%s':$messages.tpl.event.date_format|escape:'javascript'}"
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
    			<div class="alert alert-block">
					{$message|escape:'htmlall'}
				</div>
			</div>
		</div>
	{/if}
	{if $opt.show_helptext}
		<div class="row">
			<div class="span12">
				<div class="alert alert-info">
					{$messages.tpl.event.help|replace:'%s':$opt.event_threshold}
					{if $isadmin}
						{$messages.tpl.event.system_help}
					{/if}
					{$messages.tpl.event.recurring_help}
				</div>
			</div>
		</div>
	{/if}
	<div class="row">
		<div class="span12">
			<div class="well">
				<h1>{$messages.tpl.event.heading}</h1>
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th>{$messages.tpl.event.date}</th>
							<th>{$messages.tpl.event.description}</th>
							<th>{$messages.tpl.event.recurring_question}</th>
							{if $isadmin}
								<th>{$messages.tpl.event.system_question}</th>
							{/if}
							<th>&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						{foreach from=$events item=row}
							<tr>
								<td>{$row.eventdate}</td>
								<td>{$row.description|escape:'htmlall'}</td>
								<td>{if $row.recurring}{$messages.tpl.event.yes}{else}{$messages.tpl.event.no}{/if}</td>
								{if $isadmin}
									<td>
										{if $row.userid == ''}{$messages.tpl.event.yes}{else}{$messages.tpl.event.no}{/if}
									</td>
								{/if}
								<td>
									<a href="event.php?action=edit&eventid={$row.eventid}"><img alt="{$messages.tpl.event.edit|escape:'htmlall'}" src="images/pencil.png" border="0" title="{$messages.tpl.event.edit|escape:'htmlall'}" /></a>&nbsp;<a href="event.php?action=delete&eventid={$row.eventid}"><img alt="{$messages.tpl.event.delete|escape:'htmlall'}" src="images/bin.png" border="0" title="{$messages.tpl.event.delete|escape:'htmlall'}" /></a>
								</td>
							</tr>
						{/foreach}
					</tbody>
				</table>
				<h5><a href="event.php">{$messages.tpl.event.add_link}</a></h5>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="span8 offset2">
			<form name="eventform" id="eventform" method="get" action="event.php" class="well form-horizontal">
				<fieldset>
					<legend>{$messages.tpl.event.details}</legend>
					{if $action == "edit" || (isset($haserror) && $action == "update")}
						<input type="hidden" name="eventid" value="{$eventid}">
						<input type="hidden" name="action" value="update">
					{elseif $action == "" || (isset($haserror) && $action == "insert")}
						<input type="hidden" name="action" value="insert">
					{/if}
					<div class="control-group {if isset($description_error)}warning{/if}">
						<label class="control-label" for="description">{$messages.tpl.event.description}</label>
						<div class="controls">
							<input id="description" name="description" type="text" value="{$description|escape:'htmlall'}" class="input-xlarge" maxlength="255" placeholder="{$messages.tpl.event.description|escape:'htmlall'}">
							{if isset($description_error)}
								<span class="help-inline">{$description_error}</span>
							{/if}
						</div>
					</div>
					<div class="control-group {if isset($eventdate_error)}warning{/if}">
						<label class="control-label" for="eventdate">{$messages.tpl.event.date}</label>
						<div class="controls">
							<input id="eventdate" name="eventdate" type="text" value="{$eventdate|escape:'htmlall'}" class="input-xlarge" placeholder="{$messages.tpl.event.date_format|escape:'htmlall'}" data-date-format="{$messages.datepicker.format}">
							<p class="help-block">{$messages.tpl.event.date_format}</p>
							{if isset($eventdate_error)}
								<span class="help-inline">{$eventdate_error}</span>
							{/if}
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="recurring">{$messages.tpl.event.recurring}</label>
						<div class="controls">
							<input type="checkbox" name="recurring" {if $recurring}CHECKED{/if}>
							{$messages.tpl.event.recurring_yearly}
						</div>
					</div>
					{if $isadmin}
						<div class="control-group">
							<label class="control-label" for="systemevent">{$messages.tpl.event.system_event}</label>
							<div class="controls">
								<input type="checkbox" name="systemevent" {if $systemevent}CHECKED{/if}>
								{$messages.tpl.event.system_event}
							</div>
						</div>
					{/if}
					<div class="form-actions">
						<button type="submit" class="btn btn-primary">{if $action == "" || $action == "insert"}{$messages.tpl.common.add}{else}{$messages.tpl.common.update}{/if}</button>
						<button type="button" class="btn" onClick="document.location.href='event.php';">{$messages.tpl.common.cancel}</button>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</div>
</body>
</html>

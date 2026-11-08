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
<html lang="fr">
<head>
	<title>Liste de cadeaux - Gérer les événements</title>
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
						required: "La description de l'événement est obligatoire.",
						maxlength: "La description ne doit pas dépasser 255 caractères."
					},
					eventdate: {
						required: "La date de l'événement est obligatoire.",
						"date": "La date doit respecter le format jj/mm/aaaa."
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
					Vous pouvez définir vos propres événements, comme votre anniversaire. Lorsqu'un événement se produit dans les {$opt.event_threshold} prochains jours, un rappel s'affichera pour toutes les personnes qui font des achats pour vous.
					{if $isadmin}
						<strong>Les événements système</strong> n'appartiennent à personne, comme Noël, et s'affichent pour tout le monde.
					{/if}
					Les événements marqués comme <strong>annuels</strong> s'afficheront chaque année.
				</div>
			</div>
		</div>
	{/if}
	<div class="row">
		<div class="span12">
			<div class="well">
				<h1>Événements</h1>
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th>Date de l'événement</th>
							<th>Description</th>
							<th>Récurrent ?</th>
							{if $isadmin}
								<th>Événement système ?</th>
							{/if}
							<th>&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						{foreach from=$events item=row}
							<tr>
								<td>{$row.eventdate}</td>
								<td>{$row.description|escape:'htmlall'}</td>
								<td>{if $row.recurring}Oui{else}Non{/if}</td>
								{if $isadmin}
									<td>
										{if $row.userid == ''}Oui{else}Non{/if}
									</td>
								{/if}
								<td>
									<a href="event.php?action=edit&eventid={$row.eventid}"><img alt="Modifier l'événement" src="images/pencil.png" border="0" title="Modifier l'événement" /></a>&nbsp;<a href="event.php?action=delete&eventid={$row.eventid}"><img alt="Supprimer l'événement" src="images/bin.png" border="0" title="Supprimer l'événement" /></a>
								</td>
							</tr>
						{/foreach}
					</tbody>
				</table>
				<h5><a href="event.php">Ajouter un événement</a></h5>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="span8 offset2">
			<form name="eventform" id="eventform" method="get" action="event.php" class="well form-horizontal">
				<fieldset>
					<legend>Détails de l'événement</legend>
					{if $action == "edit" || (isset($haserror) && $action == "update")}
						<input type="hidden" name="eventid" value="{$eventid}">
						<input type="hidden" name="action" value="update">
					{elseif $action == "" || (isset($haserror) && $action == "insert")}
						<input type="hidden" name="action" value="insert">
					{/if}
					<div class="control-group {if isset($description_error)}warning{/if}">
						<label class="control-label" for="description">Description</label>
						<div class="controls">
							<input id="description" name="description" type="text" value="{$description|escape:'htmlall'}" class="input-xlarge" maxlength="255" placeholder="Description">
							{if isset($description_error)}
								<span class="help-inline">{$description_error}</span>
							{/if}
						</div>
					</div>
					<div class="control-group {if isset($eventdate_error)}warning{/if}">
						<label class="control-label" for="eventdate">Date de l'événement</label>
						<div class="controls">
							<input id="eventdate" name="eventdate" type="text" value="{$eventdate|escape:'htmlall'}" class="input-xlarge" placeholder="jj/mm/aaaa" data-date-format="dd/mm/yyyy">
							<p class="help-block">jj/mm/aaaa</p>
							{if isset($eventdate_error)}
								<span class="help-inline">{$eventdate_error}</span>
							{/if}
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="recurring">Récurrence</label>
						<div class="controls">
							<input type="checkbox" name="recurring" {if $recurring}CHECKED{/if}>
							Chaque année
						</div>
					</div>
					{if $isadmin}
						<div class="control-group">
							<label class="control-label" for="systemevent">Événement système</label>
							<div class="controls">
								<input type="checkbox" name="systemevent" {if $systemevent}CHECKED{/if}>
								Événement système
							</div>
						</div>
					{/if}
					<div class="form-actions">
						<button type="submit" class="btn btn-primary">{if $action == "" || $action == "insert"}Ajouter{else}Modifier{/if}</button>
						<button type="button" class="btn" onClick="document.location.href='event.php';">Annuler</button>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</div>
</body>
</html>

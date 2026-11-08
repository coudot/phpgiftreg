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
	<title>Liste de cadeaux - Gérer les niveaux</title>
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
						required: "Le titre est obligatoire.",
						maxlength: "Le titre ne doit pas dépasser 50 caractères."
					},
					rendered: {
						required: "Le code HTML est obligatoire.",
						maxlength: "Le code HTML ne doit pas dépasser 255 caractères."
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
					<h3>Niveaux</h3>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Titre</th>
								<th>Code HTML affiché</th>
								<th>Ordre</th>
							</tr>
						</thead>
						<tbody>
							{foreach from=$ranks item=row}
								<tr>
									<td>{$row.title|escape:'htmlall'}</td>
									<td>{$row.rendered}</td>
									<td>{$row.rankorder}</td>
									<td>
										<a href="ranks.php?action=edit&ranking={$row.ranking}#rankform"><img src="images/pencil.png" border="0" alt="Modifier le niveau" title="Modifier le niveau" /></a>
										<a href="ranks.php?action=delete&ranking={$row.ranking}"><img src="images/bin.png" border="0" alt="Supprimer le niveau" title="Supprimer le niveau" /></a>
										<a href="ranks.php?action=promote&ranking={$row.ranking}&rankorder={$row.rankorder}"><img src="images/arrow-up.png" border="0" alt="Monter" title="Monter" /></a>
										<a href="ranks.php?action=demote&ranking={$row.ranking}&rankorder={$row.rankorder}"><img src="images/arrow-down.png" border="0" alt="Descendre" title="Descendre" /></a>
									</td>
								</tr>
							{/foreach}
						</tbody>
					</table>
					<h5><a href="ranks.php#rankform">Ajouter un niveau</a></h5>
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
						<legend>{if $action == "edit"}Modifier le niveau « {$title} »{else}Ajouter un niveau{/if}</legend>
						<div class="control-group {if isset($title_error)}warning{/if}">
							<label class="control-label" for="title">Titre</label>
							<div class="controls">
								<input id="title" name="title" class="input-xlarge" type="text" value="{$title|escape:'htmlall'}" maxlength="255">
								{if isset($title_error)}
									<span class="help-inline">{$title_error|escape:'htmlall'}</span>
								{/if}
							</div>
						</div>
						<div class="control-group {if isset($rendered_error)}warning{/if}">
							<label class="control-label" for="rendered">HTML</label>
							<div class="controls">
								<textarea id="rendered" name="rendered" class="input-xlarge" rows="4" cols="40">{$rendered|escape:'htmlall'}</textarea>
								{if isset($rendered_error)}
									<span class="help-inline">{$rendered_error|escape:'htmlall'}</span>
								{/if}
							</div>
						</div>
						<div class="form-actions">
							<button type="submit" class="btn btn-primary">{if $action == "" || $action == "insert"}Ajouter{else}Modifier{/if}</button>
							<button type="button" class="btn" onClick="document.location.href='ranks.php';">Annuler</button>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</body>
</html>

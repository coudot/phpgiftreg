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
	<title>Liste de cadeaux - Gérer les utilisateurs</title>
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
				if (!window.confirm('Voulez-vous vraiment supprimer l’utilisateur ' + u + ' ?')) {
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
						required: "Le nom d'utilisateur est obligatoire.",
						maxlength: "Le nom d'utilisateur ne doit pas dépasser 20 caractères."
					},
					fullname: {
						required: "Le nom complet est obligatoire.",
						maxlength: "Le nom complet ne doit pas dépasser 50 caractères."
					},
					email: {
						required: "L'adresse courriel est obligatoire.",
						maxlength: "L'adresse courriel ne doit pas dépasser 255 caractères.",
						email: "L'adresse courriel n'est pas valide."
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
								<th>Nom d'utilisateur</th>
								<th>Nom complet</th>
								<th>Courriel</th>
								<th>Messages par courriel ?</th>
								<th>Approuvé ?</th>
								<th>Administrateur ?</th>
								<th>&nbsp;</th>
							</tr>
						</thead>
						<tbody>
							{foreach from=$users item=row}
								<tr>
									<td>{$row.username}</td>
									<td>{$row.fullname}</td>
									<td>{$row.email}</td>
									<td>{if $row.email_msgs}Oui{else}Non{/if}</td>
									<td>{if $row.approved}Oui{else}Non{/if}</td>
									<td>{if $row.admin}Oui{else}Non{/if}</td>
									<td align="right">
										<a href="users.php?action=edit&userid={$row.userid}#userform"><img alt="Modifier l'utilisateur" src="images/pencil.png" border="0" title="Modifier l'utilisateur" /></a>
										<a rel="confirmdeleteuser" data-content="{$row.fullname|escape:'htmlall'}" href="users.php?action=delete&userid={$row.userid}"><img alt="Supprimer l'utilisateur" src="images/bin.png" border="0" title="Supprimer l'utilisateur" /></a>
										{if $row.email != ''}
											<a href="users.php?action=reset&userid={$row.userid}&email={$row.email|escape:'htmlall'}"><img alt="Réinitialiser le mot de passe" src="images/key.png" border="0" title="Réinitialiser le mot de passe" /></a>
										{else}
											Réinitialiser
										{/if}
									</td>
								</tr>
							{/foreach}
						</tbody>
					</table>
					<h5><a href="users.php">Ajouter un utilisateur</a></h5>
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
						<legend>{if $action == "edit" || $action == "update"}Modifier l'utilisateur{else}Ajouter un utilisateur{/if}</legend>
						<div class="control-group {if isset($username_error)}warning{/if}">
							<label class="control-label" for="username">Nom d'utilisateur</label>
							<div class="controls">
								<input id="username" name="username" type="text" class="input-xlarge" value="{$username|escape:'htmlall'}" maxlength="255">
								{if isset($username_error)}
									<span class="help-inline">{$username_error|escape:'htmlall'}</span>
								{/if}
							</div>
						</div>
						<div class="control-group {if isset($fullname_error)}warning{/if}">
							<label class="control-label" for="fullname">Nom complet</label>
							<div class="controls">
								<input id="fullname" name="fullname" type="text" class="input-xlarge" value="{$fullname|escape:'htmlall'}" maxlength="255">
								{if isset($fullname_error)}
									<span class="help-inline">{$fullname_error|escape:'htmlall'}</span>
								{/if}
							</div>
						</div>
						<div class="control-group {if isset($email_error)}warning{/if}">
							<label class="control-label" for="email">Adresse courriel</label>
							<div class="controls">
								<input id="email" name="email" type="text" class="input-xlarge" value="{$email|escape:'htmlall'}" maxlength="255">
								{if isset($email_error)}
									<span class="help-inline">{$email_error|escape:'htmlall'}</span>
								{/if}
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Options</label>
							<div class="controls">
								<input type="checkbox" name="email_msgs" {if $email_msgs}CHECKED{/if}>
								Messages par courriel
								<input type="checkbox" name="approved" {if $approved}CHECKED{/if}>
								Approuvé
								<input type="checkbox" name="admin" {if $userisadmin}CHECKED{/if}>
								Administrateur
							</div>
						</div>
						<div class="form-actions">
							<button type="submit" class="btn btn-primary">{if $action == "" || $action == "insert"}Ajouter{else}Modifier{/if}</button>
							<button type="button" class="btn" onClick="document.location.href='users.php';">Annuler</button>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</body>
</html>

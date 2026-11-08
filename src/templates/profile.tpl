{*
This program is free software; you can redistribute it and/or modify
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
	<title>Liste de cadeaux - Modifier mon profil</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script src="js/giftreg.js"></script>

	<script language="JavaScript" type="text/javascript">
		$(document).ready(function() {
			$("#changepwdform").validate({
				highlight: validate_highlight,
				success: validate_success,
				rules: {
					newpwd: {
						required: true,
						maxlength: 50
					},
					confpwd: {
						required: true,
						maxlength: 50,
						equalTo: "#newpwd"
					}
				},
				messages: {
					newpwd: {
						required: "Le mot de passe est obligatoire.",
						maxlength: "Le mot de passe ne doit pas dépasser 50 caractères."
					},
					confpwd: {
						required: "La confirmation est obligatoire.",
						maxlength: "La confirmation ne doit pas dépasser 50 caractères.",
						equalTo: "Les mots de passe ne correspondent pas."
					}
				}
			});
			$("#profileform").validate({
				highlight: validate_highlight,
				success: validate_success,
				rules: {
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
		<div class="row">
			<div class="span8 offset2">
<form name="changepwdform" id="changepwdform" action="profile.php" method="POST" class="well form-horizontal">
	<input type="hidden" name="action" value="changepwd">
	<fieldset>
		<legend>Modifier le mot de passe</legend>
		<div class="control-group">
			<label class="control-label" for="newpwd">Nouveau mot de passe</label>
			<div class="controls">
				<input type="password" id="newpwd" name="newpwd" class="input-xlarge">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="confpwd">Confirmer le mot de passe</label>
			<div class="controls">
				<input type="password" id="confpwd" name="confpwd" class="input-xlarge">
			</div>
		</div>
		<div class="form-actions">
			<button type="submit" class="btn btn-primary">Modifier le mot de passe</button>
			<button type="button" class="btn" onclick="document.location.href='index.php';">Annuler</button>
		</div>
	</fieldset>
</form>
			</div>
		</div>
		<div class="row">
			<div class="span8 offset2">
<form name="profileform" id="profileform" action="profile.php" method="POST" class="well form-horizontal">
	<input type="hidden" name="action" value="save">
	<fieldset>
		<legend>Modifier mon profil</legend>
		<div class="control-group">
			<label class="control-label" for="fullname">Nom complet</label>
			<div class="controls">
				<input type="text" id="fullname" name="fullname" class="input-xlarge" value="{$fullname|escape:'htmlall'}">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="email">Adresse courriel</label>
			<div class="controls">
				<input type="text" id="email" name="email" class="input-xlarge" value="{$email|escape:'htmlall'}">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="email_msgs">Copie des messages</label>
			<div class="controls">
				<input type="checkbox" id="email_msgs" name="email_msgs" {if $email_msgs}CHECKED{/if}>
				Recevoir une copie de chaque message par courriel
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="comment">Commentaires, adresse de livraison, etc. (facultatif)</label>
			<div class="controls">
				<textarea id="comment" name="comment" rows="5" cols="40">{$comment|escape:'htmlall'}</textarea>
			</div>
		</div>
		<div class="form-actions">
			<button type="submit" class="btn btn-primary">Modifier le profil</button>
			<button type="button" class="btn" onclick="document.location.href='index.php';">Annuler</button>
		</div>
	</fieldset>
</form>
		</div>
	</div>
</div>
</body>
</html>

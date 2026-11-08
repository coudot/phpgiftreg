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
	<title>Liste de cadeaux - Inscription</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
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
						required: "Le nom d'utilisateur est obligatoire.",
						maxlength: "Le nom d'utilisateur ne doit pas dépasser 20 caractères."
					},
					fullname: {
						required: "Votre nom complet est obligatoire.",
						maxlength: "Votre nom complet ne doit pas dépasser 50 caractères."
					},
					email: "Une adresse courriel valide est obligatoire.",
					familyid: "Veuillez choisir une famille."
				}
			});
		});
	</script>
</head>
<body>
	<div class="container" style="padding-top: 30px;">
		{if isset($error)}
			<div class="row">
				<div class="span8 offset2">
					<div class="alert alert-block">{$error|escape:'htmlall'}</div>
				</div>
			</div>
		{/if}
		{if isset($action) && $action == "signup" && !isset($error)}
			<div class="row">
				<div class="span8 offset2">
					<div class="well">
						<p>Merci de vous être inscrit.</p>
						{if $opt.newuser_requires_approval}
							<p>Les administrateurs ont été informés de votre demande et vous recevrez un courriel dès qu'ils auront pris une décision.</p>
						{else}
							<p>Vous recevrez bientôt un courriel contenant votre mot de passe initial.</p>
						{/if}
						<p>Une fois votre mot de passe reçu, cliquez <a href="login.php">ici</a> pour vous connecter.</p>
					</div>
				</div>
			</div>
		{else}
			<div class="row">
				<div class="span8 offset2">
					<div class="alert alert-info">
						<p>Remplissez le formulaire ci-dessous et cliquez sur Envoyer.</p>
						{if $opt.newuser_requires_approval}
							<p>Les administrateurs de la liste seront informés de votre demande par courriel et l'approuveront ou la refuseront.
</p>
							<p>Si l'adresse courriel fournie est valide, vous serez informé lorsqu'une décision aura été prise.</p>
						{else}
							<p>Si l'adresse courriel fournie est valide, vous recevrez bientôt un courriel contenant votre mot de passe initial.</p>
						{/if}
					</div>
				</div>
			</div>

			<div class="row">
				<div class="span8 offset2">
					<form name="signupform" id="signupform" method="post" action="signup.php" class="well form-horizontal">	
						<input type="hidden" name="action" value="signup">
						<fieldset>
							<legend>Créer un compte</legend>
							<div class="control-group">
								<label class="control-label" for="username">Nom d'utilisateur</label>
								<div class="controls">
									<input id="username" name="username" type="text" class="input-xlarge" value="{$username|escape:'htmlall'}" placeholder="Nom d'utilisateur">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="fullname">Nom complet</label>
								<div class="controls">
									<input id="fullname" name="fullname" type="text" class="input-xlarge" value="{$fullname|escape:'htmlall'}" placeholder="Nom complet">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="email">Adresse courriel</label>
								<div class="controls">
									<input id="email" name="email" type="text" class="input-xlarge" value="{$email|escape:'htmlall'}" placeholder="you@somewhere.com">
								</div>
							</div>
							{if $familycount > 1}
								<div class="control-group">
									<label class="control-label" for="familyid">Famille</label>
									<div class="controls">
										<select name="familyid">
											<option value="">(choisissez une option)</option>
											{foreach from=$families item=row}
												<option value="{$row.familyid}">{$row.familyname|escape:'htmlall'}</option>
											{/foreach}
										</select>
									</div>
								</div>
							{else}
								<input type="hidden" name="familyid" value="{$familyid}">
							{/if}
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">Envoyer</button>
								<button type="button" class="btn" onClick="document.location.href='login.php';">Annuler</button>
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		{/if}
	</div>
</body>
</html>

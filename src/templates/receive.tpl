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
	<title>Liste de cadeaux - Réception d'un article</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script src="js/giftreg.js"></script>
	
	<script language="JavaScript" type="text/javascript">
		$(document).ready(function() {
			$("#receiverform").validate({
				highlight: validate_highlight,
				success: validate_success,
				rules: {
					buyer: {
						required: true
					},
					quantity: {
						required: true,
						digits: true,
						min: 1,
						max: {$quantity}
					}
				},
				messages: {
					buyer: {
						required: "Veuillez sélectionner un acheteur."
					},
					quantity: {
						required: "Veuillez saisir la quantité reçue.",
						digits: "La quantité doit être un nombre valide.",
						min: "La quantité doit être supérieure ou égale à 1.",
						max: "La quantité doit être inférieure ou égale à {$quantity}."
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
<form name="receiverform" id="receiverform" method="get" action="receive.php" class="well form-horizontal">
	<input type="hidden" name="action" value="receive">
	<input type="hidden" name="itemid" value="{$itemid}">
	<fieldset>
		<legend>Sélectionnez l'acheteur et la quantité</legend>
		<div class="control-group">
			<label class="control-label" for="buyer">Acheteur</label>
			<div class="controls">
				<select id="buyer" name="buyer" class="input-xlarge">
					<option value="">(sélectionnez un acheteur)</option>
					{foreach from=$buyers item=row}
						<option value="{$row.userid}">{$row.fullname|escape:'htmlall'}</option>
					{/foreach}
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="quantity">Quantité reçue (maximum : {$quantity})</label>
			<div class="controls">
				<input type="text" id="quantity" name="quantity" value="1" maxlength="3">
				<p class="help-block">Une fois tous les exemplaires d'un article reçus, celui-ci sera supprimé.</p>
			</div>
		</div>
		<div class="form-actions">
			<button type="submit" class="btn btn-primary">Confirmer la réception</button>
			<button type="button" class="btn" onClick="document.location.href='index.php';">Annuler</button>
		</div>
	</fieldset>
</form>
			</div>
		</div>
	</div>
</body>
</html>

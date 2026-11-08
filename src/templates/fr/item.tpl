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
	<title>Liste de cadeaux - Modifier un article</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script src="js/giftreg.js"></script>

	<script language="JavaScript" type="text/javascript">
		$(document).ready(function() {
			$("#imagefile").change(function() {
				$("#ifnew, #ifreplace").attr('CHECKED', 'CHECKED');	
			});

			$("#itemform").validate({
				highlight: validate_highlight,
				success: validate_success,
				rules: {
					description: {
						required: true,
						maxlength: 255
					},
					/*category: {
						required: true
					},*/
					price: {
						required: true,
						min: 0,
						"number": true
					},
					source: {
						required: true,
						maxlength: 255
					},
					ranking: {
						required: true
					},
					quantity: {
						required: true,
						digits: true,
						min: 1
					},
					url: {
						url: true
					}
				},
				messages: {
					description: {
						required: "La description de l'article est obligatoire.",
						maxlength: "La description de l'article ne doit pas dépasser 255 caractères."
					},
					/*category: {
						required: "Veuillez sélectionner une catégorie."
					},*/
					price: {
						required: "Le prix de l'article est obligatoire.",
						min: "Le prix ne peut pas être négatif.",
						"number": "Le prix doit être un nombre valide."
					},
					source: {
						required: "Le magasin où acheter l'article est obligatoire.",
						maxlength: "Le magasin ne doit pas dépasser 255 caractères."
					},
					ranking: {
						required: "Un niveau est obligatoire."
					},
					quantity: {
						required: "La quantité est obligatoire.",
						digits: "La quantité doit être un nombre entier valide.",
						min: "La quantité doit être supérieure ou égale à 1."
					},
					url: {
						url: "L'URL doit être valide."
					}
				}
			});
		});
	</script>
</head>
<body>
	{include file='navbar.tpl' isadmin=$isadmin}

	<div class="container" style="padding-top: 60px;">
	{if $opt.show_helptext}
		<div class="row">
			<div class="span12">
				<div class="alert alert-info">
		Conseils :
		<ul>
			<li>Copiez-collez l'URL depuis la barre d'adresse de votre navigateur afin que les acheteurs potentiels puissent voir précisément l'article souhaité.</li>
			<li>Si la description et l'URL ne suffisent pas à préciser l'article souhaité, utilisez le champ <strong>Commentaire</strong>. Cela n'oblige pas l'acheteur à acheter l'article sur ce site.</li>
			<li>Si vous ne connaissez pas le prix de l'article, saisissez simplement <strong>0</strong>.</li>
			<li>Évitez d'attribuer le même niveau à tous vos articles. Les acheteurs s'appuieront sur ce niveau pour connaître vos préférences. Si les niveaux ou leurs descriptions ne vous conviennent pas, demandez à un administrateur de les modifier ou d'en ajouter.</li>
			{if $opt.allow_multiples}
				<li>La quantité indique le nombre d'exemplaires souhaités. Une fois cette quantité achetée ou réservée, aucun autre exemplaire ne sera disponible. Si vous ne souhaitez pas fixer de limite, saisissez par exemple 999.</li>
			{/if}
		</ul>
				</div>
			</div>
		</div>
	{/if}
	<div class="row">
		<div class="span8 offset2">
			<form name="itemform" id="itemform" method="POST" action="item.php" enctype="multipart/form-data" class="well form-horizontal">
				<fieldset>
					<legend>{if $action == 'edit' || (isset($haserror) && $action == 'update')}Modifier un article{else}Ajouter un article{/if}</legend>
					{if $action == 'edit' || (isset($haserror) && $action == 'update')}
						<input type="hidden" name="itemid" value="{$itemid}">
						<input type="hidden" name="action" value="update">
					{elseif $action == "add" || (isset($haserror) && $action == 'insert')}
						<input type="hidden" name="action" value="insert">
					{/if}
					<div class="control-group {if isset($description_error)}warning{/if}">
						<label class="control-label" for="description">Description</label>
						<div class="controls">
							<input id="description" name="description" type="text" value="{$description|escape:'htmlall'}" class="input-xlarge" placeholder="Description" maxlength="255">
							{if isset($description_error)}
								<span class="help-inline">{$description_error}</span>
							{/if}
						</div>
					</div>
					<div class="control-group {if isset($category_error)}warning{/if}">
						<label class="control-label" for="category">Catégorie</label>
						<div class="controls">
							<select id="category" name="category" class="input-xlarge">
								<option value="" {if $category == NULL}SELECTED{/if}>Sans catégorie</option>
								{foreach from=$categories item=row}
									<option value="{$row.categoryid}" {if $row.categoryid == $category}SELECTED{/if}>{$row.category|escape:'htmlall'}</option>
								{/foreach}
							</select>
							{if isset($category_error)}
								<span class="help-inline">{$category_error}</span>
							{/if}
						</div>
					</div>
					<div class="control-group {if isset($price_error)}warning{/if}">
						<label class="control-label" for="price">Prix ({$opt.currency_symbol})</label>
						<div class="controls">
							<input id="price" name="price" type="text" value="{$price|escape:'htmlall'}" class="input-xlarge" placeholder="0.00">
							{if isset($price_error)}
								<span class="help-inline">{$price_error}</span>
							{/if}
						</div>
					</div>
					<div class="control-group {if isset($source_error)}warning{/if}">
						<label class="control-label" for="source">Magasin / détaillant</label>
						<div class="controls">
							<input id="source" name="source" type="text" value="{$source|escape:'htmlall'}" class="input-xlarge" maxlength="255" placeholder="Magasin">
							{if isset($source_error)}
								<span class="help-inline">{$source_error}</span>
							{/if}
						</div>
					</div>
					<div class="control-group {if isset($ranking_error)}warning{/if}">
						<label class="control-label" for="ranking">Niveau</label>
						<div class="controls">
							<select id="ranking" name="ranking" multiple="multiple" class="input-xlarge">
								{foreach from=$ranks item=row}
									<option value="{$row.ranking}" {if $row.ranking == $ranking}SELECTED{/if}>{$row.title}</option>
								{/foreach}
							</select>
							{if isset($ranking_error)}
								<span class="help-inline">{$ranking_error}</span>
							{/if}
						</div>
					</div>
					{if $opt.allow_multiples}
						<div class="control-group {if isset($quantity_error)}warning{/if}">
							<label class="control-label" for="quantity">Quantité</label>
							<div class="controls">
								<input id="quantity" name="quantity" type="text" value="{$quantity|escape:'htmlall'}" class="input-xlarge" maxlength="3">
								{if isset($quantity_error)}
									<span class="help-inline">{$quantity_error}</span>
								{/if}
							</div>
						</div>
					{else}
						<input type="hidden" name="quantity" value="1">
					{/if}
					<div class="control-group {if isset($url_error)}warning{/if}">
						<label class="control-label" for="url">URL (facultative)</label>
						<div class="controls">
							<input id="url" name="url" type="text" value="{$url|escape:'htmlall'}" class="input-xlarge" maxlength="255">
							{if isset($url_error)}
								<span class="help-inline">{$url_error}</span>
							{/if}
						</div>
					</div>
					{if $opt.allow_images}
						<div class="control-group">
							<label class="control-label" for="image">Image (facultative)</label>
							<div class="controls">
								{if $image_filename == ''}
									<input type="radio" name="image" value="none" CHECKED>
									Aucune image.<br />
									<input type="radio" name="image" value="upload" id="ifnew">
									Envoyer une image :
									<input type="file" id="imagefile" name="imagefile">
								{else}
									<input type="radio" name="image" value="remove">
									Supprimer l'image existante.<br />
									<input type="radio" name="image" value="keep" CHECKED>
									Conserver l'image existante.<br />
									<input type="radio" name="image" value="replace" id="ifreplace">
									Remplacer l'image existante :
									<input type="file" id="imagefile" name="imagefile">
								{/if}
							</div>
						</div>
					{/if}
					<div class="control-group">
						<label class="control-label" for="comment">Commentaire</label>
						<div class="controls">
							<textarea id="comment" name="comment" class="input-xlarge" rows="2" cols="40">{$comment|escape:'htmlall'}</textarea>
						</div>
					</div>
					<div class="form-actions">
						<button type="submit" class="btn btn-primary">Enregistrer</button>
						<button type="button" class="btn" onclick="document.location.href='index.php';">Annuler</button>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
	</div>
</body>
</html>

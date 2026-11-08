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
	<title>Liste de cadeaux - Liste de {$ufullname}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<link href="lightbox/css/jquery.lightbox-0.5.css" rel="stylesheet">
	<script src="lightbox/js/jquery.lightbox-0.5.min.js"></script>

    <script language="JavaScript" type="text/javascript">
		function printPage() {
			window.print();
		}

		$(document).ready(function() {
			$('a[rel=lightbox]').lightBox({
				imageLoading: 'lightbox/images/lightbox-ico-loading.gif',
				imageBtnClose: 'lightbox/images/lightbox-btn-close.gif',
				imageBtnPrev: 'lightbox/images/lightbox-btn-prev.gif',
				imageBtnNext: 'lightbox/images/lightbox-btn-next.gif',
				imageBlank: 'lightbox/images/lightbox-blank.gif'
			});
			$('a[rel=popover]').removeAttr('href').popover();
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
	<div class="row">
		<h1>Liste de cadeaux de {$ufullname|escape:'htmlall'}</h1>
	</div>
	{if $opt.show_helptext}
		<div class="row">
			<div class="span12">
				<div class="alert alert-info">
					<ul>
						<li>Si vous souhaitez offrir un cadeau à cette personne, cliquez sur l'icône <img src="images/locked.png">. Si vous l'achetez, revenez cliquer sur l'icône <img src="images/credit-card-3.png">. Si vous changez d'avis et ne souhaitez plus l'acheter, cliquez sur l'icône <img src="images/unlocked.png">.</li>
						<li>Si vous retournez un article acheté, cliquez sur l'icône <img src="images/return.png">. L'article restera réservé pour vous.</li>
						<li>La présence d'une URL ne vous oblige pas à acheter l'article sur ce site, sauf si le commentaire le précise.</li>
						<li>Cliquez sur les en-têtes de colonne pour trier la liste selon cet attribut.</li>
						<li>Si un article vous intéresse, cliquez sur l'icône <img src="images/split-2.png"> pour le copier dans votre propre liste.</li>
					</ul>
				</div>
			</div>
		</div>
	{/if}
	<div class="row">
		<div class="span6 offset6">
			<div class="alert alert-info">
		<img src="images/locked.png" alt="Réserver" title="Réserver"> = Réserver, <img src="images/unlocked.png" alt="Libérer" title="Libérer"> = Libérer, <img src="images/credit-card-3.png" alt="Acheter" title="Acheter"> = Acheter, <img src="images/return.png" alt="Retourner" title="Retourner"> = Retourner, <img src="images/split-2.png" alt="Je le veux aussi" title="Je le veux aussi"> = Je le veux aussi
			</div>
		</div>
	</div>
	<div class="row">
		<div class="span12">
			<div class="well">
		<table class="table table-bordered table-striped">
			<thead>
			<tr>
				<th><a href="shop.php?shopfor={$shopfor}&sort=ranking">Niveau</a></th>
				<th><a href="shop.php?shopfor={$shopfor}&sort=description">Description</a></th>
				<th><a href="shop.php?shopfor={$shopfor}&sort=category">Catégorie</a></th>
				<th><a href="shop.php?shopfor={$shopfor}&sort=price">Prix</a></th>
				<th><a href="shop.php?shopfor={$shopfor}&sort=source">Magasin / lieu</a></th>
				<th><a href="shop.php?shopfor={$shopfor}&sort=status">État</a></th>
				<th>&nbsp;</th>
			</tr>
			</thead>
			<tbody>
			{foreach from=$shoprows item=row}
				<tr valign="top">
					<td nowrap>{$row.rendered}</td>
					<td>
						{$row.description|escape:'htmlall'}
						{if $row.comment != ''}
							<a class="btn btn-small" rel="popover" href="#" data-placement="right" data-original-title="Commentaire" data-content="{$row.comment|escape:'htmlall'}">...</a>
						{/if}
						{if $row.url != ''}
							<a href="{$row.url}" target="_blank"><img src="images/link.png" border="0" alt="URL" title="URL"></a>
						{/if}
						{if $row.image_filename != '' && $opt.allow_images}
							<a rel="lightbox" href="{$opt.image_subdir}/{$row.image_filename}" title="{$row.description|escape:'htmlall'}"><img src="images/image.png" border="0" alt="Image" /></a>
						{/if}
					</td>
					<td>{$row.category|default:"&nbsp;"}</td>
					<td align="right">{$row.price}</td>
					<td>{$row.source|escape:'htmlall'}</td>
					{if $row.quantity > 1}
						<td>
							{foreach from=$row.allocs item=alloc}
								<b>{$alloc}</b><br />
							{/foreach}
							{$row.avail} disponible(s).<br />
						</td>
						<td nowrap align="right">
							{if $row.avail > 0 || $row.ireserved > 0 || $row.ibought > 0}
								{if $row.ireserved > 0}
									{assign var="reservetext" value="Réserver un autre article"}
								{else}
									{assign var="reservetext" value="Réserver l'article"}
								{/if}
								{if $row.ibought > 0}
									{assign var="purchasetext" value="Acheter un autre article"}
								{elseif $row.ireserved > 0}
									{assign var="purchasetext" value="Acheter l'article réservé"}
								{else}
									{assign var="purchasetext" value="Acheter l'article"}
								{/if}
								{if $row.avail > 0}
									<a href="shop.php?action=reserve&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="{$reservetext|escape:'htmlall'}" title="{$reservetext|escape:'htmlall'}" src="images/locked.png" border="0" /></a>
								{/if}
								{if $row.avail > 0 || $row.ireserved > 0}
									<a href="shop.php?action=purchase&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="{$purchasetext|escape:'htmlall'}" title="{$purchasetext|escape:'htmlall'}" src="images/credit-card-3.png" border="0" /></a>
								{/if}
							{/if}
							{if $row.ireserved > 0}
								<a href="shop.php?action=release&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="Libérer l'article" title="Libérer l'article" src="images/unlocked.png" border="0" /></a>
							{/if}
							{if $row.ibought > 0}
								<a href="shop.php?action=return&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="Retourner l'article" title="Retourner l'article" src="images/return.png" border="0" /></a>
							{/if}
						{* </td> *}
					{else}
						{if $row.rfullname == '' && $row.bfullname == ''}
							<td>
								<i>Disponible.</i>
							</td>
							<td nowrap align="right">
								<a href="shop.php?action=reserve&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="Réserver l'article" title="Réserver l'article" src="images/locked.png" border="0" /></a>&nbsp;<a href="shop.php?action=purchase&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="Acheter l'article" title="Acheter l'article" src="images/credit-card-3.png" border="0" /></a>
							{* </td> *}
						{elseif $row.rfullname != ''}
							{if $row.reservedid == $userid}
								<td>
									<i><b>Vous avez réservé cet article.</b></i>
								</td>
								<td align="right">
									<a href="shop.php?action=release&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="Libérer l'article" title="Libérer l'article" src="images/unlocked.png" border="0" /></a>&nbsp;<a href="shop.php?action=purchase&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="Acheter l'article" title="Acheter l'article" src="images/credit-card-3.png" border="0" /></a>
								{* </td> *}
							{else}
								<td>
									{if $opt.anonymous_purchasing}
										<i>Réservé.</i>
									{else}
										<i>Réservé par {$row.rfullname|escape:'htmlall'}.</i>
									{/if}
								</td>
								<td>
								{* </td> *}
							{/if}
						{elseif $row.bfullname != ''}
							{if $row.boughtid == $userid}
								<td>
									<i><b>Vous avez acheté cet article.</b></i>
								</td>
								<td align="right">
									<a href="shop.php?action=return&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="Retourner l'article" title="Retourner l'article" src="images/return.png" border="0" /></a>
								{* </td> *}
							{else}
								{if $opt.anonymous_purchasing}
									<td>
										<i>Acheté.</i>
									</td>
									<td>
									{* </td> *}
								{else}
									<td>
										<i>Acheté par {$row.bfullname|escape:'htmlall'}.</i>
									</td>
									<td>
									{* </td> *}
								{/if}
							{/if}
						{/if}
					{/if}
					{* <td> *}
						<a href="shop.php?action=copy&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="Je le veux aussi" title="Je le veux aussi" src="images/split-2.png" border="0" /></a>
					</td>
				</tr>
			{/foreach}
			</tbody>
		</table>
	</div>
	</div>
	</div>
	<div class="row">
		<div class="span6">
			<div class="well">
				<a onClick="printPage()" href="#">Imprimer</a>
			</div>
		</div>
	</div>
	</div>
</body>
</html>

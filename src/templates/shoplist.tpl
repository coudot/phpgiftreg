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
	<title>Liste de cadeaux - Mes achats</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
					 
	<script language="JavaScript" type="text/javascript">
		function printPage() {
			window.print();
		}
	</script>
</head>
<body>
	{include file='navbar.tpl' isadmin=$isadmin}

	<div class="container" style="padding-top: 60px;">
		{if $opt.show_helptext}
			<div class="row">
				<div class="span12">
					<div class="alert alert-info">
						Voici la liste des articles que vous avez <strong>réservés</strong>. Après avoir acheté un article ou décidé de ne pas l'acheter, retournez sur la liste du destinataire et indiquez-le.
					</div>
				</div>
			</div>
		{/if}

		<div class="row">
			<div class="span12">
				<div class="well">
					<h1>Mes achats</h1>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th><a href="shoplist.php?sort=recipient">Destinataire</a></th>
								<th><a href="shoplist.php?sort=description">Description</a></th>
								<th><a href="shoplist.php?sort=ranking">Niveau</a></th>
								<th><a href="shoplist.php?sort=source">Magasin</a></th>
								<th><a href="shoplist.php?sort=price">Prix</a></th>
							</tr>
						</thead>
						<tbody>
							{foreach from=$shoplist item=row}
								<tr>
									<td>{$row.fullname|escape:'htmlall'}</td>
									<td>{$row.description|escape:'htmlall'}</td>
									<td>{$row.rendered}</td>
									<td>{$row.source}</td>
									<td>{$row.price}</td>
								</tr>
							{/foreach}
						</tbody>
					</table>
					<h5>{$itemcount} article(s), {$totalprice} au total.</h5>
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

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>

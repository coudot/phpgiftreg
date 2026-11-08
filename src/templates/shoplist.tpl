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
	<title>{$messages.tpl.shoplist.title}</title>
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
						{$messages.tpl.shoplist.help}
					</div>
				</div>
			</div>
		{/if}

		<div class="row">
			<div class="span12">
				<div class="well">
					<h1>{$messages.tpl.shoplist.heading}</h1>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th><a href="shoplist.php?sort=recipient">{$messages.tpl.shoplist.recipient}</a></th>
								<th><a href="shoplist.php?sort=description">{$messages.tpl.shoplist.description}</a></th>
								<th><a href="shoplist.php?sort=ranking">{$messages.tpl.shoplist.ranking}</a></th>
								<th><a href="shoplist.php?sort=source">{$messages.tpl.shoplist.source}</a></th>
								<th><a href="shoplist.php?sort=price">{$messages.tpl.shoplist.price}</a></th>
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
					<h5>{$messages.tpl.shoplist.summary|replace:'%s':$itemcount|replace:'%s':$totalprice}</h5>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="span6">
				<div class="well">
					<a onClick="printPage()" href="#">{$messages.tpl.shoplist.print}</a>
				</div>
			</div>
		</div>
	</div>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>

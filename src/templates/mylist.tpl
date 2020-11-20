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
<html lang="en">
<head>
	<title>Gift Registry - My Items</title>
 	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet">

	<script language="JavaScript">
		function printPage() {
			window.print();
		}
	</script>
</head>
<body>
	 <div class="container" style="padding-top: 5px;">

		<div class="row">
			<div class="span12">
				<div class="well">
					<p style="text-align: center">🎁 Wish list for {$fullname|escape:'htmlall'} - {$today|escape:'htmlall'} 🎁</p>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th><a href="mylist.php?sort=ranking">Ranking</a></th>
								<th><a href="mylist.php?sort=source">Source</a></th>
								<th><a href="mylist.php?sort=description">Description</a></th>
								<th><a href="mylist.php?sort=category">Category</a></th>
								<th><a href="mylist.php?sort=price">Price</a></th>
							</tr>
						</thead>
						<tbody>
							{foreach from=$shoplist item=row}
								<tr>
									<td style="min-width: 75px">{$row.rendered}</td>
									<td>{$row.source|escape:'htmlall'}</td>
									<td><span style="font-weight: bold">
                                    {if $row.url != ''}
                                        <a href="{$row.url|escape:'htmlall'}">
                                    {/if}
                                            {$row.description|escape:'htmlall'}
                                    {if $row.url != ''}
                                        </a>
                                    {/if}
                                        </span><br/> <em>{$row.comment|escape:'htmlall'}</em></td>
									<td>{$row.category|escape:'htmlall'}</td>
									<td>{$row.price}</td>
								</tr>
							{/foreach}
						</tbody>
					</table>
				</div>
			</div>
		</div>

	</div>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>

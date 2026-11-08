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
	<title>{$messages.tpl.shop.title|replace:'%s':$ufullname|escape:'htmlall'}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.bundle.min.js"></script>
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
			document.querySelectorAll('[rel="popover"]').forEach(function (element) {
				element.removeAttribute('href');
				new bootstrap.Popover(element);
			});
		});
	</script>
</head>
<body>
	{include file='navbar.tpl' isadmin=$isadmin}

	<div class="container" style="padding-top: 60px;">
	{if isset($message)}
		<div class="row">
			<div class="col-12">
				<div class="alert alert-info">
					{$message|escape:'htmlall'}
				</div>
			</div>
		</div>
	{/if}
	<div class="row">
		<h1>{$messages.tpl.shop.heading|replace:'%s':$ufullname|escape:'htmlall'}</h1>
	</div>
	{if $opt.show_helptext}
		<div class="row">
			<div class="col-12">
				<div class="alert alert-info">
					<ul>
						<li>{$messages.tpl.shop.help_reserve}</li>
						<li>{$messages.tpl.shop.help_return}</li>
						<li>{$messages.tpl.shop.help_url}</li>
						<li>{$messages.tpl.shop.help_sort}</li>
						<li>{$messages.tpl.shop.help_copy}</li>
					</ul>
				</div>
			</div>
		</div>
	{/if}
	<div class="row">
		<div class="col-md-6 offset-md-6">
			<div class="alert alert-info">
		<img src="images/locked.png" alt="{$messages.tpl.shop.reserve|escape:'htmlall'}" title="{$messages.tpl.shop.reserve|escape:'htmlall'}"> = {$messages.tpl.shop.reserve}, <img src="images/unlocked.png" alt="{$messages.tpl.shop.release|escape:'htmlall'}" title="{$messages.tpl.shop.release|escape:'htmlall'}"> = {$messages.tpl.shop.release}, <img src="images/credit-card-3.png" alt="{$messages.tpl.shop.purchase|escape:'htmlall'}" title="{$messages.tpl.shop.purchase|escape:'htmlall'}"> = {$messages.tpl.shop.purchase}, <img src="images/return.png" alt="{$messages.tpl.shop.return|escape:'htmlall'}" title="{$messages.tpl.shop.return|escape:'htmlall'}"> = {$messages.tpl.shop.return}, <img src="images/split-2.png" alt="{$messages.tpl.shop.want_too|escape:'htmlall'}" title="{$messages.tpl.shop.want_too|escape:'htmlall'}"> = {$messages.tpl.shop.want_too}
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-12">
			<div class="card p-3">
		<table class="table table-bordered table-striped">
			<thead>
			<tr>
				<th><a href="shop.php?shopfor={$shopfor}&sort=ranking">{$messages.tpl.shop.rank}</a></th>
				<th><a href="shop.php?shopfor={$shopfor}&sort=description">{$messages.tpl.shop.description}</a></th>
				<th><a href="shop.php?shopfor={$shopfor}&sort=category">{$messages.tpl.shop.category}</a></th>
				<th><a href="shop.php?shopfor={$shopfor}&sort=price">{$messages.tpl.shop.price}</a></th>
				<th><a href="shop.php?shopfor={$shopfor}&sort=source">{$messages.tpl.shop.store}</a></th>
				<th><a href="shop.php?shopfor={$shopfor}&sort=status">{$messages.tpl.shop.status}</a></th>
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
							<a class="btn btn-secondary btn-sm" rel="popover" href="#" data-bs-placement="right" data-bs-title="{$messages.tpl.shop.comment|escape:'htmlall'}" data-bs-content="{$row.comment|escape:'htmlall'}">...</a>
						{/if}
						{if $row.url != ''}
							<a href="{$row.url}" target="_blank"><img src="images/link.png" border="0" alt="{$messages.tpl.shop.url|escape:'htmlall'}" title="{$messages.tpl.shop.url|escape:'htmlall'}"></a>
						{/if}
						{if $row.image_filename != '' && $opt.allow_images}
							<a rel="lightbox" href="{$opt.image_subdir}/{$row.image_filename}" title="{$row.description|escape:'htmlall'}"><img src="images/image.png" border="0" alt="{$messages.tpl.shop.image|escape:'htmlall'}" /></a>
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
							{$messages.tpl.shop.remaining|replace:'%s':$row.avail}<br />
						</td>
						<td nowrap align="right">
							{if $row.avail > 0 || $row.ireserved > 0 || $row.ibought > 0}
								{if $row.ireserved > 0}
									{assign var="reservetext" value=$messages.tpl.shop.reserve_another}
								{else}
									{assign var="reservetext" value=$messages.tpl.shop.reserve_item}
								{/if}
								{if $row.ibought > 0}
									{assign var="purchasetext" value=$messages.tpl.shop.purchase_another}
								{elseif $row.ireserved > 0}
									{assign var="purchasetext" value=$messages.tpl.shop.convert_reserve}
								{else}
									{assign var="purchasetext" value=$messages.tpl.shop.purchase_item}
								{/if}
								{if $row.avail > 0}
									<a href="shop.php?action=reserve&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="{$reservetext|escape:'htmlall'}" title="{$reservetext|escape:'htmlall'}" src="images/locked.png" border="0" /></a>
								{/if}
								{if $row.avail > 0 || $row.ireserved > 0}
									<a href="shop.php?action=purchase&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="{$purchasetext|escape:'htmlall'}" title="{$purchasetext|escape:'htmlall'}" src="images/credit-card-3.png" border="0" /></a>
								{/if}
							{/if}
							{if $row.ireserved > 0}
								<a href="shop.php?action=release&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="{$messages.tpl.shop.release_item|escape:'htmlall'}" title="{$messages.tpl.shop.release_item|escape:'htmlall'}" src="images/unlocked.png" border="0" /></a>
							{/if}
							{if $row.ibought > 0}
								<a href="shop.php?action=return&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="{$messages.tpl.shop.return_item|escape:'htmlall'}" title="{$messages.tpl.shop.return_item|escape:'htmlall'}" src="images/return.png" border="0" /></a>
							{/if}
						{* </td> *}
					{else}
						{if $row.rfullname == '' && $row.bfullname == ''}
							<td>
								<i>{$messages.tpl.shop.available}</i>
							</td>
							<td nowrap align="right">
								<a href="shop.php?action=reserve&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="{$messages.tpl.shop.reserve_item|escape:'htmlall'}" title="{$messages.tpl.shop.reserve_item|escape:'htmlall'}" src="images/locked.png" border="0" /></a>&nbsp;<a href="shop.php?action=purchase&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="{$messages.tpl.shop.purchase_item|escape:'htmlall'}" title="{$messages.tpl.shop.purchase_item|escape:'htmlall'}" src="images/credit-card-3.png" border="0" /></a>
							{* </td> *}
						{elseif $row.rfullname != ''}
							{if $row.reservedid == $userid}
								<td>
									<i><b>{$messages.tpl.shop.reserved_by_you}</b></i>
								</td>
								<td align="right">
									<a href="shop.php?action=release&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="{$messages.tpl.shop.release_item|escape:'htmlall'}" title="{$messages.tpl.shop.release_item|escape:'htmlall'}" src="images/unlocked.png" border="0" /></a>&nbsp;<a href="shop.php?action=purchase&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="{$messages.tpl.shop.purchase_item|escape:'htmlall'}" title="{$messages.tpl.shop.purchase_item|escape:'htmlall'}" src="images/credit-card-3.png" border="0" /></a>
								{* </td> *}
							{else}
								<td>
									{if $opt.anonymous_purchasing}
										<i>{$messages.tpl.shop.reserved}</i>
									{else}
										<i>{$messages.tpl.shop.reserved_by|replace:'%s':$row.rfullname|escape:'htmlall'}</i>
									{/if}
								</td>
								<td>
								{* </td> *}
							{/if}
						{elseif $row.bfullname != ''}
							{if $row.boughtid == $userid}
								<td>
									<i><b>{$messages.tpl.shop.bought_by_you}</b></i>
								</td>
								<td align="right">
									<a href="shop.php?action=return&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="{$messages.tpl.shop.return_item|escape:'htmlall'}" title="{$messages.tpl.shop.return_item|escape:'htmlall'}" src="images/return.png" border="0" /></a>
								{* </td> *}
							{else}
								{if $opt.anonymous_purchasing}
									<td>
										<i>{$messages.tpl.shop.bought}</i>
									</td>
									<td>
									{* </td> *}
								{else}
									<td>
										<i>{$messages.tpl.shop.bought_by|replace:'%s':$row.bfullname|escape:'htmlall'}</i>
									</td>
									<td>
									{* </td> *}
								{/if}
							{/if}
						{/if}
					{/if}
					{* <td> *}
						<a href="shop.php?action=copy&itemid={$row.itemid}&shopfor={$shopfor}"><img alt="{$messages.tpl.shop.want_too|escape:'htmlall'}" title="{$messages.tpl.shop.want_too|escape:'htmlall'}" src="images/split-2.png" border="0" /></a>
					</td>
				</tr>
			{/foreach}
			</tbody>
		</table>
	</div>
	</div>
	</div>
	<div class="row">
		<div class="col-md-6">
			<div class="card p-3">
				<a onClick="printPage()" href="#">{$messages.tpl.shop.print}</a>
			</div>
		</div>
	</div>
	</div>
</body>
</html>

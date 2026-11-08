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
	<title>{$messages.tpl.home.title|replace:'%s':$fullname|escape:'htmlall'}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.bundle.min.js"></script>
	<link href="lightbox/css/jquery.lightbox-0.5.css" rel="stylesheet">
	<script src="lightbox/js/jquery.lightbox-0.5.min.js"></script>
	
	<script language="JavaScript" type="text/javascript">
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
			{if $opt.confirm_item_deletes}
				$('a[rel=confirmitemdelete]').click(function(event) {
					var desc = $(this).attr('data-content');
					if (!window.confirm('{$messages.tpl.home.confirm_delete_before|escape:'javascript'}' + desc + '{$messages.tpl.home.confirm_delete_after|escape:'javascript'}')) {
						event.preventDefault();
					}
				});
			{/if}
			{if $opt.shop_requires_approval}
				$('a[rel=confirmunshop]').click(function(event) {
					var fn = $(this).attr('data-content');
					if (!window.confirm('{$messages.tpl.home.confirm_unshop_before|escape:'javascript'}' + fn + '{$messages.tpl.home.confirm_unshop_after|escape:'javascript'}')) {
						event.preventDefault();
					}
				});
			{/if}
		});
	</script>
</head>
<body>
	{include file='navbar.tpl'}

	<div class="container" style="padding-top: 60px;">
	{if isset($message)}
		<div class="row">
			<div class="col-12">
				<div class="alert alert-info">{$message|escape:'htmlall'}</div>
			</div>
		</div>
	{/if}
	{if $opt.show_helptext}
		<section id="help">
	 	<div class="row">
			<div class="col-12">
				<div class="alert alert-info">
				<ul>
					<li>{$messages.tpl.home.help_sort}</li>
					<li>{$messages.tpl.home.help_list}</li>
					<li>{$messages.tpl.home.help_purchase}</li>
					<li>{$messages.tpl.home.help_received}</li>
				</ul>
				</div>
			</div>
		</div>
		</section>
	{/if}
	<section id="myitems">
		<div class="card p-3">
		<div class="border-bottom mb-4">
			<h1>{$messages.tpl.home.my_items}</h1>
		</div>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th class="colheader"><a href="index.php?mysort=description">{$messages.tpl.home.description}</a></th>
					<th class="colheader"><a href="index.php?mysort=ranking">{$messages.tpl.home.ranking}</a></th>
					<th class="colheader"><a href="index.php?mysort=category">{$messages.tpl.home.category}</a></th>
					<th class="rcolheader"><a href="index.php?mysort=price">{$messages.tpl.home.price}</a></th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				{foreach from=$myitems item=row}
					<tr valign="top">
						<td>
							{$row.description|escape:'htmlall'}
							 {if $row.comment != ''}
								<a class="btn btn-secondary btn-sm" rel="popover" href="#" data-bs-placement="right" data-bs-title="{$messages.tpl.home.comment|escape:'htmlall'}" data-bs-content="{$row.comment|escape:'htmlall'}">...</a>
							{/if}
							{if $row.url != ''}
								<a href="{$row.url|escape:'htmlall'}" target="_blank"><img src="images/link.png" border="0" alt="{$messages.tpl.home.url|escape:'htmlall'}" title="{$messages.tpl.home.url|escape:'htmlall'}"></a>
							{/if}
							{if $row.image_filename != '' && $opt.allow_images}
								<a rel="lightbox" href="{$opt.image_subdir}/{$row.image_filename}" title="{$row.description|escape:'htmlall'}"><img src="images/image.png" border="0" alt="{$messages.tpl.home.image|escape:'htmlall'}" /></a>
							{/if}
						</td>
						<td nowrap>{$row.rendered}</td>
						<td>{$row.category|default:"&nbsp;"}</td>
						<td align="right">{$row.price}</td>
						<td align="right" nowrap>
							<a href="receive.php?itemid={$row.itemid}"><img alt="{$messages.tpl.home.mark_received|escape:'htmlall'}" src="images/return.png" border="0" title="{$messages.tpl.home.mark_received|escape:'htmlall'}" /></a>&nbsp;
							<a href="item.php?action=edit&itemid={$row.itemid}"><img alt="{$messages.tpl.home.edit_item|escape:'htmlall'}" src="images/pencil.png" border="0" title="{$messages.tpl.home.edit_item|escape:'htmlall'}" /></a>&nbsp;
							<a rel="confirmitemdelete" data-content="{$row.description|escape:'htmlall'}" href="item.php?action=delete&itemid={$row.itemid}"><img alt="{$messages.tpl.home.delete_item|escape:'htmlall'}" src="images/bin.png" border="0" title="{$messages.tpl.home.delete_item|escape:'htmlall'}" /></a>
						</td>
					</tr>
				{/foreach}
			</tbody>
		</table>
		{if $myitems_count > $opt.items_per_page}
			<nav aria-label="Pagination">
				<ul class="pagination">
					{if $offset >= $opt.items_per_page}
						<li class="page-item"><a class="page-link" href="index.php?offset={$offset - $opt.items_per_page}">&lt;</a></li>
					{/if}
					{for $i=0 to $myitems_count step $opt.items_per_page}
						<li class="page-item {if $offset >= $i && $offset < $i + $opt.items_per_page}active{/if}"><a class="page-link" href="index.php?offset={$i}">{$i + $opt.items_per_page}</a></li>
					{/for}
					{if $offset + $opt.items_per_page < $myitems_count}
						<li class="page-item"><a class="page-link" href="index.php?offset={$offset + $opt.items_per_page}">&gt;</a></li>
					{/if}
				</ul>
			</nav>
		{/if}
		<h5><a href="item.php?action=add">{$messages.tpl.home.add_item}</a></h5>
		</div>
	</section>
	<section id="otherstuff">
		<div class="row">
			<div class="col-md-6">
				<div class="card p-3">
				<h3>{$messages.tpl.home.shopping_for}</h3>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th class="colheader">{$messages.tpl.home.name}</th>
					<th class="rcolheader">{$messages.tpl.home.last_updated}</th>
					<th class="rcolheader">{$messages.tpl.home.item_count}</th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				{foreach from=$shoppees item=row}
					<tr>
						<td>
							<a href="shop.php?shopfor={$row.userid}">{$row.fullname|escape:'htmlall'}</a>
							{if $row.comment != ''}
								<a class="btn btn-secondary btn-sm" rel="popover" href="#" data-bs-placement="right" data-bs-title="{$messages.tpl.home.comment|escape:'htmlall'}" data-bs-content="{$row.comment|escape:'htmlall'}">...</a>
							{/if}
						</td>
						<td align="right">{$row.list_stamp}</td>
						<td align="right">{$row.itemcount}</td>
						<td align="right" nowrap>
							{if $row.itemcount > 0}
								<a href="shop.php?shopfor={$row.userid}"><img alt="{$messages.tpl.home.shop_for|replace:'%s':$row.fullname|escape:'htmlall'}" src="images/store.png" border="0" title="{$messages.tpl.home.shop_for|replace:'%s':$row.fullname|escape:'htmlall'}"></a>
							{/if}
							{if !$row.is_unsubscribed}
								<a href="index.php?action=unsubscribe&shoppee={$row.userid}"><img alt="{$messages.tpl.home.unsubscribe|replace:'%s':$row.fullname|escape:'htmlall'}" src="images/delete.png" border="0" title="{$messages.tpl.home.unsubscribe|replace:'%s':$row.fullname|escape:'htmlall'}"></a>
							{else}
								<a href="index.php?action=subscribe&shoppee={$row.userid}"><img alt="{$messages.tpl.home.subscribe|replace:'%s':$row.fullname|escape:'htmlall'}" src="images/podcast.png" border="0" title="{$messages.tpl.home.subscribe|replace:'%s':$row.fullname|escape:'htmlall'}"></a>
							{/if}
							<a rel="confirmunshop" data-content="{$row.fullname|escape:'htmlall'}" href="index.php?action=cancel&shopfor={$row.userid}"><img src="images/bin.png" border="0" alt="{$messages.tpl.home.not_shop_for|replace:'%s':$row.fullname|escape:'htmlall'}" title="{$messages.tpl.home.not_shop_for|replace:'%s':$row.fullname|escape:'htmlall'}" /></a>
						</td>
					</tr>
				{/foreach}
			</tbody>
		</table>
			</div>
			</div>
			<div class="col-md-6">
				<div class="card p-3">
				<h3>{$messages.tpl.home.not_shopping_for}</h3>
					<table class="table table-bordered table-striped"> 
						<thead>
						<tr>
							<th class="colheader">{$messages.tpl.home.name}</th>
							<th>&nbsp;</th>
						</tr>
						</thead>
						<tbody>
						{foreach from=$prospects item=row}
							<tr>
								<td>{$row.fullname|escape:'htmlall'}</td>
								<td align="right" nowrap>
									{if $row.pending}
										<a href="index.php?action=cancel&shopfor={$row.userid}"><img src="images/delete.png" border="0" alt="{$messages.tpl.home.cancel|escape:'htmlall'}" title="{$messages.tpl.home.cancel|escape:'htmlall'}" /></a>
									{else}
										<a href="index.php?action=request&shopfor={$row.userid}">
											{if $opt.shop_requires_approval}
												<img src="images/cloud-add.png" border="0" alt="{$messages.tpl.home.request|escape:'htmlall'}" title="{$messages.tpl.home.request|escape:'htmlall'}" />
											{else}
												<img src="images/cloud-add.png" border="0" alt="{$messages.tpl.home.add|escape:'htmlall'}" title="{$messages.tpl.home.add|escape:'htmlall'}" />
											{/if}
										</a>
									{/if}
								</td>
							</tr>
						{/foreach}
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</section>
	<section id="morestuffstill">
		<div class="row">
			<div class="col-md-6">
				<div class="card p-3">
				<h3>{$messages.tpl.home.messages}</h3>
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th class="colheader">{$messages.tpl.home.date}</th>
							<th class="colheader">{$messages.tpl.home.sender}</th>
							<th class="colheader">{$messages.tpl.home.message}</th>
							<th>&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						{foreach from=$notifications item=row}
							<tr>
								<td>{$row.created}</td>
								<td>{$row.fullname|escape:'htmlall'}</td>
								<td>{$row.message|escape:'htmlall'}</td>
								<td align="right">
									<a href="index.php?action=ack&messageid={$row.messageid}"><img alt="{$messages.tpl.home.acknowledge|escape:'htmlall'}" title="{$messages.tpl.home.acknowledge|escape:'htmlall'}" src="images/delete.png" border="0"></a>
								</td>
							</tr>
						{/foreach}
					</tbody>
					</table>
					<h5><a href="message.php">{$messages.tpl.home.send_message}</a></h5>
					</div>
				</div>
				<div class="col-md-6">
					<div class="card p-3">
					<h3>{$messages.tpl.home.upcoming_events|replace:'%s':$opt.event_threshold}</h3>
					<table class="table table-bordered table-striped">
						<thead>
						<tr>
							<th class="colheader">{$messages.tpl.home.name}</th>
							<th class="colheader">{$messages.tpl.home.event}</th>
							<th class="colheader">{$messages.tpl.home.date}</th>
							<th class="colheader">{$messages.tpl.home.days_left}</th>
						</tr>
						</thead>
						<tbody>
						{foreach from=$events item=row}
							<tr>
								<td>
									{if $row.fullname == ''}
										<i>{$messages.tpl.home.system_event}</i>
									{else}
										{$row.fullname|escape:'htmlall'}
									{/if}
								</td>
								<td>{$row.eventname|escape:'htmlall'}</td>
								<td>{$row.date}</td>
								<td>
									{if $row.daysleft == 0}
										<b>{$messages.tpl.home.today}</b>
									{else}
										{$row.daysleft}
									{/if}
								</td>
							</tr>
						{/foreach}
						</tbody>
					</table>
					</div>
				</div>
			</div>
			{if $opt.shop_requires_approval || ($isadmin && $opt.newuser_requires_approval)}
				<div class="row">
					{if $opt.shop_requires_approval}
						<div class="col-md-6">
							<div class="card p-3">
								<h3>{$messages.tpl.home.people_want_shop}</h3>
								<table class="table table-bordered table-striped">
									<thead>
										<tr>	
											<th class="colheader">{$messages.tpl.home.name}</th>
											<th>&nbsp;</th>
										</tr>
									</thead>
									<tbody>
										{foreach from=$pending item=row}
											<tr>
												<td>{$row.fullname|escape:'htmlall'}</td>
												<td align="right">
													<a href="index.php?action=approve&shopper={$row.userid}">{$messages.tpl.home.approve}</a>&nbsp;/
													<a href="index.php?action=decline&shopper={$row.userid}">{$messages.tpl.home.decline}</a>
												</td>
											</tr>
										{/foreach}
									</tbody>
								</table>
							</div>
						</div>
					{/if}
					{if $isadmin && $opt.newuser_requires_approval}
						<div class="col-md-6">
							<div class="card p-3">
								<h3>{$messages.tpl.home.people_waiting}</h3>
								<table class="table table-bordered table-striped">
									<thead>
										<tr>
											<th class="colheader">{$messages.tpl.home.name}</th>
											<th class="colheader">{$messages.tpl.home.family}</th>
											<th>&nbsp;</th>
										</tr>
									</thead>
									<tbody>
										{foreach from=$approval item=row}
											<tr>
												<td>{$row.fullname|escape:'htmlall'} &lt;<a href="mailto:{$row.email|escape:'htmlall'}">{$row.email|escape:'htmlall'}</a>&gt;</td>
												<td>{$row.familyname|escape:'htmlall'}</td>
												<td align="right">
													<a href="admin.php?action=approve&userid={$row.userid}&familyid={$row.initialfamilyid}">{$messages.tpl.home.approve}</a>&nbsp;/
													<a href="admin.php?action=reject&userid={$row.userid}">{$messages.tpl.home.reject}</a>
												</td>
											</tr>
										{/foreach}
									</tbody>
								</table>
							</div>
						</div>
					{/if}
				</div>
			{/if}
		</section>
	</div>
</body>
</html>

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

<div class="navbar navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container">
			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</a>
			<a class="brand" href="index.php">{$messages.tpl.gift_registry}</a>
			<div id="main-menu" class="nav-collapse">
				<ul id="main-menu-left" class="nav">
					<li><a href="shoplist.php">{$messages.tpl.navbar.shopping_list}</a></li>
					<li><a href="mylist.php">{$messages.tpl.navbar.my_items}</a></li>
				</ul>
				<ul id="main-menu-right" class="nav pull-right">
					<li><a href="profile.php">{$messages.tpl.navbar.update_profile}</a></li>
					<li><a href="event.php">{$messages.tpl.navbar.manage_events}</a></li>
					{if $isadmin}
						<li class="dropdown">
							<a class="dropdown-toggle" href="#" data-toggle="dropdown">
								{$messages.tpl.navbar.admin}
								<b class="caret"></b>
							</a>
							<ul class="dropdown-menu">
								<li><a href="users.php">{$messages.tpl.navbar.manage_users}</a></li>
								<li><a href="families.php">{$messages.tpl.navbar.manage_families}</a></li>
								<li><a href="categories.php">{$messages.tpl.navbar.manage_categories}</a></li>
								<li><a href="ranks.php">{$messages.tpl.navbar.manage_ranks}</a></li>
							</ul>
						</li>
					{/if}
					<li><a href="login.php?action=logout">{$messages.tpl.navbar.logout}</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

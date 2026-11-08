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

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="index.php">{$messages.tpl.gift_registry}</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#main-menu" aria-controls="main-menu" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="main-menu" class="collapse navbar-collapse">
			<ul id="main-menu-left" class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link" href="shoplist.php">{$messages.tpl.navbar.shopping_list}</a></li>
				<li class="nav-item"><a class="nav-link" href="mylist.php">{$messages.tpl.navbar.my_items}</a></li>
			</ul>
			<ul id="main-menu-right" class="navbar-nav ms-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link" href="profile.php">{$messages.tpl.navbar.update_profile}</a></li>
				<li class="nav-item"><a class="nav-link" href="event.php">{$messages.tpl.navbar.manage_events}</a></li>
					{if $isadmin}
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
								{$messages.tpl.navbar.admin}
							</a>
							<ul class="dropdown-menu dropdown-menu-end">
								<li><a class="dropdown-item" href="users.php">{$messages.tpl.navbar.manage_users}</a></li>
								<li><a class="dropdown-item" href="families.php">{$messages.tpl.navbar.manage_families}</a></li>
								<li><a class="dropdown-item" href="categories.php">{$messages.tpl.navbar.manage_categories}</a></li>
								<li><a class="dropdown-item" href="ranks.php">{$messages.tpl.navbar.manage_ranks}</a></li>
							</ul>
						</li>
					{/if}
				<li class="nav-item"><a class="nav-link" href="login.php?action=logout">{$messages.tpl.navbar.logout}</a></li>
			</ul>
		</div>
	</div>
</nav>

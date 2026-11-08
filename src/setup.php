<?php
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

require_once(dirname(__FILE__) . "/includes/config.php");
require_once(dirname(__FILE__) . "/includes/lang.php");

$opt = getGlobalOptions();
$messages = getLanguageMessages($opt["language"]);

function dbh($opt) {
	return new PDO($opt["pdo_connection_string"], $opt["pdo_username"], $opt["pdo_password"]);
}

$stmt = dbh($opt)->prepare("SELECT COUNT(*) AS user_count FROM {$opt["table_prefix"]}users");
$stmt->execute();
if ($row = $stmt->fetch()) {
	$user_count = $row["user_count"];
	if ($user_count != 0) {
		die(translate("error.database_setup"));
	}
}
else {
	die(translate("error.database_missing"));
}

if (isset($_POST["action"])) {
	if ($_POST["action"] == "setup") {
		$username = $_POST["username"];
		$fullname = $_POST["fullname"];
		$pwd = $_POST["pwd"];
		$email = $_POST["email"];
		$familyname = $_POST["familyname"];
		if (trim($familyname) == "") {
			$familyname = translate("family.default");
		}

		// 1. create the family.
		$stmt = dbh($opt)->prepare("INSERT INTO {$opt["table_prefix"]}families(familyname) VALUES(?)");
		$stmt->bindParam(1, $familyname, PDO::PARAM_STR);
		$stmt->execute();
						         
		// 2. get the familyid.
		$stmt = dbh($opt)->prepare("SELECT MAX(familyid) AS familyid FROM {$opt["table_prefix"]}families");
		$stmt->execute();
		if ($row = $stmt->fetch()) {
			$familyid = $row["familyid"];
		}
		else die(translate("error.family_create"));

		// 3. insert the user.
		$stmt = dbh($opt)->prepare("INSERT INTO {$opt["table_prefix"]}users(username,fullname,password,email,approved,admin,initialfamilyid) VALUES(?, ?, {$opt["password_hasher"]}(?), ?, 1, 1, ?)");
		$stmt->bindParam(1, $username, PDO::PARAM_STR);
		$stmt->bindParam(2, $fullname, PDO::PARAM_STR);
		$stmt->bindParam(3, $pwd, PDO::PARAM_STR);
		$stmt->bindParam(4, $email, PDO::PARAM_STR);
		$stmt->bindParam(5, $familyid, PDO::PARAM_INT);
		$stmt->execute();

		// 4. get the userid.
		$stmt = dbh($opt)->prepare("SELECT MAX(userid) AS userid FROM {$opt["table_prefix"]}users");
		$stmt->execute();
		if ($row = $stmt->fetch()) {
			$userid = $row["userid"];
		}
		else die(translate("error.user_create"));

		// 5. create the membership.
		$stmt = dbh($opt)->prepare("INSERT INTO {$opt["table_prefix"]}memberships(userid,familyid) VALUES(?, ?)");
		$stmt->bindParam(1, $userid, PDO::PARAM_INT);
		$stmt->bindParam(2, $familyid, PDO::PARAM_INT);
		$stmt->execute();
	}
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo $opt["language"]; ?>" lang="<?php echo $opt["language"]; ?>">
<head>
	<title><?php echo htmlspecialchars(translate("setup.page_title")); ?></title>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script language="JavaScript" type="text/javascript">
		$(document).ready(function() {
			$("#setupform").validate({
				rules: {
					"username": {
						required: true,
						maxlength: 20
					},
					"pwd": {
						required: true,
						maxlength: 50
					},
					"confirmpwd": {
						required: true,
						equalTo: "#pwd",
						maxlength: 50
					},
					"fullname": {
						required: true,
						maxlength: 50
					},
					"email": {
						required: true,
						maxlength: 255,
						email: true
					}
				},
				messages: {
					"username": {
						required: "<?php echo addslashes(translate("validation.username_required")); ?>",
						maxlength: "<?php echo addslashes(translate("validation.username_length")); ?>"
					},
					"pwd": {
						required: "<?php echo addslashes(translate("validation.password_required")); ?>",
						maxlength: "<?php echo addslashes(translate("validation.password_length")); ?>"
					},
					"confirmpwd": {
						required: "<?php echo addslashes(translate("validation.confirm_required")); ?>",
						equalTo: "<?php echo addslashes(translate("validation.confirm_match")); ?>",
						maxlength: "<?php echo addslashes(translate("validation.confirm_length")); ?>"
					},
					"fullname": {
						required: "<?php echo addslashes(translate("validation.fullname_required")); ?>",
						maxlength: "<?php echo addslashes(translate("validation.fullname_length")); ?>"
					},
					"email": {
						required: "<?php echo addslashes(translate("validation.email_required")); ?>",
						maxlength: "<?php echo addslashes(translate("validation.email_length")); ?>",
						email: "<?php echo addslashes(translate("validation.email_invalid")); ?>"
					}
				}
			});
		});
	</script>
</head>
<body>
<?php
if (isset($_POST["action"]) && $_POST["action"] == "setup") {
	// success!
	?>
	<p>
		<?php echo translateFormat("setup.success", '<a href="login.php">' . htmlspecialchars(translate("setup.login_link")) . '</a>'); ?>
	</p>
	<p>
		<?php echo htmlspecialchars(translate("setup.config_values")); ?>
	</p>
	<table border="1" cellpadding="2" cellspacing="2">
		<?php
		foreach ($opt as $key => $value) {
			?>
			<tr>
				<td><?php echo $key; ?></td>
				<td><?php echo $value; ?></td>
			</tr>
			<?php
		}
		?>
	</table>
	<?php
}
else {
	// check their image_subdir for writeability.
	echo "<p>";
	$parts = pathinfo($_SERVER["SCRIPT_FILENAME"]);
	$image_dir = $parts['dirname'] . "/" . $opt["image_subdir"];
	$writeable = is_writable($image_dir);
	if ($writeable) {
		echo "<font color=\"green\">" . htmlspecialchars(translateFormat("setup.image_writable", $image_dir)) . "</font>";
	}
	else {
		echo "<font color=\"red\">" . htmlspecialchars(translateFormat("setup.image_not_writable", $image_dir)) . "</font>";
	}
	echo "</p>";

	// check if Smarty works.
	echo "<p>" . htmlspecialchars(translate("setup.smarty_test")) . "</p>";
	require_once(dirname(__FILE__) . "/includes/MySmarty.class.php");
	$smarty = new MySmarty();
	$smarty->testInstall();
	?>
	<form name="setupform" id="setupform" method="post" action="setup.php">	
		<input type="hidden" name="action" value="setup">
		<div align="center">
			<table cellpadding="3" class="partbox">
				<tr>
					<td colspan="2" class="partboxtitle" align="center"><?php echo htmlspecialchars(translate("setup.title")); ?></td>
				</tr>
				<tr>
					<td colspan="2">
						<p>
							<?php echo htmlspecialchars(translate("setup.incomplete")); ?>
						</p>
					</td>
				</tr>
				<tr>
					<td><?php echo htmlspecialchars(translate("setup.admin_username")); ?></td>
					<td>
						<input id="username" name="username" size="20" maxlength="20" type="text" value="<?php if (isset($_POST["username"])) echo htmlspecialchars($_POST["username"]); ?>"/>
					</td>
				</tr>
				<tr>
					<td><?php echo htmlspecialchars(translate("setup.admin_password")); ?></td>
					<td>
						<input id="pwd" name="pwd" size="20" maxlength="50" type="password" />
					</td>
				</tr>
				<tr>
					<td><?php echo htmlspecialchars(translate("setup.admin_confirm")); ?></td>
					<td>
						<input id="confirmpwd" name="confirmpwd" size="20" maxlength="50" type="password" />
					</td>
				</tr>
				<tr>
					<td><?php echo htmlspecialchars(translate("setup.admin_fullname")); ?></td>
					<td>
						<input id="fullname" name="fullname" size="30" maxlength="50" type="text" value="<?php if (isset($_POST["fullname"])) echo htmlspecialchars($_POST["fullname"]); ?>" />
					</td>
				</tr>
				<tr>
					<td><?php echo htmlspecialchars(translate("setup.admin_email")); ?></td>
					<td>
						<input id="email" name="email" size="30" maxlength="255" type="text" value="<?php if (isset($_POST["email"])) echo htmlspecialchars($_POST["email"]); ?>" />
					</td>
				</tr>
				<tr valign="top">
					<td><?php echo htmlspecialchars(translate("setup.family_name")); ?></td>
					<td>
						<input id="familyname" name="familyname" size="50" maxlength="255" type="text" value="<?php if (isset($_POST["familyname"])) echo htmlspecialchars($_POST["familyname"]); ?>" />
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="<?php echo htmlspecialchars(translate("setup.submit")); ?>" />
					</td>
				</tr>
			</table>
		</div>
	</form>
	<?php
}
?>
</body>
</html>

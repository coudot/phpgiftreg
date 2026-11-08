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

$opt = getGlobalOptions();

function dbh($opt) {
	return new PDO($opt["pdo_connection_string"], $opt["pdo_username"], $opt["pdo_password"]);
}

$stmt = dbh($opt)->prepare("SELECT COUNT(*) AS user_count FROM {$opt["table_prefix"]}users");
$stmt->execute();
if ($row = $stmt->fetch()) {
	$user_count = $row["user_count"];
	if ($user_count != 0) {
		die("La base de données a déjà été configurée.");
	}
}
else {
	die("La base de données n'a pas été créée.");
}

if (isset($_POST["action"])) {
	if ($_POST["action"] == "setup") {
		$username = $_POST["username"];
		$fullname = $_POST["fullname"];
		$pwd = $_POST["pwd"];
		$email = $_POST["email"];
		$familyname = $_POST["familyname"];
		if (trim($familyname) == "") {
			$familyname = "Famille par défaut";
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
		else die("Aucune famille n'a été créée.");

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
		else die("Aucun utilisateur n'a été créé.");

		// 5. create the membership.
		$stmt = dbh($opt)->prepare("INSERT INTO {$opt["table_prefix"]}memberships(userid,familyid) VALUES(?, ?)");
		$stmt->bindParam(1, $userid, PDO::PARAM_INT);
		$stmt->bindParam(2, $familyid, PDO::PARAM_INT);
		$stmt->execute();
	}
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
	<title>Liste de cadeaux - Configuration</title>
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
						required: "Le nom d'utilisateur initial est obligatoire.",
						maxlength: "Le nom d'utilisateur initial ne doit pas dépasser 20 caractères."
					},
					"pwd": {
						required: "Le mot de passe initial est obligatoire.",
						maxlength: "Le mot de passe initial ne doit pas dépasser 50 caractères."
					},
					"confirmpwd": {
						required: "Cette valeur est obligatoire.",
						equalTo: "Ce mot de passe doit correspondre au mot de passe initial.",
						maxlength: "Cette valeur ne doit pas dépasser 50 caractères."
					},
					"fullname": {
						required: "Le nom complet est obligatoire.",
						maxlength: "Le nom complet ne doit pas dépasser 50 caractères."
					},
					"email": {
						required: "L'adresse courriel est obligatoire.",
						maxlength: "L'adresse courriel ne doit pas dépasser 255 caractères.",
						email: "L'adresse courriel n'est pas valide."
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
		Merci d'avoir configuré la liste de cadeaux. Vous pouvez maintenant <a href="login.php">vous connecter</a> et commencer !
	</p>
	<p>
		Vous trouverez ci-dessous les valeurs de configuration. Pour les modifier, éditez le fichier config.php, qui décrit la fonction de chaque valeur.
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
		echo "<font color=\"green\">Le répertoire $image_dir est accessible en écriture ; vous pouvez téléverser des images.</font>";
	}
	else {
		echo "<font color=\"red\">Le répertoire $image_dir n'est PAS accessible en écriture ; vous ne pouvez pas téléverser d'images. Modifiez ses permissions pour autoriser le serveur Web à y écrire, ou désactivez le téléversement d'images dans config.php.</font>";
	}
	echo "</p>";

	// check if Smarty works.
	echo "<p>Vérification de l'installation de Smarty... assurez-vous que le résultat est correct.</p>";
	require_once(dirname(__FILE__) . "/includes/MySmarty.class.php");
	$smarty = new MySmarty();
	$smarty->testInstall();
	?>
	<form name="setupform" id="setupform" method="post" action="setup.php">	
		<input type="hidden" name="action" value="setup">
		<div align="center">
			<table cellpadding="3" class="partbox">
				<tr>
					<td colspan="2" class="partboxtitle" align="center">Configurer la liste de cadeaux</td>
				</tr>
				<tr>
					<td colspan="2">
						<p>
							L'installation de la liste de cadeaux n'est pas terminée. Créez le compte administrateur initial, nommez la famille par défaut, puis cliquez sur Envoyer.
						</p>
					</td>
				</tr>
				<tr>
					<td>Nom d'utilisateur administrateur</td>
					<td>
						<input id="username" name="username" size="20" maxlength="20" type="text" value="<?php if (isset($_POST["username"])) echo htmlspecialchars($_POST["username"]); ?>"/>
					</td>
				</tr>
				<tr>
					<td>Mot de passe administrateur</td>
					<td>
						<input id="pwd" name="pwd" size="20" maxlength="50" type="password" />
					</td>
				</tr>
				<tr>
					<td>Confirmer le mot de passe administrateur</td>
					<td>
						<input id="confirmpwd" name="confirmpwd" size="20" maxlength="50" type="password" />
					</td>
				</tr>
				<tr>
					<td>Nom complet de l'administrateur</td>
					<td>
						<input id="fullname" name="fullname" size="30" maxlength="50" type="text" value="<?php if (isset($_POST["fullname"])) echo htmlspecialchars($_POST["fullname"]); ?>" />
					</td>
				</tr>
				<tr>
					<td>Adresse courriel de l'administrateur</td>
					<td>
						<input id="email" name="email" size="30" maxlength="255" type="text" value="<?php if (isset($_POST["email"])) echo htmlspecialchars($_POST["email"]); ?>" />
					</td>
				</tr>
				<tr valign="top">
					<td>Nom de la famille par défaut</td>
					<td>
						<input id="familyname" name="familyname" size="50" maxlength="255" type="text" value="<?php if (isset($_POST["familyname"])) echo htmlspecialchars($_POST["familyname"]); ?>" />
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="Envoyer" />
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

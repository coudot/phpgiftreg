<?php
/// This program is free software; you can redistribute it and/or modify
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

require_once(dirname(__FILE__) . "/includes/funcLib.php");
require_once(dirname(__FILE__) . "/includes/MySmarty.class.php");
$smarty = new MySmarty();
$opt = $smarty->opt();

if (isset($_POST["action"]) && $_POST["action"] == "forgot") {
	$username = $_POST["username"];

	try {
		// make sure that username is valid 
		$stmt = $smarty->dbh()->prepare("SELECT email FROM {$opt["table_prefix"]}users WHERE username = ?");
		$stmt->bindParam(1, $username, PDO::PARAM_STR);
			
		$stmt->execute();
		if ($row = $stmt->fetch()) {
			$email = $row["email"];
		
			if ($email == "")
				$error = "Aucune adresse courriel n'est associée au nom d'utilisateur « " . $username . " » ; le mot de passe n'a pas pu être envoyé.";
			else {
				$pwd = generatePassword($opt);
				$stmt = $smarty->dbh()->prepare("UPDATE {$opt["table_prefix"]}users SET password = {$opt["password_hasher"]}(?) WHERE username = ?");
				$stmt->bindParam(1, $pwd, PDO::PARAM_STR);
				$stmt->bindParam(2, $username, PDO::PARAM_STR);

				$stmt->execute();
				mail(
					$email,
					"Réinitialisation du mot de passe de la liste de cadeaux",
					"Informations de votre compte de liste de cadeaux :\r\n" .
						"Votre nom d'utilisateur est « " . $username . " » et votre nouveau mot de passe est « $pwd ».",
					"From: {$opt["email_from"]}\r\nReply-To: {$opt["email_reply_to"]}\r\nX-Mailer: {$opt["email_xmailer"]}\r\n"
				) or die("Courriel non accepté pour $email");
			}
		}
		else {
			$error = "Le nom d'utilisateur « " . $username . " » est introuvable.";
		}

		if (!empty($error)) {
			$smarty->assign('error', $error);
		}
		$smarty->assign('action', $_POST["action"]);
		$smarty->assign('username', $username);
		$smarty->display('forgot.tpl');
	}
	catch (PDOException $e) {
		die("Erreur SQL : " . $e->getMessage());
	}
}
else {
	$smarty->display('forgot.tpl');
}
?>

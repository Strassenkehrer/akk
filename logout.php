<?php
  $id="logout";
  header('refresh:1;url=http://logoutfromakk@' . $_SERVER['HTTP_HOST'] . '/');
  ini_set('include_path', 'inc');
  include("head.php");
  echo "Logout - bitte das Passwortfenster abbrechen";
  include("footer.php");
?>

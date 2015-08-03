<?php
  $id="passwd";
  ini_set('include_path', 'inc');
  include("head.php");
  include_once("passwdfkt.php");
?>

<?php
  function pPassForm()
  {

    echo "<p><form method='post' action='passwd.php'>\n";
    echo "<table>";
    echo "<tr><td>Username</td>";
    echo "<td><input type='text' name='user' size=10 readonly value='" . $_SERVER["REMOTE_USER"] . "'></td></tr>\n";
    echo "<tr><td>Passwort alt</td>";
    echo "<td><input type='password' name='pass1' size=20></td></tr>\n";
    echo "<tr><td>Passwort neu</td>";
    echo "<td><input type='password' name='pass2' size=20></td></tr>\n";
    echo "<tr><td>Wiederholung</td>";
    echo "<td><input type='password' name='pass3' size=20></td></tr>\n";
    echo "</table>";
    echo "<input type='submit' name='submit_pass1' value='OK'>\n";
    echo "</form></p>\n";
  }

  function pPassSet($User,$Pass1,$Pass2)
  {
    $res=pCheckPasswd($User,$Pass1);
    if ($res>0)
    {
      die("Nanu, User ist nicht konfiguriert");
      return;
    }
    if ($res<0)
    {
      errmsg("Das alte Passwort ist falsch");
      pPassForm();
      return;
    }
    pSetPasswd($User,$Pass2);
    echo "<p>Das Passwort wurde erfolgreich gesetzt</p>\n";
    return;
  }

  $User="";
  $Pass1="";
  $Pass2="";
  $Pass3="";

  if (isset($_POST['user']))
  {
    $User=preg_replace("/[^0-9a-zA-Z]/","",$_POST['user']);
  }
  if (isset($_POST['pass1']))
  {
    $Pass1=preg_replace($pass_chr,"",$_POST['pass1']);
    if ($Pass1=="")
       errmsg("Das alte Passwort muss angegeben werden");
  }
  if (isset($_POST['pass2']))
  {
    $Pass2=preg_replace($pass_chr,"",$_POST['pass2']);
    if ($Pass2 != $_POST['pass2'])
    {
      errmsg($pass_err);
      $Pass2="";
    }
    else if ($Pass2=="")
      errmsg("Es muss ein neues Passwort angegeben sein");
  }
  if (isset($_POST['pass3']))
  {
    $Pass3=preg_replace($pass_chr,"",$_POST['pass3']);
    if ($Pass3=="" && $Pass2!="")
       errmsg("Das Passwort muss wiederholt werden");
    else if ($Pass3 != $Pass2 && $Pass2!="")
    {
       errmsg("Die Wiederholung stimmt nicht mit dem neuen Passwort &uuml;berein");
       $Pass3="";
    }
  }
  if (isset($_POST['submit_pass1']) && $_POST['submit_pass1'] = 'OK' &&
      $User!="" && $Pass1!="" && $Pass2!="" && $Pass3!="")
  {
    if ($User != $_SERVER["REMOTE_USER"])
      die("You are using this formular under abnormal conditions ;)");
    else
      pPassSet($User,$Pass1,$Pass2);
  }
  else
    pPassForm();
?>

<?php
  include("footer.php");
?>

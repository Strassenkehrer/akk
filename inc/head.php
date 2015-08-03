<?php header("Content-Type: text/html; charset=utf-8"); ?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="de">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>Akk <?php print $website[$id]['titel']; ?></title>
<link rel="shortcut icon" href="/favicon.ico" >
<link rel="stylesheet" type="text/css" href="/css/akk.css" media="screen">
<link rel="stylesheet" type="text/css" href="/css/print.css" media="print">
<!-- DO NOT REMOVE THIS
Hier steht ein Dank an Wilm, der das erste Akk-Tool überhaupt für die Piratenpartei programmiert hat,
und an Hendrik und Sebastian, die die Akkreditierung immer reibungslos zum Laufen gebracht haben.
Das Akk-tool wurde zum ersten Mal auf dem BPT 12.2 in Offenbach eingesetzt.
Es steht unter beerware-lizenz - denkt daran, wenn ihr sie seht.
Es wurde neu geschrieben, weil inzwischen neue Dinge dazugekommen sind.
END -->
</head>
<body onload="if(document.getElementById('mnr')) document.getElementById('mnr').focus(); if(document.getElementById('zahlbetrag')) document.getElementById('zahlbetrag').focus();">
<div id = "wrapper">
<div id = "titel">
<?php
if ($id == "about") {
    echo "<h1>" . $website[$id]['text']. "</h1>\n";
}
else {
    ($id == "start" ) ? $br=" " : $br = "<br>";
    echo "<h1>" . $website[$id]['text'] . $br . $info->veranstaltung . " " . $info->ort . " / " . $info->akkuser . "</h1>\n";
}
include ("menu.php");
if ($action == "akk") {include("searchform.php");}
if ($h2 != "") { echo "<h2>".$h2."</h2>\n";}
?>
</div> <!-- titel -->
<div id = "result">
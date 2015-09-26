<?php
$id="statistik";
ini_set('include_path', 'inc');
include("db.php");
include("define.php");
include("head.php");
$db = new mydb();
if ($info->ebene == "LV")
{
  $selebene="kv";
  $selhead="KV";
} else if ($info->ebene == "KV") {
  $selebene="ort";
  $selhead="Ort";
}
else
{
  $selebene="lv";
  $selhead="LV";
}

$sql = "select lv, kv, ort, count(akkId) AS mitglieder,sum(akk) as akkreditiert,
               sum(offenerbeitrag<1) AS stimmb
        from tblakk group by " . $selebene . " order by " . $selebene . "";
$q=$db->query($sql);
echo "<table>\n";
echo "<tr><thead><th>" . $selhead . "</th><th>Mitglieder</th><th>Stimmberechtigte</th><th>%</th><th>Akkreditierte</th><th>Akk. Mitglieder</th><th>Akk. Stimmb.</th></tr></thead>\n";
echo "<tbody>";
while ($row=$q->fetch()) {
    
    echo "<tr>";
    if ($row[$selebene]=="")
      td($row['lv']);
    else
      td($row[$selebene]);
    td($row['mitglieder'],"r");
    td($row['stimmb'],"r");
    if ($row['mitglieder'] == 0)
      td("");
    else
      td(number_format(100 * $row['stimmb'] / $row['mitglieder'],2) . " %","r");
    td($row['akkreditiert'],"r");
    if ($row['mitglieder'] == 0)
      td("");
    else
      td(number_format(100 * $row['akkreditiert'] / $row['mitglieder'],2) . " %","r");
    if ($row['stimmb'] == 0)
      td("");
    else
      td(number_format(100 * $row['akkreditiert'] / $row['stimmb'],2) . " %","r");

    echo "</tr>\n";
}
echo "</tbody>\n";
$sql = "select count(akkId) AS mitglieder,sum(akk) as akkreditiert,
               sum(offenerbeitrag<1) AS stimmb
        from tblakk";
$row = $db->query($sql)->fetch();
echo "<tfoot><tr>";
td("Summe");
td($row['mitglieder'],"r");
td($row['stimmb'],"r");
if ($row['mitglieder'] == 0)
  td("");
else
  td(number_format(100 * $row['stimmb'] / $row['mitglieder'],2) . " %","r");
td($row['akkreditiert'],"r");
if ($row['mitglieder'] == 0)
  td("");
else
  td(number_format(100 * $row['akkreditiert'] / $row['mitglieder'],2) . " %","r");
if ($row['stimmb'] == 0)
  td("");
else
  td(number_format(100 * $row['akkreditiert'] / $row['stimmb'],2) . " %","r");
echo "</tr></tfoot></table>\n";
include("footer.php");
?>

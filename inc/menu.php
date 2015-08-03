<?php 
echo "<ul>\n";
href("start", $id, "li", "");
href("statistik", $id, "li", "");
if ($id != "start") {
    if ($info->akkrolle == 9) href("mneu",$id,"li","");
    if ($info->akkrolle == 9) href("einnahmen",$id,"li","");
    if ($info->akkrolle == 9) href("user",$id,"li","");
    href("passwd",$id,"li","");
}
href("logout",$id,"li","");
echo "</ul>\n";
?>

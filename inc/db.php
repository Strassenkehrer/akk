<?php
class mydb extends PDO
{
    public function __construct($file = 'akk.ini')
    {
        if (!$settings = parse_ini_file($file, TRUE)) throw new exception('Unable to open ' . $file . '.');

        $dns = $settings['database']['driver'] .
        ':host=' . $settings['database']['host'] .
        ((!empty($settings['database']['port'])) ? (';port=' . $settings['database']['port']) : '') .
        ';dbname=' . $settings['database']['db'];
        $options  = array ( PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8' );
        parent::__construct($dns, $settings['database']['username'], $settings['database']['password'], $options);
    }
}
class allginfo
{
    public $veranstaltung;
    public $datum;
    public $ort;
    public $akkuser;
    public $akkrolle;
    public $rootdir;
    public $ebene;

    function __construct($file = 'akk.ini')
    {
        $db = new mydb();

        $file = 'akk.ini';
        if (!$settings = parse_ini_file($file, TRUE)) throw new exception('Unable to open ' . $file . '.');
        $this->veranstaltung = $settings['akk']['Veranstaltung'];
        $this->datum = $settings['akk']['Datum'];
        $this->ort = $settings['akk']['Ort'];
        $this->ebene = $settings['akk']['Ebene'];
/*
        $this->rootdir = $settings['system']['rootdir'];
        $this->akkuser = $_SERVER["REMOTE_USER"];

        $userres=$db->query("SELECT rolle FROM tbluser WHERE login=" . $db->quote($this->akkuser))->fetch();
        if ($userres==NULL) die("User ist kaputt");
        $this->akkrolle=$userres['rolle'];
        if ($this->akkrolle==0) die("User ist gesperrt");
*/
$this->akkuser =  'admin';
$this->akkrolle=9;
    }
}

?>


using module "C:\Users\linusniederer.OPACC\myCloud\Projekte\Aktuell\GitHub.com\powershell-library\src\classes\class-database.psm1"

<# gerneral database options #>
$dbhost = "localhost"
$dbuser = "root"
$dbpass = ""
$dbport = 3306

$dbname = "test"
$test = [Database]::new($dbhost, $dbname, $dbuser, $dbpass, $true )

$dbname = "fabilu"
$fabilu = [Database]::new($dbhost, $dbname, $dbuser, $dbpass )

<# test Methods from database class #>


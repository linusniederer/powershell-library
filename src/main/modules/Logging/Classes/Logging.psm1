Class Logging {

    [boolean] $writeFile;
    [String] $logPath;

     <#
     # Constructor of Logging Class
     # @param [String] value Log message
     #>
     Logging () {
        $this.writeFile = false;
        $this.logPath = null;
    }

    

}
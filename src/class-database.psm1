class Database {

    <# Class Attributes #>
    [string] $databaseHost
    [string] $databaseName
    [string] $databaseUser
    [string] $databasePassword
    [int] $databasePort
    [object] $databaseConnection

    <# Initialize Constructor #>
    Database ( $dbHost, $dbName, $dbUser, $dbPass, $dbPort ) {
        $this.databaseHost = $dbHost
        $this.databaseName = $dbName
        $this.databaseUser = $dbUser
        $this.databasePassword = $dbPass
        $this.databasePort = $dbPort
    }

    <# Initialize Database Connection #>
    [object] connect () {

        # Import MySql Connector from .Net Framework
        [void][system.reflection.Assembly]::LoadWithPartialName("MySql.Data") 

        <# Collect Server Informations #>
        $connectionInformation = "
            server="    + $this.databaseHost + ";
            port="      + $this.databasePort + ";
            uid="       + $this.databaseUser + ";
            pwd="       + $this.databasePassword + ";
            database="  + $this.databaseName + ";
            Pooling=FALSE" 

        <# Connect to database #>
        $connection = New-Object MySql.Data.MySqlClient.MySqlConnection( $connectionInformation ) 
        $connection.Open() 

        <# Return Connection as Object #>
        $this.databaseConnection = $connection
        return $connection
    } 

    <# Initialize Database Input #>
    [object] insert ( $sql ) {
        
        <# Create new Object #>
        $command = $this.databaseConnection.CreateCommand()
        $command.CommandText = $sql 
        $insert = $command.ExecuteNonQuery()       
        $command.Dispose() 

        <# Return Connection as Object #>
        return $insert
    }
}
class Database {

    [string] $dbHost
    [string] $dbName
    [string] $dbUser
    hidden [string] $dbPass
    [int] $dbPort = 3306
    [object] $dbConnection

    <# DOC: Constructor of database class #>
    Database ( $dbHost, $dbName, $dbUser, $dbPass ) {
        $this.initialize( $dbHost, $dbName, $dbUser, $dbPass )
    }

    <# DOC: Constructor of database class with direct connection #>
    Database ( $dbHost, $dbName, $dbUser, $dbPass, [boolean] $connect ) {
        $this.initialize( $dbHost, $dbName, $dbUser, $dbPass )
        
        if ( $connect -eq $true) { 
            $this.connect() 
        }
    }

    <# INIT Method to overload constructors #>
    hidden initialize ( $dbHost, $dbName, $dbUser, $dbPass ) {
        $this.dbHost = $dbHost
        $this.dbName = $dbName
        $this.dbUser = $dbUser
        $this.dbPass = $dbPass
    }

    <# DOC: Method to create connection object #>
    [string] connect () {

        # Import MySql Connector from .Net Framework
        [void][system.reflection.Assembly]::LoadWithPartialName("MySql.Data") 

        <# Collect Server Informations #>
        $connectionInformation = "
            server="    + $this.dbHost + ";
            port="      + $this.dbPort + ";
            uid="       + $this.dbUser + ";
            pwd="       + $this.dbPass + ";
            database="  + $this.dbName + ";
            Pooling=FALSE" 

        <# Connect to database #>
        $connection = New-Object MySql.Data.MySqlClient.MySqlConnection( $connectionInformation ) 
        $connection.Open() 

        <# Return Connection as Object #>
        $this.dbConnection = $connection

        return $this.getConnectionState()
    } 

    <# DOC: Method to disconnect the database connection #>
    [string] disconnect () {
        $this.dbConnection = $this.dbConnection.Close()
        return $this.getConnectionState()
    }

    <# DOC: Method to inserert data into database #>
    [object] insert ( $sql ) {
        $command = $this.dbConnection.CreateCommand()
        $command.CommandText = $sql 
        $insert = $command.ExecuteNonQuery()       
        $command.Dispose() 

        return $insert
    }

    <# DOC: Method to get current state of connection #>
    [string] getConnectionState () {

        if ( $this.dbConnection -eq $null ) {
            return "closed"
        }

        return $this.dbConnection.State
    }

    <# DOC: Method to change database port #>
    [void] setPort ( [int] $dbPort ) {

    }
}
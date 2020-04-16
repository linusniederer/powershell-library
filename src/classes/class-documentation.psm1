# TODO: Klasse Dokumentation fertigstellen 
class Documentation {

    [string] $docPath
    [string] $docName = "Documentation"
    [string] $scriptPath

    # DOC: Klasse dokumentieren 
    Documentation ( $docPath, $scriptPath ) {
        
        $this.docPath = $docPath
        $this.scriptPath = $scriptPath

        $this.create()
    }

    # create documentation
    hidden create() {
        
        New-Item -Path $this.docPath -Name $this.docName -ItemType Directory -Force

        # Scan directories
        $directories = Get-ChildItem -Directory $this.scriptPath -Recurse

        foreach ($directroy in $directories ) {

            $dirPath = $directroy.FullName

            $files = Get-ChildItem -File $dirPath -Verbose

            foreach ( $file in $files ) {
                
            }
        }

    }

    
}
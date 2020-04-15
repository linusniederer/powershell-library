# TODO: Klasse Dokumentation fertigstellen 
class Documentation {

    [string] $docPath

    # DOC: Klasse dokumentieren 
    Documentation ( $path, [array] $files, [array] $folders ) {
        
        $this.docPath = $path

        foreach ( $file in $files ) {

        }
    }


}
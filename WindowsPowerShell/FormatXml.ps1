
#
# Author: Keith Hill
# Desc: CMDLET to pretty print XML
# Usage: This file contains a function-based CMDLET. In order to use it,
#	you must dot source the file into your shell, e.g.:
#		PoSH> . ~/WindowsPowerShell\FormatXml.ps1
#

function Format-Xml {
    param([string[]]$Path)

    begin {
        function PrettyPrintXmlString([string]$xml) {
            $tr = new-object System.IO.StringReader($xml);
            $settings = new-object System.Xml.XmlReaderSettings;
            $settings.CloseInput = $true;
            $settings.IgnoreWhitespace = $true;
            $reader = [System.Xml.XmlReader]::Create($tr, $settings);

            $sw = new-object System.IO.StringWriter;
            $settings = new-object System.Xml.XmlWriterSettings;
            $settings.CloseOutput = $true;
            $settings.Indent = $true;
            $writer = [System.Xml.XmlWriter]::Create($sw, $settings);

            while (!$reader.EOF) {
                $writer.WriteNode($reader, $false);
            }
            $writer.Flush();

            $result = $sw.ToString();
            $reader.Close();
            $writer.Close();
            $result;
        }

        function PrettyPrintXmlFile($path) {
            $rpath = resolve-path $path;
            $contents = gc $rpath;
            $contents = [string]::join([environment]::newline, $contents);
            PrettyPrintXmlString $contents;
        }

        function Usage() {
            ""
                "USAGE"
                "    Format-Xml -Path <pathToXmlFile>"
                ""
                "SYNOPSIS"
                "    Formats the XML into a nicely indented form (i.e., pretty  printed)."
                "    Outputs one <string> object for each XML file."
                ""
                "PARAMETERS"
                "    -Path <string[]>"
                "        Specifies path to one or more XML files to format with indentation."
                "        Pipeline input is bound to this parameter."
                ""
                "EXAMPLES"
                "    Format-Xml -Path foo.xml"
                "    Format-Xml foo.xml"
                "    gci *.xml | Format-Xml"
                "    [xml]`"<doc>...</doc>`" | Format-Xml"
                ""
        }
        if (($args[0] -eq "?") -or ($args[0] -eq "-help")) {
            Usage
        }
    }

    process {
        if ($_) {
            if ($_ -is [xml]) {
                PrettyPrintXmlString $_.get_OutputXml()
            }
            elseif ($_ -is [IO.FileInfo]) {
                PrettyPrintXmlFile $_.FullName
            }
            elseif ($_ -is [string]) {
                if (test-path -type Leaf $_) {
                    PrettyPrintXmlFile $_
                }
                else {
                    PrettyPrintXmlString $_
                }
            }
            else {
                throw "Pipeline input type must be one of: [xml], [string] or [IO.FileInfo]"
            }
        }
    }

    end {
        if ($Path) {
            foreach ($aPath in $Path) {
                PrettyPrintXmlFile $aPath
            }
        }
    }
}

# vim: set filetype=ps1:

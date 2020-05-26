# Define paths, extensions and processes to exclude here
# See documentation at https://conf.pe-international.com:8442/x/HQAR for explanations

# Feel free to change or add directories (you can also use this to add specific files like C:\temp\do_not_scan_this.file)
$exclusionPaths = 'C:\Program Files (x86)\Embarcadero', 'C:\dev'

# Processes are sorted by name according to the Confluence page linked above
$exclusionProcesses = 'bds.exe', 'brcc32.exe', 'copy.exe', 'dcc32.exe', 'dcc64.exe', 'dccosx.exe', 
'ecc32.exe', 'emake.exe', 'make.exe', 'msbuild.exe', 'xcopy.exe'

# Extensions are sorted by name according to the Confluence page linked above
$exclusionExtensions = 'bpl', 'csv', 'dcp', 'dcu', 'dfm', 'dproj', 'drc', 'DSB', 'fmx', 
'gabidb', 'gabidb-journal', 'GBM', 'GBMX', 'GBX', 'GCD', 'groupproj', 
'GSP', 'GUP', 'ilcd', 'inc', 'json', 'log', 'map', 'MYDB', 'pas', 'rc', 
'res', 'tscup', 'tsx', 'txt', 'xml'

function Main {
    "`n!!! RUN WITH ADMIN PRIVILEGES !!!`n"
    "The following elements will be excluded from Windows Defender scans"
    "(Note that exclusions listed here are *additive*, so no existing exclusions will be removed)`n"
    "# Paths`n$exclusionPaths`n"
    "# Processes`n$exclusionProcesses`n"
    "# Extensions`n$exclusionExtensions`n"

    if (ExecutionShouldContinue) {
        $error.clear()
        Add-MpPreference -ExclusionPath $exclusionPaths
        Add-MpPreference -ExclusionProcess $exclusionProcesses
        Add-MpPreference -ExclusionExtension $exclusionExtensions

        if (!$error) {
            ExitWithMessage "`nSuccessfully added Windows Defender exclusions"
        }
        else {
            ExitWithMessage "Tsss, I said 'Run as admin'..."
        }
    }
    else {
        ExitWithMessage "`nCancelled"
    }
}

function ExecutionShouldContinue {
    $title = 'Continue?'
    $question = 'Are you sure you want to proceed?'
    $choices = '&Yes', '&No'

    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
    if ($decision -eq 0) {
        return $true
    }
    else {
        return $false
    }
}

function Wait-For-Keypress {
    Write-Host -NoNewLine "`nPress any key to continue..."
    [Console]::ReadKey($true) | Out-Null
}

function ExitWithMessage([string]$messageToDisplay) {
    Write-Host $messageToDisplay
    Wait-For-Keypress
    Exit
}

Main

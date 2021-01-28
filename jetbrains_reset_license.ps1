[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $EvalFolder = "",
    $OtherXMLFile = ""
)

$ErrorActionPreference = "stop"

function SayGoodBye {
    Write-Host "* Goodbye my friend! And remember - Xiaomi is TRASH!" -ForegroundColor Blue
    exit
}
function CreateScheduleTask {    
    $JobName = "Reset JetBrains license"

    $Repeat = (New-TimeSpan -Days 20)
    $Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).Date -RepetitionInterval $Repeat
    $Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "$PSCommandPath -EvalFolder $EvalFolder -OtherXMLFile $OtherXMLFile"
    
    Register-ScheduledTask -TaskName $JobName -Trigger $Trigger -Action $Action -RunLevel Highest -Force
    Write-Host "Task was created successfully or not if you see error message below!"
}
function CheckFoldersExist($ItemPath) {
    $testResult = Test-Path -Path $ItemPath

    if ($testResult -eq $true) {
        Write-Host " + Your path was find!" -ForegroundColor Green
    }
    else {
        Write-Host " - Your path is incorrect!" -ForegroundColor Red
        SayGoodBye
    }
}
function DeleteItem($ItemPath) {
    Write-Host "// Let`s delete some files!" -ForegroundColor Blue
    
    try {
        Remove-Item $ItemPath
        Write-Host " + Complete" -ForegroundColor Green
    }
    catch {
        Write-Host " - OH NO! We can't delete this item - $ItemPath" -ForegroundColor Red
        SayGoodBye
    }
}
function RegularTaskQuestion {
    $taskDecision = Read-Host -Prompt "Create task for this script? [Yes / No]"
    $taskDecision.ToLower()
    
    if ($taskDecision -eq "yes") {
        CreateScheduleTask
        exit
    } if ($taskDecision -eq "no") {
        SayGoodBye
    }
    else {
        RegularTaskQuestion
    }
}
function StartScript {
    Write-Host "------ [ Let`s delete some files! ] ------" -ForegroundColor Yellow
    if ($EvalFolder -eq "") {
        $EvalFolder = Read-Host -Prompt "`nInput path for folder with eval files`n[ C:\Users\[Username]\AppData\Roaming\JetBrains\PhpStorm2020.2\eval ]"
    }

    CheckFoldersExist($EvalFolder)
    DeleteItem($EvalFolder)

    if ($OtherXMLFile -eq "") {
        $OtherXMLFile = Read-Host -Prompt "`nInput path for file with name 'other.xml'`n[ C:\Users\[Username]\AppData\Roaming\JetBrains\PhpStorm2020.2\options\other.xml ]"
    }

    CheckFoldersExist($OtherXMLFile)
    DeleteItem($OtherXMLFile)

    Write-Host "`n------ [ Schedule task section ] ------" -ForegroundColor Yellow
    RegularTaskQuestion
}

StartScript
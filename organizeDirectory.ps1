#parameters part✅
param([string]$source="C:\Users\jceyl\Bureau\Downloads\source", $destination="C:\Users\jceyl\Bureau\Downloads\destination")

#function part✅
function Check-Folder([string]$directory, [switch]$create)
{
    # check the existence of a specific directory passed as a param
    $exists = Test-Path -Path $directory
    if($exists)
    {
        $exists
    }
    else
    {
        if($create.IsPresent)
        {
            # create a new directory with the specified path
            $newItem = New-Item -Path $directory -ItemType Directory
            $true
        }
        else
        {
            $exists
        }
        
    }
}

function DisplayFolderStatistics([string]$directory)
{
    # display folder stats for a directory/path passed as a param
    $files = dir $directory 
    write-host "Directory name: " $files.DirectoryName[0] # write name
    $filesObject = $files | measure-object
    write-host "Number of files in the folder: " $filesObject.Count # write number of files in the folder
    $size = Get-ChildItem $directory -Recurse | Measure-Object -Property Length -Sum
    write-host "Total Size: " $size.Sum
}

#main processing part✅
# copy each of the file in source to the right folder inside destination
$files = dir $source

foreach($_ in $files) {
    $sourcePath = $_.FullName
    $destinationPath = $destination+"\"+$_.extension.Remove(0,1)
    $exists = Check-Folder -Create -directory $destinationPath
    Move-Item -Path $sourcePath -Destination $destinationPath
    write-host "Copying file at $sourcePath to $destinationPath"
    DisplayFolderStatistics -directory $destinationPath
}

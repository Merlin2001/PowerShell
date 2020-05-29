# Enter the path here (files in all subdirectories should be touched, too)
$path="C:\Temp\demo\*.xml"

# Convert each file matching the filter above to lower case
Get-ChildItem $path -Recurse | ForEach-Object{    
    (Get-Content $_.FullName).ToLower() | Out-File $_.FullName
}
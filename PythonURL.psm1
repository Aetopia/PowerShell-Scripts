function Start-PythonURL {
param ($URL)
    $PythonFile = (Invoke-RestMethod $URL)
    $PythonFile | Set-Content "$env:TEMP\temp.py"
    py.exe "$env:TEMP\temp.py"
}
Export-ModuleMember -Function Start-PythonURL
$CSVPath="C:\Temp\CSV.csv"
$CSV=Import-Csv -Path $CSVPath

$wrongCSVPath="C:\Temp\wrongCSV.csv"
$wrongCSV=Import-Csv -Path $wrongCSVPath

$CSV

$wrongCSV

$wrongCSV.count



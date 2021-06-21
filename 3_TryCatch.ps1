try{
    Import-Module -Name test -Scope Local -Global  # no need to specify ErrorAction
}
catch{
    "An error occurred"
}
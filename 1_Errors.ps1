
Get-ChildItem c:\dummydir #non-terminating

"Script continues after 1st error"

Import-Module -Name test -Scope Local -Global  #should be terminating

"Script continues after 2nd error"

1/0 #should also be terminating

"Script continues after 3rd error"

#foreach ( # the only really terminating error

#"Script continues after 4th error"

throw "A real terminating error"

"Script continues after throw statement"
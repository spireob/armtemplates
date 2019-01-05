Configuration ContosoWebsite
{
  param ($MachineName)

  Node $MachineName
  {
    #Install the IIS Role
    WindowsFeature IIS
    {
      Ensure = "Present"
      Name = "Web-Server"
    }

    #Install ASP.NET 4.5
    WindowsFeature ASP
    {
      Ensure = "Present"
      Name = "Web-Asp-Net45"
    }

     WindowsFeature WebServerManagementConsole
    {
        Name = "Web-Mgmt-Console"
        Ensure = "Present"
    }
	
	Script DownloadWebPage
    {
        GetScript = {
            @{
                Result = "WebPIInstall"
            }
        }
        TestScript = {
            Test-Path "C:\inetpub"
        }
        SetScript ={
            $source = "https://raw.githubusercontent.com/spireob/armtemplates/master/Tyd13dsc/mypage.htm"
            $destination = "C:\inetpub\wwwroot\mypage.htm"
            Invoke-WebRequest $source -OutFile $destination
       
        }
    }
  }
} 
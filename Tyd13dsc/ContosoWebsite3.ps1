Configuration ContosoWebsite3
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
	
    Script DownloadWeb
    {
            GetScript = 
            {
                @{
                    GetScript = $GetScript
                    SetScript = $SetScript
                    TestScript = $TestScript
                    Result = ('True' -in (Test-Path "C:\inetpub\wwwroot\mypage.htm"))
                }
            }

            SetScript = 
            {
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/spireob/armtemplates/master/Tyd13dsc/mypage.htm" -OutFile "C:\inetpub\wwwroot\mypage.htm"
            }

            TestScript = 
            {
                $Status = ('True' -in (Test-Path "C:\inetpub\wwwroot\mypage.htm"))
                $Status -eq $True
            }
     }
  }
} 
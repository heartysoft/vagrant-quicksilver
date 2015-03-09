
node 'win-2008r2-std' {
     quicksilver::qs_baseline { 'qs':
     }
     ->
     quicksilver::web_baseline { 'qsweb':
         msdeploy_path => 'c:\vagrant\WebDeploy_amd64_en-US.msi'
     }
    ->
    iis::manage_app_pool {'MyWebAppForDeploymentAppPool':
      enable_32_bit           => true,
      managed_runtime_version => 'v4.0',
    }
    ->
    iis::manage_site {'MyWebAppForDeployment':
      site_path     => 'C:\inetpub\wwwroot\MyWebAppForDeployment',
      port          => '8057',
      ip_address    => '*',
      #host_header   => 'www.mysite.com',
      app_pool      => 'MyWebAppForDeploymentAppPool'
    }->
    quicksilver::qs_website{ 'MyWebAppForDeployment':
        environment => "qa",
        publishroot => "c:\\vagrant",    
        version => "v0.11"
    }
}
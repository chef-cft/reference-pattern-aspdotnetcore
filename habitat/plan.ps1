$pkg_name="nop-commerce"
$pkg_origin="devopslifter"
$pkg_version="0.1.0"
$pkg_maintainer="Tom Finch tfinch@chef.io"
$pkg_license=@("MIT")
$pkg_upsteam_url="https://github.com/devopslifter/nopCommerce"
$pkg_description="NOP Commerce ASP.net core app"

# Where the running service variable data is located - simplified run, no need for hook
$pkg_svc_run="cd $pkg_svc_var_path;dotnet nop.web.dll"  

$pkg_deps=@("core/dotnet-core")
$pkg_build_deps=@("core/dotnet-core-sdk")


$pkg_exports=@{
    "port"="port"
}



$pkg_binds_optional=@{
  "database"="username password port instance"
}

function Invoke-SetupEnvironment {
  Set-RuntimeEnv "HAB_CONFIG_PATH" $pkg_svc_config_path
}

function Invoke-Build{
  cp $PLAN_CONTEXT/../* $HAB_CACHE_SRC_PATH/$pkg_dirname -recurse -force
  & "$(Get-HabPackagePath dotnet-core-sdk)\bin\dotnet.exe" restore $HAB_CACHE_SRC_PATH/$pkg_dirname/src/NopCommerce.sln
  & "$(Get-HabPackagePath dotnet-core-sdk)\bin\dotnet.exe" build $HAB_CACHE_SRC_PATH/$pkg_dirname/src/NopCommerce.sln
  if($LASTEXITCODE -ne 0) {
      Write-Error "dotnet build failed!"
  }
}

function Invoke-Install {
  & "$(Get-HabPackagePath dotnet-core-sdk)\bin\dotnet.exe" publish $HAB_CACHE_SRC_PATH/$pkg_dirname/src/presentation/nop.web/nop.web.csproj --output "$pkg_prefix/www"
}
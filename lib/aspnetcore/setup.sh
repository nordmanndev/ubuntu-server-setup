function setupAspnetcore(){

    sudo apt-get update && sudo apt-get install -y aspnetcore-runtime-6.0
    ## sudo apt-get install -y dotnet-runtime-6.0 (optional if full runtime is needed)
    dotnet --info

}
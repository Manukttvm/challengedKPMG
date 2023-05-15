#aUTHOR: Manoj

#PARAMETERSDEFINITION

[CmdletBinding()]
Param(
    
       [Parameter(Mandaroey=$true)]
       [String] $metadata,

       [String] $datakey #optionalparamater
       )

Try {

#First Retrieve the token for getting the metedata

$Token = Invoke-WebRequest -Method PUT -Uri "http://169.254.169.254/latest/api/token" -Headers "X-aws-ec2-metadata-token-ttl-seconds: 21600"


#Fetch the metadata with the token and if datakey value is supplied
if($datakey){
        $output = Invoke-WebRequest -Method Get -Uri "http://169.254.169.254/latest/$METADATA/$DATAKEY" -Headers "X-aws-ec2-metadata-token: $TOKEN"

        Write-Host "The requested details are $output"
}

#Fetching the metadata when datakey is not provided

else{
    $output = Invoke-WebRequest -Method Get -Uri "http://169.254.169.254/latest/$METADATA" -Headers "X-aws-ec2-metadata-token: $TOKEN"

    Write-Host "The requested details are $output"
}
}

CATCH{

    Write-Host "Message: [$($_.Exception.Message)"]
}
#aUTHOR: Manoj

#PARAMETERSDEFINITION

Funtion objectsearch{

    [CmdletBinding()]
    Param(
    
           [Parameter(Mandatory=$true)]
           [String] $object,

           [Parameter(Mandatory=$true)]
           [String] $key #optionalparamater
           )

    Try{
    #checkk if keyvalue is passed
    If($key){
        $keyval = $key.Split('/')
    }
    else{
        exit 1
    }

    #length of the object passed

    $obl = $object.Length

    #Lenght of Keyval

    $kl = $keyval.Length

    #Iterating throght the object to get the alphabets

    for ($test = 0; $test -lt 26; $test++)
    {
        $alpha = [char](65+ $test)
        if($Debug = true){
           Write-Host "alphabet is $alpha"
           }

       for ($obnum = 0; $obnum -le ($obl-1); $obnum++){

          If ($object[$obnum] -eq $alpha){
            $ResultObject += $object[$obnum]
            }
        }

    }

        if($Debug = true){
           Write-Host "Resultobject is  $ResultObject"
           }

    #lENGHT OF RESULT OBJECT
    $ROL = $ResultObject.Length

    #Matching the Key and Final result

    for ($num=0; $num -le ($k-1) ; $num++){

        for ($obnum = 0 ; $obnum -le ($ROL-1); $OBNUM++){
            IF ($ResultObject[$obnum] -eq $keyval[$num])
              {
                if ($obnum -eq $num){

                  $validate += $obnum
                  }
            Write-Host "matchfound key $obnum $num"
            }

        }
    }

    for ($v = 1; $v -le 3; $v++){

        if ($validate[$v-1] -eq $v){

         $result = o
         }

         else
         {
         result=1
         }
    }

    if ($result = 1){

        Write-Host "Value is A"
        }
    }
    catch{
    }
}
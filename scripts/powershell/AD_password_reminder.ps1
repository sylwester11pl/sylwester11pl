# AD password reminder
# autor: Patryk Basko

# Deklaracja zmiennych
$OU_DC = "OU=LAB-users,DC=pb,DC=lab" #ustaw pod siebie, jesli masz wiecej OU to dodaj na zasadzie OU=xxx,OU=yyy, analogicznie z DC

# Pobierz użytkowników
$users = Get-ADUser -Filter * -SearchBase $OU_DC -Properties PwdLastSet, "msDS-UserPasswordExpiryTimeComputed" | 
Sort-Object Name

# DEBUG - w przypadku recznego odpalenia dostaniesz output na terminal
function DEBUG {
Write-Host `n"DEBUG - traktuj jako podlgadowa podczas recznego odpalania skryptu!!"`n
Get-ADUser -Filter * -SearchBase $OU_DC -Properties PwdLastSet, "msDS-UserPasswordExpiryTimeComputed" | 
Sort-Object Name | 
Select-Object Name, @{Name='PwdLastSet';Expression={[DateTime]::FromFileTime($_.PwdLastSet)}}, 
                  @{Name='PasswordExpiry';Expression={[DateTime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}
}

function SendReminder {

# do dopieszczenia, na razie prosta formulka 
# Send-MailMessage -To $user.Email -Subject $subject -Body $body -SmtpServer "smtp.yourserver.com" -From "your-email@yourdomain.com" -Credential $yourCredentials
}

foreach ($user in $users) {
    # Pobierz dane użytkownika
    $name = $user.Name
    $pwdLastSet = [DateTime]::FromFileTime($user.PwdLastSet)
    $passwordExpiry = [DateTime]::FromFileTime($user."msDS-UserPasswordExpiryTimeComputed")

    # Sprawdź czy hasło wygasa
    $daysUntilExpiry = ($passwordExpiry - (Get-Date)).Days

    # Jeśli hasło wygasa w ciągu X dni, wyslij maila
    $expiryThreshold = 60
    if ($daysUntilExpiry -le $expiryThreshold) {
        $subject = "Przypomnienie o wygasającym haśle"
        $body = "Twoje hasło wygasa za $daysUntilExpiry dni. Prosimy o zmianę hasła."

        Write-Host `n*****$name*****`n$subject`n$body`n


        # wyslanie wiadomosci mail
        SendReminder
    }
}

DEBUG # zakomentuj jesli nie chcesz outputu
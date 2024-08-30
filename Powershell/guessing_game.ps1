$randomNumber = Get-Random -Minimum 1 -Maximum 101
$maxAttempts = 5

for ($attempt = 1; $attempt -le $maxAttempts; $attempt++) {
    # Prompt the player for a guess
    $guess = Read-Host "Attempt ${attempt}/${maxAttempts}: Guess the number (between 1 and 100)"
    
    # Convert the player's guess to an integer
    $guess = [int]$guess

    # Check if the guess is correct
    if ($guess -eq $randomNumber) {
        Write-Host "Congratulations! You guessed the number correctly."
        break
    } elseif ($guess -lt $randomNumber) {
        Write-Host "Too low! Try again."
    } else {
        Write-Host "Too high! Try again."
    }
}

# If the loop ends without a correct guess
if ($guess -ne $randomNumber) {
    Write-Host "Sorry, you've run out of attempts. The correct number was $randomNumber."
}

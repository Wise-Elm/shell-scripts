# Number guess Script and PostgreSQL database

Uses shell scripting and a PostgreSQL database to interface with user in order to provide the 
functionality of a number guessing game. Database saves results, and script displays previous
results for user and executes game.

# Description

The number-guess program was created to partially fullfil the Relational Database 
Certification offered through freecodecamp.org, and demonstrates profeciency in generating 
scripts that can interface with users, and operate a back end.

# Project instructions

Refer to instructions.txt.

# Demonstration

Use number_guess.sql to recreate the PostgreSQL database.

Run number_guess.sh to execute program.

# Working examples of use

    me@mycomputer:$ ./number_guess.sh
    Enter your username:
    Dave
    Welcome, Dave! It looks like this is your first time here.
    Guess the secret number between 1 and 1000:
    500
    It's higher than that, guess again:
    750
    It's higher than that, guess again:
    850
    It's higher than that, guess again:
    900
    It's higher than that, guess again:
    950
    It's lower than that, guess again:
    925
    It's higher than that, guess again:
    930
    It's higher than that, guess again:
    940
    It's lower than that, guess again:
    937
    It's lower than that, guess again:
    936
    It's lower than that, guess again:
    935
    It's lower than that, guess again:
    934
    It's lower than that, guess again:
    933
    It's lower than that, guess again:
    931
    It's higher than that, guess again:
    932
    You guessed it in 15 tries. The secret number was 932. Nice job!

    me@mycomputer:$ ./number_guess.sh
    Enter your username:
    Dave
    Welcome back, Dave! You have played 1 games, and your best game took 15 guesses.
    Guess the secret number between 1 and 1000:
    500
    It's higher than that, guess again:
    700
    It's higher than that, guess again:
    800
    It's lower than that, guess again:
    750
    It's higher than that, guess again:
    775
    It's higher than that, guess again:
    785
    It's lower than that, guess again:
    780
    It's higher than that, guess again:
    782
    It's lower than that, guess again:
    781
    You guessed it in 9 tries. The secret number was 781. Nice job!

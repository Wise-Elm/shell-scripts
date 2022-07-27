#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"


USERNAME=  # Username provided by user.
NEW_USER=  # Gets populated only when the user in not found in the database.
USER_ID=  # Gets populated only when existing user is found or after new user is added to users database.
GAME_COUNT=  # Number of games played.
TRIES=  # Number of guesses it took to find the number in the users best game.

CURRENT_TRIES=  # Number of tries it took to find the number in the current game.
RANDOM_NUMBER=  # Target number to guess.



GET_USERNAME() {

    # Get username, see if exists, display message.

    # Prompt user for username.
    echo "Enter your username:"
    read USER

    # See if user exists in database, and find game cound and best game (least amount of tries).
    DB_QUERY=$($PSQL "SELECT username, COUNT(username), min(tries) FROM users JOIN games USING(user_id) WHERE username = '$USER' GROUP BY username")

    # Get user information if user exists.

    # IF DB_QUERY is not blank.
    if [[ "$DB_QUERY" ]]; then
        USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USER'") 

        # Remove '|' from database query return.
        DB_QUERY=$(echo $DB_QUERY | sed -r 's/ \| / /g')

        # Turn query results into an array to use indexing.
        array=($DB_QUERY)

        # Assign array values to global variables
        USERNAME=${array[0]}
        GAME_COUNT=${array[1]}
        TRIES=${array[2]}

        echo "Welcome back, $USERNAME! You have played $GAME_COUNT games, and your best game took $TRIES guesses."

    # DB_QUERY is blank.
    # Display approperiate message to new user.
    else
        echo "Welcome, $USER! It looks like this is your first time here."
        NEW_USER='true'
        USERNAME=$USER
    fi

}


GENERATE_NUMBER() {

    # Generate random number between 1 and 1000 and populate global variable.
    RANDOM_NUMBER=$(shuf -i 1-1000 -n 1)

}


PROMPT_USER() {

    echo "Guess the secret number between 1 and 1000:"

    NUM_GUESSES=1  # Current number of user guesses.
    NUM_FOUND=  # Populates when user guess the correct number. Break while loop.
    while [[ -z $NUM_FOUND ]]; do

        read GUESS

        if [[ ! $GUESS =~ ^[0-9]+$ ]]; then
            echo "That is not an integer, guess again:"

        elif [[ $GUESS > $RANDOM_NUMBER ]]; then
            echo "It's lower than that, guess again:"
            NUM_GUESSES=$[ $NUM_GUESSES + 1 ]  # Increment NUM_GUESSES.

        elif [[ $GUESS < $RANDOM_NUMBER ]]; then
            echo "It's higher than that, guess again:"
            NUM_GUESSES=$[ $NUM_GUESSES + 1 ]  # Increment NUM_GUESSES.

        else
            CURRENT_TRIES=$NUM_GUESSES
            echo "You guessed it in $NUM_GUESSES tries. The secret number was $RANDOM_NUMBER. Nice job!"
            NUM_FOUND="true"  # End while loop. 
        fi
    done

}


WRITE_TO_DB() {

    # Write game and user data to database.

    # New user. NEW_USER global variable is populated.
    if [[ $NEW_USER == 'true' ]]; then
        # Add new user to users table in database.
        INPUT_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")

        # Get USER_ID for newly added user.
        GET_USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
        USER_ID=$(echo $GET_USER_ID | sed 's/ //')  # Remove spaces.
    fi

    # Push game data to games table in database.
    # RANDOM NUMBER added to database for reference and is not needed.
    GAME_DATA=$($PSQL "INSERT INTO games(user_id, tries, number) VALUES($USER_ID ,$CURRENT_TRIES, $RANDOM_NUMBER)")

}


MAIN() {

    GET_USERNAME  # Prompt user for username and display approperiate mesasge.

    GENERATE_NUMBER  # Generate random number between 1 and 1000.

    PROMPT_USER  # Prompt user during number guesses.

    WRITE_TO_DB  # Write game results to database.

}


MAIN

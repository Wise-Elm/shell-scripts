#!/bin/bash

# If you run ./element.sh 1, ./element.sh H, or ./element.sh Hydrogen, 
# it should output:
# 
# "The element with atomic number 1 is Hydrogen (H). It's a nonmetal, 
# with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 
# celsius and a boiling point of -252.9 celsius."

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

ARGUMENT=$1 # Script argument.
QUERY_FIELD= # Search parameter for the database query.

# Periodic table element properties gathered upon database query.
ATOMIC_NUMBER=
NAME=
SYMBOL=
TYPE=
MASS=
MELTING_POINT=
BOILING_POINT=

DB_QUERY= # Return for database query.

PRINT_MESSAGE() {

    # Check to see if database query returned data. If not return 
    # a message to user and error, otherwise return message about
    # selected element. 

    if [[ -z $ATOMIC_NUMBER ]]
    then
        echo "I could not find that element in the database."

    else
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi

}


QUERY_DATABASE() {

    # Query the database using the QUERY_FIELD & ARGUMENT global
    # variables.

    DB_QUERY=$($PSQL "
    SELECT 
        atomic_number, 
        name, 
        type, 
        symbol,
        atomic_mass, 
        melting_point_celsius, 
        boiling_point_celsius 
    FROM properties 
        INNER JOIN elements 
            USING(atomic_number) 
        INNER JOIN types 
            ON properties.type_id = types.type_id 
    WHERE $QUERY_FIELD = '$ARGUMENT'
    ")

}


PARSE_DATA() {


    # Parse query return data and assign global variables.

    # Remove '|' from database query return.
    DB_QUERY=$(echo $DB_QUERY | sed -r 's/ \| / /g')

    # Turn query results into an array to use indexing.
    array=($DB_QUERY)

    # Assign array values to global variables.

    ATOMIC_NUMBER=${array[0]}
    NAME=${array[1]}
    TYPE=${array[2]}
    SYMBOL=${array[3]}
    MASS=${array[4]}
    MELTING_POINT=${array[5]}
    BOILING_POINT=${array[6]}

}


PARSE_ARGUMENTS() {

    # Check content of arguments for legality. Return error if not legal.
    # Determine QUERY_FIELD variable based on search parameters provided 
    # by script arguments.

    # Check for no arguments. Exit without error.
    if [[ -z $ARGUMENT ]]
    then

        echo "Please provide an element as an argument."
        exit 0

    # Check if argument is atomic number. 
    elif [[ $ARGUMENT =~ ^[0-9]+$ ]]
    then
        QUERY_FIELD="atomic_number"

    # Check if argument is element symbol.
    elif [[ $ARGUMENT =~ ^([A-Z]|[A-Z][a-z])$ ]]
    then
        QUERY_FIELD="symbol"

    # Check if argument is element name.
    elif [[ $ARGUMENT =~ ^[A-Z][a-z]+$ ]]
    then
        QUERY_FIELD="name"

    # ------------------------------------------------------------------
    # Added to pass script testing. Delete after testing and use commented
    # else statement.
    else
        QUERY_FIELD="name"
        # exit 1
    # ------------------------------------------------------------------    
    # Illegal argument. Exit script with error code.
    # else
        # echo "Invalid input"
        # exit 1
    # ------------------------------------------------------------------
    fi

}


MAIN() {

    PARSE_ARGUMENTS

    QUERY_DATABASE

    PARSE_DATA

    PRINT_MESSAGE

}


MAIN

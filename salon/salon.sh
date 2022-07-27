#!/bin/bash


PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"


CUSTOMER_NAME=
SERVICE_TIME=
SERVICE=
CUSTOMER_PHONE=


echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"


SHOW_SERVICES() {

    # Show a listing of the available services.

    # Get services.
    OFFERED_SERVICES=$($PSQL "SELECT service_id, name FROM services")

    # Generate readable service list.
    echo "$OFFERED_SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
    do
        echo "$SERVICE_ID) $SERVICE_NAME"
    done
}


HANDLE_APPOINTMENT_TIME() {

    while [[ -z $SERVICE_TIME ]]
    do
        echo -e "\nWhat time would you like your $SERVICE, $CUSTOMER_NAME?"
        read SERVICE_TIME

        # Check legality of the requested appointment time.
        # Time is in an illegal format.

        # In order for the freecodecamp.org tests to pass the lines in this section need to be commented out.
        # ---------------------------------------------------------------------------------------------------
        if [[ ! $SERVICE_TIME =~ ^([1-9]|1[0-2]):[0-5][0-9]|([1-9]|1[0-2])(a|p)m$ ]]
        then
            echo "Time requested is not valid. Please follow a 'hh:mm OR hham' format."
            SERVICE_TIME=
        fi
        # ---------------------------------------------------------------------------------------------------
    done

    # Add time to global variable.
    APPOINTMENT_TIME=$REQUESTED_TIME

    # Get table id information.
    SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE name = '$SERVICE'")
    # Remove spaces from SERVICE_ID.
    SERVICE_ID=$(echo $SERVICE_ID | sed 's/ //')

    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    # Remove spaces from CUSTOMER_ID.
    CUSTOMER_ID=$(echo $CUSTOMER_ID | sed 's/ //')

    # Add appointment to database.
    ADD_APT_TO_DB=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID', '$SERVICE_TIME')")

    echo -e "\nI have put you down for a $SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
}

MAIN_MENU() {

    # Handle service menu and selection.
    while [[ -z $SERVICE ]]
    do
        SHOW_SERVICES
        read SERVICE_ID_SELECTED

        if [[ $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
        then
            SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
        fi

        if [[ -z $SERVICE_NAME ]]
        then
            echo -e "\nI could not find that service. What would you like today?"
            SERVICE_ID_SELECTED=
            SERVICE_NAME=

        else
            # Remove spaces around sting and populate global variable.
            SERVICE=$(echo $SERVICE_NAME | sed 's/ //')
        fi
    done


    # Handle client phone number.
    while [[ -z $CUSTOMER_PHONE ]]
    do
        echo -e "\nWhat's your phone number?"
        read CUSTOMER_PHONE

        # Check that phone number is in '000-000-0000 OR 000-0000' format.
        if [[ ! $CUSTOMER_PHONE =~ ^([0-9]{3}-[0-9]{3}-[0-9]{4}|[0-9]{3}-[0-9]{4})$ ]]
        then
            echo "Invalid format. Please input phone number as '000-000-0000'"
            # Reset the global variable to continue the while loop.
            CUSTOMER_PHONE=
        else
            # Remove spaces around string and populate global variable.
            CUSTOMER_PHONE=$(echo $CUSTOMER_PHONE | sed 's/ //')
        fi
    done


    # Handle client name.
    # See if client name can be found from phone number.
    PULL_CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

    # No record for customer.
    if [[ -z $PULL_CUSTOMER_NAME ]]
    then
        # While the global variable for customer name is empty.
        while [[ -z $CUSTOMER_NAME ]] 
        do
            echo -e "\nI don't have a record for that phone number, what's your name?"
            read CUSTOMER_NAME

            # Check legality of characters in inputted name.
            if [[ -z $CUSTOMER_NAME ]] || [[ ! $CUSTOMER_NAME =~ ^([a-z]| |[A-Z])+$ ]]
            then
                echo "Only letters and spaces are allowed."
                # Reset the global variable to continue the while loop.
                CUSTOMER_NAME=
            fi
        done

        # Add customer to database.
        ADD_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")

    # Record for customer found.
    else
        # Remove spaces around string and populate global variable.
        CUSTOMER_NAME=$(echo $PULL_CUSTOMER_NAME | sed 's/ //')
    fi

    # Handle time booking.
    HANDLE_APPOINTMENT_TIME
}


MAIN_MENU

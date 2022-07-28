#!/bin/bash

# mortgage-calc: Script to calculate monthly loan payments.

PROGNAME="${0##*/}" # Get basename.
PAYMENT=

usage () {

	# Display usage message.

	cat <<- _EOF_
	Usage: $PROGRAME [-i | PRINCIPAL INTEREST MONTHS ]
	Where:
	PRINCIPAL is the amount of the loan.
		(Positive integer.)
	INTEREST is the APR as a number (7% = 0.07).
		(Floating point number starting with '0.'.)
	
	MONTHS is the length of the loan's term.
		(Positive integer.)
	_EOF_

	return
}

results () {

	# Display results.

	cat <<- _EOF_
	Principal \$$PRINCIPAL
	Interest  $INTEREST%
	Months    $MONTHS
	A monthly payment of \$$PAYMENT is required.
	_EOF_

	return
}

payment () {

	# Calculate payment and format results.
	
	PAYMENT=$(bc <<- _EOF_
		scale = 10 
		i = $INTEREST / 12
		p = $PRINCIPAL
		m = $MONTHS
		a = p * ((i * ((1 + i) ^ m)) / (((1 + i) ^ m) - 1))
		print a
		_EOF_
	)

	# Format PAYMENT to 2 decimal places.	
	printf -v PAYMENT "%0.2f" $PAYMENT

	return
}

interactive () {

	# Interactive mode.

	while true; do

		read -p "Enter loan principal: " PRINCIPAL					 
		if [[ ! "$PRINCIPAL" =~ ^[[:digit:]]+$ ]]; then
			echo "Illegal argument for PRINCIPAL: ($PRINCIPAL)"
			continue
		fi

		read -p "Enter interest rate (0.35): " INTEREST
		if	[[ ! "$INTEREST" =~ ^0\.[[:digit:]]+$ ]]; then	
			echo "Illegal argument for INTEREST: ($INTEREST)"
			continue
		fi

		read -p "Term of loan in months: " MONTHS
		if	[[ ! "$MONTHS" =~ ^[[:digit:]]+$ ]]; then
			echo "Illegal argument for MONTHS: ($MONTHS)"
			continue
		fi

		payment # Calculate payment.
		results # Get results.

		read -p "Continue or quit? [c/q]: "
		case "$REPLY" in
			C|c)	continue
					;;
			Q|q)	exit
					;;
			*)		usage >&2
					exit 1
					;;
		esac
	done

	return
}

# Test for interactive mode.
if [[ "$1" == "-i" ]]; then
	interactive

# Test the validity of arguments when not entering interactive mode.
elif (($# == 3)); then # Confirm the presence of 3 arguments.

		# Confirm principal is an integer and is greater that 0.
		if [[ ! "$1" =~ ^[[:digit:]]+$ ]]; then
			echo "Illegal argument for PRINCIPAL: ($1)"
			usage
			exit 1

		# Confirm interest starts with '0.' and contains all digits.
		elif
			[[ ! "$2" =~ ^0\.[[:digit:]]+$ ]]; then	
				echo "Illegal argument for INTEREST: ($2)"
				usage
				exit 1

		# Confirm that months is greater that 0 and is all digits.
		elif
			[[ ! "$3" =~ ^[[:digit:]]+$ ]]; then
				echo "Illegal argument for MONTHS: ($3)"
				usage
				exit 1
		fi

# Display usage message when inappropriate number of arguments
# is found.
else
	usage
	exit 1
fi

# Populate variables.
PRINCIPAL=$1
INTEREST=$2
MONTHS=$3

payment # Calculate payment.
results # Get results.

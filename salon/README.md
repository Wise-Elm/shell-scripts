# Salon Scheduling program

Uses shell scripting and a PostgreSQL database to interface with customers in order to provide 
the functionality of a basic salon scheduling program.

# Description

The Salon Scheduling program was created to partially fullfil the Relational Database Certification 
offered through freecodecamp.org, and demonstrates profeciency in generating scripts that can 
interface with users, and operate a back end.

# Demonstration

Use salon.sql to recreate the PostgreSQL database.

  # Working examples of use:

  me@mycomputer:~/project$ ./salon.sh

  ~~~~~ MY SALON ~~~~~

  Welcome to My Salon, how can I help you?

  1) cut
  2) color
  3) perm
  4) style
  5) trim
  1

  What's your phone number?
  555-555-55
  Invalid format. Please input phone number as '000-000-0000'

  What's your phone number?
  555-555-5555

  I don't have a record for that phone number, what's your name?
  Graham

  What time would you like your cut, Graham?
  789797987
  Time requested is not valid. Please follow a 'hh:mm OR hham' format.

  What time would you like your cut, Graham?
  10:35

  I have put you down for a cut at 10:35, Graham.
  
  me@mycomputer:~/project$ ./salon.sh

  ~~~~~ MY SALON ~~~~~

  Welcome to My Salon, how can I help you?

  1) cut
  2) color
  3) perm
  4) style
  5) trim
  89

  I could not find that service. What would you like today?
  1) cut
  2) color
  3) perm
  4) style
  5) trim
  2

  What's your phone number?
  555-555-5555

  What time would you like your color, Graham?
  9am

  I have put you down for a color at 9am, Graham.

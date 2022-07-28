# Periodic Table Program

Uses shell scripting and a PostgreSQL database to interface with user in order 
to provide information on elements in the periodic table.

# Description

The periodic-table program was created to partially fullfil the Relational Database Certification 
offered through freecodecamp.org, and demonstrates profeciency in generating scripts that can 
interface with users, and operate a back end.

# Demonstration

Use periodic-table.sql to recreate the PostgreSQL database.

The script can be given an argument of an elements atomic number, 
symbol, or name.

# Working examples of use using no argument, atomic number, element symbol, and element name.
  
    user:periodic-table$ ./elements.sh 
    Please provide an element as an argument.

    user:periodic-table$ ./elements.sh 1
    The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling   point of -252.9 celsius.

    user:periodic-table$ ./elements.sh Li
    The element with atomic number 3 is Lithium (Li). It's a metal, with a mass of 6.94 amu. Lithium has a melting point of 180.54 celsius and a boiling       point of 1342 celsius.

    user:periodic-table$ ./elements.sh Neon
    The element with atomic number 10 is Neon (Ne). It's a nonmetal, with a mass of 20.18 amu. Neon has a melting point of -248.6 celsius and a boiling point   of -246.1 celsius.

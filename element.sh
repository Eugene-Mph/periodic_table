#! /bin/bash

PSQL="psql --username=freecodecamp dbname=periodic_table --tuples-only -c"


if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."

  else

  if [[ $1 =~ ^[0-9]+ ]]
  
  then
    ELEMENT_PROPERTIES=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1 ;")
    if [[ -z $ELEMENT_PROPERTIES ]]
    then
      echo 'I could not find that element in the database.'
    else
      echo "$ELEMENT_PROPERTIES" | while read T_ID B AN B SYMBOL B NAME B AM B MP B BP B TYPE
      do
        echo "The element with atomic number $AN is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AM amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
      done
    fi

  else
     ELEMENT_PROPERTIES=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1';")
     if [[ -z $ELEMENT_PROPERTIES ]]
     then
      echo 'I could not find that element in the database.'
    else
      echo "$ELEMENT_PROPERTIES" | while read T_ID B AN B SYMBOL B NAME B AM B MP B BP B TYPE
      do
        echo "The element with atomic number $AN is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AM amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
      done
    fi
  fi
fi

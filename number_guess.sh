#!/bin/bash

# A Number Guessing Game
#
# This script is a simple number guessing game tied to a postgres database
# Users must guess a randomly generated number in the range 1-1000 in the fewest tries
#
# User statistics are tracked via their (unique) username
#

# PSQL Variable holds psql script to aid querying database:
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Randomly generate number between 1 and 1000:
NUM=$(( ( $RANDOM % 1000 ) + 1 ))

# Get Username
while [[ -z $USERNAME ]]
do
  echo "Enter your username:"
  read USERNAME
done

# Check if Username is in DB
USER_DETAILS=$($PSQL "SELECT * FROM users WHERE username='$USERNAME';")

# If user not in DB, add them to DB
if [[ -z $USER_DETAILS ]]
then
  USER_INSERT_RESULT=$($PSQL "INSERT INTO users (username) VALUES('$USERNAME');")

  if [[ $USER_INSERT_RESULT = "INSERT 0 1" ]]
  then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    USER_NUM_GAMES=0
  else
    echo "Whoops, something went wrong!"
    exit
  fi

else
  # User already exists - get info from user from DB
  read USER_ID USER_NUM_GAMES USER_BEST_GAME USERNAME <<< $(echo $USER_DETAILS | sed -r 's/\|/ /g')
  echo "Welcome back, $USERNAME! You have played $USER_NUM_GAMES games, and your best game took $USER_BEST_GAME guesses."
fi

NUM_GUESSES=0

# Play the game
echo "Guess the secret number between 1 and 1000:"
while [[ ! $NUM = $USER_GUESS ]]
do
  read USER_GUESS
  NUM_GUESSES=$(($NUM_GUESSES + 1))
  # Ensure guess is a positive integer
  while [[ ! $USER_GUESS =~ ^[0-9]*$ ]]
  do
    echo "That is not an integer, guess again:"
    read USER_GUESS
  done

  if [ $USER_GUESS -lt $NUM ]
  then
    echo "It's higher than that, guess again:"
  elif [ $USER_GUESS -gt $NUM ]
  then
    echo "It's lower than that, guess again:"
  fi

done

# Update user info in DB
# If the user has no previous games or this game beats previous record, update best game
if [[ $USER_NUM_GAMES -eq 0 || $NUM_GUESSES -lt $USER_BEST_GAME ]]
then
  # Update number of games and best game for user
  USER_UPDATE_RESULT=$($PSQL "UPDATE users SET games_played=games_played + 1, best_game=$NUM_GUESSES WHERE username='$USERNAME';")
else
  # Otherwise just update number of games:
  USER_UPDATE_RESULT=$($PSQL "UPDATE users SET games_played=games_played + 1 WHERE username='$USERNAME';")
fi

# Final info output to user
echo "You guessed it in $NUM_GUESSES tries. The secret number was $NUM. Nice job!"

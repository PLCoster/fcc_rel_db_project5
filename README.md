# Free Code Camp: Relational Database Project 5

## Number Guessing Game

The aim of this project was to create a Bash script that utilises a PostgreSQL database to create a simple number guessing game with player statistic tracking.

### Project Requirements:

- **User Story #1:** Create a `number_guessing_game` folder in the `project` folder for your program

- **User Story #2:** Create `number_guess.sh` in your `number_guessing_game` folder and give it executable permissions

- **User Story #3:** Your script should have a shebang at the top of the file that uses `#!/bin/bash`

- **User Story #4:** Turn the `number_guessing_game` folder into a git repository

- **User Story #5:** Your git repository should have at least five commits

- **User Story #6:** Your script should randomly generate a number that users have to guess

- **User Story #7:** When you run your script, you should prompt the user for a username with `Enter your username:`, and take a username as input. Your database should allow usernames of at least 22 characters

- **User Story #8:** If that username has been used before, it should print `Welcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses.`, with `<username>` being a users name from the database, `<games_played>` being the total number of games that user has played, and `<best_game>` being the fewest number of guesses it took that user to win the game

- **User Story #9:** If the username has not been used before, you should print `Welcome, <username>! It looks like this is your first time here.`

- **User Story #10:** The next line printed should be `Guess the secret number between 1 and 1000:` and input from the user should be read

- **User Story #11:** Until they guess the secret number, it should print `It's lower than that, guess again:` if the previous input was higher than the secret number, and `It's higher than that, guess again:` if the previous input was lower than the secret number. Asking for input each time until they input the secret number.

- **User Story #12:** If anything other than an integer is input as a guess, it should print `That is not an integer, guess again:`

- **User Story #13:** When the secret number is guessed, your script should print `You guessed it in <number_of_guesses> tries. The secret number was <secret_number>. Nice job!`

- **User Story #14:** The message for the first commit should be `Initial commit`

- **User Story #15:** The rest of the commit messages should start with `fix:`, `feat:`, `refactor:`, `chore:`, or `test:`

- **User Story #16:** You should finish your project while on the `main` branch, your working tree should be clean, and you should not have any uncommitted changes

### Project Writeup:

The fifth Free Code Camp: Relational Database project is an interactive Number Guessing Game, where users try to guess a randomly generated number. On a missed guess, they are given a hint as to whether the target number is larger or smaller than their guess.

Users supply a unique username to the script, allowing their number of games played and best game (fewest required guesses) to be tracked using a PostgreSQL database.

### Usage

The database can be interacted with using `psql` in linux. First start up a PostgreSQL server using:

`$ sudo service postgresql start`

The number_guess database should then be loaded from the `number_guess.sql` file using:

`$ psql --dbname=postgres < number_guess.sql`

Optionally the database can be interacted with directly using:

`$ psql --dbname=postgres`

Once loaded, the bash script can be run for the number guessing game. (Note that you will have to change the `--username=freecodecamp` option on line 12 of the script to your linux username or remove this entirely):

`$ ./number_guess.sh`

Save a dump of the live database using:

`$ pg_dump -cC --inserts number_guess > number_guess.sql`

Instructions for building the project can be found at https://www.freecodecamp.org/learn/relational-database/build-a-number-guessing-game-project/build-a-number-guessing-game

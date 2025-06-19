#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE TABLE games, teams")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
#get team_name
  if [[ $WINNER != "winner" || $OPPONENT !=  "opponent" ]]
  then
  INSERT_WINNER=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER') ON CONFLICT (name) DO NOTHING")
  INSERT_OPPONENT=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT') ON CONFLICT (name) DO NOTHING")
  fi

# get winner_id

  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

  $PSQL "INSERT INTO games(year, round, opponent_goals, winner_goals, winner_id, opponent_id) VALUES ($YEAR, '$ROUND', $OPPONENT_GOALS, $WINNER_GOALS,  $WINNER_ID, $OPPONENT_ID);"
# get opponent_id

  

#get winner goals

#get opponent goals
done


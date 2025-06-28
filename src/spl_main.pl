%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TEAMS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% List of teams
list_of_teams(TeamsList):- % to generate the entire list of teams.
findall(X,team(X),TeamsList). % the body of the predicate,
% The team with the most points
team_points(T):-
list_of_teams(Teams),
points_team(Teams,Points),
max_member(MaxPoints, Points), % Get the maximum points
nth1(Index, Points, MaxPoints), % Get the index of the maximum points
nth1(Index, Teams, T),!. % Retrieve the team at that index
points_team([],[]).
points_team([X|T],[Points|Rest]):-
findall((X,G1,G2),(match(X,_,G1,G2);match(_,X,G2,G1)),L),
count_points(L,Points),
points_team(T,Rest).
count_points([], 0):-!.
count_points([(_,G1,G2)|Results], Points) :-
G is G1 - G2,
(G < 0 -> PointsRest = 1; G > 0 -> PointsRest = 3; PointsRest = 0),
count_points(Results, Rest),
Points is PointsRest + Rest.
% The team with the most goals
team_goals(T):-
list_of_teams(Teams),
goals_team(Teams,Goals),
max_member(MaxGoals, Goals), % Get the maximum goals
nth1(Index, Goals, MaxGoals), % Get the index of the maximum goals
nth1(Index, Teams, T),!. % Retrieve the team at that index
goals_team([],[]). % handles the case where the input list of teams is empty
goals_team([X|T],[Goals|Rest]):-
findall((X,G1),(match(X,_,G1,_);match(_,X,_,G1)),L),
count_goals(L,Goals),
goals_team(T,Rest).
count_goals([], 0):-!.
count_goals([(_,G1)|Results], Goals) :-
count_goals(Results, Rest),
Goals is G1 + Rest.
% The team conceded the least goals
team_conceded_goals(T):-
list_of_teams(Teams),
conceded_goals(Teams,Goals),
min_list(Goals, MinGoals), % Get the minimum value in Goals
nth1(Index, Goals, MinGoals), % Get the index of the minimum value
nth1(Index, Teams, T),!. % Retrieve the team at that index
conceded_goals([],[]).
conceded_goals([X|T],[Goals|Rest]):-
findall(Goal, (match(X, _, _, Goal); match(_, X, Goal, _)), GoalsList),
sum_list(GoalsList, Goals),
conceded_goals(T,Rest).
% Most team won
team_won(T):-
list_of_teams(Teams),
wins(Teams,Wins),
max_member(MaxWins, Wins), % Get the maximum wins
nth1(Index, Wins, MaxWins), % Get the index of the maximum wins
nth1(Index, Teams, T),!. % Retrieve the team at that index
wins([],[]).
wins([X|T],[Wins|Rest]):-
findall((X,G1,G2),(match(X,_,G1,G2);match(_,X,G2,G1)),L),
count_wins(L,Wins),
wins(T,Rest).
count_wins([], 0):-!.
count_wins([(_,G1,G2)|Results], Wins) :-
G is G1 - G2,
(G =< 0 -> WinsRest = 0; WinsRest = 1),
count_wins(Results, Rest),
Wins is WinsRest + Rest.
% The team that lost the least
team_lost(T):-
list_of_teams(Teams),
losses(Teams,Losses),
min_member(MinLosses, Losses), % Get the minimum losses
nth1(Index, Losses, MinLosses), % Get the index of the minimum losses
nth1(Index, Teams, T),!. % Retrieve the team at that index
losses([],[]).
losses([X|T],[Losses|Rest]):-
findall((X,G1,G2),(match(X,_,G1,G2);match(_,X,G2,G1)),L),
count_losses(L,Losses),
losses(T,Rest).
count_losses([], 0):-!.
count_losses([(_,G1,G2)|Results], Losses) :-
G is G1 - G2,
(G =< 0 -> LossesRest = 1; LossesRest = 0),
count_losses(Results, Rest),
Losses is LossesRest + Rest.
% Most drawn team
team_draw(T):-
list_of_teams(Teams),
draws(Teams,Draws),
max_member(MaxDraws, Draws), % Get the maximum draws
nth1(Index, Draws, MaxDraws), % Get the index of the maximum draws
nth1(Index, Teams, T),!. % Retrieve the team at that index
draws([],[]).
draws([X|T],[Draws|Rest]):-
findall((X,G1,G2),(match(X,_,G1,G2);match(_,X,G2,G1)),L),
count_draws(L,Draws),
draws(T,Rest).
count_draws([], 0):-!.
count_draws([(_,G1,G2)|Results], Draws) :-
G is G1 - G2,
(G is 0 -> DrawsRest = 1; DrawsRest = 0),
count_draws(Results, Rest),
Draws is DrawsRest + Rest.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MATCHES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%List of matches
list_of_matches(M):-
findall((X,Y:G1-G2),match(X,Y,G1,G2),M).
print_match((X,Y:G1-G2)):-
format("~w ~w - ~w ~w",[X,G1,G2,Y]).
%Most goals scored match
most_goal_match(M):-
list_of_matches(Matches),
most_goal(Matches,Goals),
max_member(MaxGoals, Goals), % Get the maximum goals
nth1(Index, Goals, MaxGoals), % Get the index of the maximum goals
nth1(Index, Matches, M),!. % Retrieve the match at that index
most_goal([],[]).
most_goal([(_,_:G1-G2)|T],[Goals|Rest]):-
Goals is G1+G2,
most_goal(T,Rest).
%The match that conceded the least goals
min_goal_match(M):-
list_of_matches(Matches),
most_goal(Matches,Goals),
min_member(MinGoals, Goals), % Get the minimum goals
nth1(Index, Goals, MinGoals), % Get the index of the minimum goals
nth1(Index, Matches, M),!. % Retrieve the match at that index
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLAYERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
list_of_players(P):-
findall(Name,(
assist(Name, _, _);
yellowCard(Name, _, _);
redCard(Name, _, _);
goals(Name, _, _)
),P).
%The player who scored the most goals
player_scored_most(Player) :-
findall(goals(Name, Team, Goals), goals(Name, Team, Goals), GoalsList),
player_with_most_goals(GoalsList, Player),!.
player_with_most_goals(GoalsList, (Player,Team,MaxGoals)) :-
maplist(arg(3), GoalsList, GoalsOnly),
max_list(GoalsOnly, MaxGoals),
member(goals(Player, Team, MaxGoals), GoalsList).
%The player who made the most goals
player_made_most(Player) :-
findall(assist(Name, Team, Assists), assist(Name, Team, Assists), AssistsList),
player_with_most_assists(AssistsList, Player).
player_with_most_assists(AssistsList, (Player,Team,MaxAssists)) :-
maplist(arg(3), AssistsList, AssitsOnly),
max_list(AssitsOnly, MaxAssists),
member(assist(Player, Team, MaxAssists), AssistsList).
% The player who received the most yellow cards
player_received_most_yellow_card(Player) :-
findall(yellowCard(Name, Team, YellowCards), yellowCard(Name, Team, YellowCards),
YellowCardsList),
player_with_most_yellow_cards(YellowCardsList, Player).
player_with_most_yellow_cards(YellowCardsList, (Player, Team, MaxYellowCards)) :-
maplist(arg(3), YellowCardsList, YellowCardsOnly),
max_list(YellowCardsOnly, MaxYellowCards),
member(yellowCard(Player, Team, MaxYellowCards), YellowCardsList).
% The player who received the most red cards
player_received_most_red_card(Player) :-
findall(redCard(Name, Team, RedCards), redCard(Name, Team, RedCards), RedCardsList),
player_with_most_red_cards(RedCardsList, Player).
player_with_most_red_cards(RedCardsList, (Player, Team, MaxRedCards)) :-
maplist(arg(3), RedCardsList, RedCardsOnly),
max_list(RedCardsOnly, MaxRedCards),
member(redCard(Player, Team, MaxRedCards), RedCardsList).
% Define your top-level menu options
top_menu_option(1, "Teams").
top_menu_option(2, "Matches").
top_menu_option(3, "Players").
top_menu_option(0, "Exit").
% Define predicates to display the top-level menu
display_top_menu :-
nl,
write('⚽⚽⚽ Saudi Professional League Analyst ⚽⚽⚽'), nl,nl,
write('Hello! I am the Analysts of the Saudi Pro League SPL'), nl,
write('And I am here to help you know what is going on the League'), nl,
write('|| Please choose what you want to know from the menue ||'), nl,nl,
forall(top_menu_option(Index, Option),
(write(Index), write('. '), write(Option), nl)),
nl.
% Define predicates to handle top-level menu options
handle_top_option(0) :- write('I hope you enjoy, see you later...').
handle_top_option(1) :- team_submenu.
handle_top_option(2) :- match_submenu.
handle_top_option(3) :- player_submenu.
handle_top_option(_) :- format("Invalid entry, enter one of the options below.~n").
% Display function for the team submenu
display_team_submenu :-
nl,
write('⚽⚽⚽ TEAM ⚽⚽⚽'), nl,nl,
write('I have multiple things that I can let you know about it'), nl,
write('|| Choose what you are interested in knowing!! ||'), nl,nl,
forall(team_submenu_option(Index, Option),
(write(Index), write('. '), write(Option), nl)),
nl.
% Display function for the match submenu
display_match_submenu :-
nl,
write('⚽⚽⚽ MATCH ⚽⚽⚽'), nl,nl,
write('I have multiple things that I can let you know about it'), nl,
write('|| Choose what you are interested in knowing!! ||'), nl,nl,
forall(match_submenu_option(Index, Option),
(write(Index), write('. '), write(Option), nl)),
nl.
% Display function for the player submenu
display_player_submenu :-
nl,
write('⚽⚽⚽ PLAYER ⚽⚽⚽'), nl,nl,
write('I have multiple things that I can let you know about it'), nl,
write('|| Choose what you are interested in knowing!! ||'), nl,nl,
forall(player_submenu_option(Index, Option),
(write(Index), write('. '), write(Option), nl)),
nl.
% Define the main top-level menu loop
main_menu :-
display_top_menu,
write('Enter your choice: '),
read(Choice),
handle_top_option(Choice),
(Choice == 0 -> ! ; main_menu).
% Define the team submenu options
team_submenu_option(1, "Team with the most points").
team_submenu_option(2, "Team with the most goals").
team_submenu_option(3, "Team that conceded the least goals").
team_submenu_option(4, "Team with the most wins").
team_submenu_option(5, "Team that lost the least").
team_submenu_option(6, "Team with the most draws").
team_submenu_option(0, "Exit").
% Define predicates to handle team submenu options
handle_team_submenu_option(0) :- write('Exiting...').
handle_team_submenu_option(1) :- team_points(T), write('Team with the most points: '), writeln(T).
handle_team_submenu_option(2) :- team_goals(T), write('Team with the most goals: '), writeln(T).
handle_team_submenu_option(3) :- team_conceded_goals(T), write('Team that conceded the least
goals: '), writeln(T).
handle_team_submenu_option(4) :- team_won(T), write('Team with the most wins: '), writeln(T).
handle_team_submenu_option(5) :- team_lost(T), write('Team that lost the least: '), writeln(T).
handle_team_submenu_option(6) :- team_draw(T), write('Team with the most draws: '), writeln(T).
% Define the team submenu loop
team_submenu :-
display_team_submenu,
write('Enter your choice: '),
read(Choice),
handle_team_submenu_option(Choice),
(Choice == 0 -> ! ; team_submenu).
% Define predicates to handle match submenu options
match_submenu_option(1, "Match with the most goals").
match_submenu_option(2, "Match that conceded the least goals").
match_submenu_option(0, "Exit").
% Define the match submenu loop
match_submenu :-
display_match_submenu,
write('Enter your choice: '),
read(Choice),
handle_match_submenu_option(Choice),
(Choice == 0 -> ! ; match_submenu).
handle_match_submenu_option(0) :- write('Exiting...').
handle_match_submenu_option(1) :- most_goal_match(M), write('Match with the most goals: '),M =
(X,Y:G1-G2), format('~w ~w - ~w ~w',[X,G1,G2,Y]),nl.
handle_match_submenu_option(2) :- min_goal_match(M), write('Match that conceded the least goals:
'),M = (X,Y:G1-G2), format('~w ~w - ~w ~w',[X,G1,G2,Y]),nl.
% Define predicates to handle match player options
% Define the match submenu loop
player_submenu :-
display_player_submenu,
write('Enter your choice: '),
read(Choice),
handle_player_submenu_option(Choice),
(Choice == 0 -> ! ; player_submenu).
player_submenu_option(1, "Player who scored the most goals").
player_submenu_option(2, "Player who made the most assists").
player_submenu_option(3, "Player who received the most yellow cards").
player_submenu_option(4, "Player who received the most red cards").
player_submenu_option(0, "Exit").
handle_player_submenu_option(0) :- write('Exiting...').
handle_player_submenu_option(1) :-
findall(P,player_scored_most(P),L),
print_goals(L).
handle_player_submenu_option(2) :-
findall(P, player_made_most(P), L),
print_assists(L).
handle_player_submenu_option(3) :-
findall(P, player_received_most_yellow_card(P), L),
print_yellow_cards(L).
handle_player_submenu_option(4) :-
findall(P, player_received_most_red_card(P), L),
print_red_cards(L).
print_red_cards([]).
print_red_cards([(Player, Team, RedCards)|Rest]):-
format('Player who received the most red cards: ~w from team ~w with ~w red cards.~n', [Player,
Team, RedCards]),
print_red_cards(Rest).
print_goals([]).
print_goals([(Player, Team, Goals)|Rest]):-
format('Player who scored the most goals: ~w from team ~w with ~w goals.~n', [Player, Team,
Goals]),print_goals(Rest).
print_assists([]).
print_assists([(Player, Team, Assists)|Rest]):-
format('Player who made the most assists: ~w from team ~w with ~w assists.~n', [Player, Team,
Assists]),
print_assists(Rest).
print_yellow_cards([]).
print_yellow_cards([(Player, Team, YellowCards)|Rest]):-
format('Player who received the most yellow cards: ~w from team ~w with ~w yellow cards.~n',[Player, Team, YellowCards]),
print_yellow_cards(Rest).
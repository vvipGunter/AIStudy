/*
dynamic here/1.
dynamic people/1.
*/
room(kitchen).
room(office).
room(hall).
room('dining room').
room(cellar).

location(desk,office).
location(apple,kitchen).
location(flashlight,desk).
location('washing machine',cellar).
location(nani,'washing machine').
location(broccoli,kitchen).
location(crackers,kitchen).
location(computer,office).

door(office,hall).
door(kitchen,office).
door(hall,'dining room').
door(kitchen,cellar).
door('dining room',kitchen).

edible(apple).
edible(crackers).
tastes_yucky(broccoli).

turned_off(flashlight).
here(kitchen).

where_food(X,Y):-location(X,Y),edible(X).
where_food(X,Y):-location(X,Y),tastes_yucky(X).

connect(X,Y):-door(X,Y).
connect(X,Y):-door(Y,X).

list_things(Place):-location(X,Place),tab(2),write(X),nl,fail.
list_things(_).

list_connects(Place):-connect(X,Place),tab(2),write(X),nl,fail.
list_connects(_).


list_connections(Place) 
:- connect(Place, X),
tab(2),
write(X),
nl, 
fail.

list_connections(_).

look :-
here(Place),
write('You are in the '), 
write(Place), 
nl,
write('You can see:'), 
nl,
list_things(Place), 
write('You can go to:'),
nl,
list_connections(Place). 



people(nani).
list_all_players(X):-write('Now the players in the game is:'),people(X),write(X),tab(1),write('!'),nl.

goto(Place):-can_go(Place),move(Place),look.

can_go(Place):-here(X),connect(X,Place).
can_go(Place):-write('You can''t get there from here.'),nl,fail.

move(Place):-retract(here(X)),asserta(here(Place)).


take(X):-can_take(X),take_object(X).
can_take(Thing):-here(Place),location(Thing,Place).
can_take(Thing):-write('There is no'),write(Thing),write('here'),nl,fail.

take_object(X):-retract(location(X,_)),asserta(have(X)),write('taken'),nl.

have(X):-location(X,nani).

backtracking_asserta(X):-asserta(X).
backtracking_asserta(X):-retract(X),fail.

location(envelope,desk).
location(stamp,envelope).
location(key,envelope).

is_contained_in(T1,T2):-location(T1,T2).
is_contained_in(T1,T2):-location(X,T2),is_contained_in(T1,X).


object(candle,red,small,1).
object(apple,red,small,1).
object(apple,green,small,1).
object(table,blue,big,50).

location_s(object(candle,red,small,1),kitchen).
location_s(object(apple,red,small,1),kitchen).
location_s(object(apple,green,small,1),kitchen).
location_s(object(table,blue,big,50),kitchen).

can_take_s(Thing) :- 
  here(Room),
  location_s(object(Thing, _, small, _), Room).
can_take_s(Thing) :-
  here(Room),
  location_s(object(Thing, _, big, _), Room),
  write('The '), write(Thing), 
  write(' is too big to carry.'), nl,
  fail.
can_take_s(Thing) :-
  here(Room),
  not (location_s(object(Thing, _, _, _), Room)),
  write('There is no '), write(Thing), write(' here.'), nl,fail.


list_things_s(Place) :-  
location_s(object(Thing, Color, Size, Weight),Place), 
write('A '),write(Size),tab(1), 
write(Color),tab(1), 
write(Thing),tab(1), write('weighing '), 
write_weight(Weight). 
list_things_s(_).

write_weight(1) :- write('1 pound').  
write_weight(W) :- W > 1, write(W), write(' pounds').


object(desk,brown,dimension(6,3,3),90).
object(desk,color(brown),size(large),write_weight(90)).
location_s(object(desk,brown,dimension(6,3,3),90),office).
object(apple, size:small, color:red, weight:1).

location_s(object(desk,color(brown),size(large),write_weight(90)),'dining room').

top_goals:-
         list_all_players(X),write('Things are :'),
         list_things_s(Place),
         look,
         location_s(object(_, _, _, _),Place),
         can_take_s(Thing),
         move(Place).



loc_list([apple, broccoli, crackers], kitchen).
loc_list([desk, computer], office).
loc_list([flashlight, envelope], desk).
loc_list([stamp, key], envelope). 
loc_list(['washing machine'], cellar).
loc_list([nani], 'washing machine'). 

loc_list([], hall).


member(H,[H|T]). 
member(X,[H|T]) :- member(X,T).

append([],X,X). 
append([H|T1],X,[H|T2]) :- append(T1,X,T2).

location(X,Y):- loc_list(List, Y), member(X, List). 

add_thing(NewThing, Container, NewList):- 
loc_list(OldList, Container), 
append([NewThing],OldList, NewList). 

add_thing2(NewThing, Container, NewList):- 
loc_list(OldList, Container), 
NewList = [NewThing | OldList].

add_thing3(NewTh, Container,[NewTh|OldList]) :-
loc_list(OldList, Container).

put_thing(Thing,Place) :- 
retract(loc_list(List, Place)), 
asserta(loc_list([Thing|List],Place)).

break_out([]). 
break_out([Head | Tail]):- 
assertz(stuff(Head)), 
break_out(Tail).

is_in(apple,room(kitchen)).

banana is_in room(kitchen). 
pear is_in room kitchen.
bowl is_in room kitchen.

op(33,xf,turned_on).
flashlight turned_on.

goto(kitchen) -> goto kitchen. 
turn_on(flashlight) -> turn_on flashlight. 
take(apple) -> take apple. 
 
data(one). 
data(two).
data(three).

cut_test_a(X) :- data(X). 
cut_test_a('last clause').

cut_test_b(X) :- data(X), !. 
cut_test_b('last clause').

cut_test_c(X,Y) :- data(X), !, data(Y). 
cut_test_c('last clause'). 

puzzle(goto(cellar)):-
have(flashlight),
turned_on(flashlight),
!.

puzzle(goto(cellar)):- 
not(have(flashlight)), 
not(turned_on(flashlight)),
write('Scared of dark message'),
fail. 

puzzle(X):-
not(X = goto(cellar)).

not(X) :- call(X), !, fail.
not(X).

goto(Place) :-
puzzle(goto(Place)),
can_go(Place),
move(Place), 
look. 

command_loop:-  
  repeat,
  write('Enter command (end to exit): '),
  read(X),
  write(X), nl,
  X = end.

do(goto(X)):-goto(X),!.
do(go(X)):-goto(X),!.
do(inventory):-inventory,!.
do(look):-look,!.

do(take(X)) :- take(X), !.
do(end).
do(_) :-
  write('Invalid command').

command_loop:- 
  write('Welcome to Nani Search'), nl,
  repeat,
  write('>nani> '),
  read(X),
  puzzle(X),
  do(X), nl,
  end_condition(X).

end_condition(end).
end_condition(_) :-
  have(nani),
  write('Congratulations').







 




 




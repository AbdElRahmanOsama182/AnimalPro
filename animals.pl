:- use_module(library(reif)).
animals([animal(dog, [is_true("is omnivore"), is_true("is regular-sized"), is_true("does it run"), is_true("has fur"), is_true("is domestic"), is_true("barks")]),
        animal(cat, [is_true("says meow")]),
        animal(camel, [is_true("is herbivore"), is_true("is large"), is_true("does it run"), is_true("has fur"), is_true("grunts")]),
        animal(bat, [is_true("is omnivore"), is_true("is small"), is_true("does it fly"), is_true("has fur"), is_true("screeches")])]).

animal(A) :-
        animals(Animals),
        Known0 = [],
        phrase(any_animal(Animals, A), [Known0], _).

any_animal([Animal|Animals], A) -->
        any_animal_(Animal, Animals, A).

any_animal_(animal(A0, []), Animals, A) -->
        (   { A0 = A }
        ;   any_animal(Animals, A)
        ).
any_animal_(animal(A0, [C|Cs]), Animals, A) -->
        state0_state(Known0, Known),
        { condition_truth(C, T, Known0, Known) },
        next_animal(T, animal(A0,Cs), Animals, A).

next_animal(yes, Animal, Animals, A)  --> any_animal([Animal|Animals], A).
next_animal(no, _, Animals, A)        --> any_animal(Animals, A).

state0_state(S0, S), [S] --> [S0].

condition_truth(is_true(Q), Answer, Known0, Known) :-
        if_(known_(Q,Answer,Known0),
            Known0 = Known,
            ( format("~s?\n", [Q]),
              read(Answer),
              map_question(Q,Property),
              (Answer = yes -> Known = [known(Property, Answer)|Known0]  
                                ; Known = [known(Q, Answer)|Known0]))).

known_(What, Answer, Known, Truth) :-
        map_question(What,Property),
        if_(memberd_t(known(Property,yes), Known),
            ( Answer = yes, Truth = true ),
            if_(memberd_t(known(What,no), Known),
                ( Answer = no, Truth = true),
                Truth = false)).

map_question("is omnivore", "diet").
map_question("is carnivore", "diet").
map_question("is herbivore", "diet").

map_question("is regular-sized", "size").
map_question("is large", "size").
map_question("is small", "size").

map_question("does it run", "locomotion").
map_question("does it fly", "locomotion").

map_question("has fur", "coating").

map_question("is domestic", "domestic").

map_question("barks", "sound").
map_question("says meow", "sound").
map_question("grunts", "sound").
map_question("screeches", "sound").

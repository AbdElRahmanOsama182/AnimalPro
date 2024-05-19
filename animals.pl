:- use_module(library(reif)).
animals([animal(dog, [is_true("has fur"), is_true("barks"), is_true("is domestic"), is_true("does it run"), is_true("is regular-sized"), is_true("is omnivore")]),
        animal(cat, [is_true("has fur"), is_true("says meow"), is_true("is domestic"), is_true("does it run"), is_true("is small"), is_true("is carnivore")]),
        animal(camel, [is_true("has fur"), is_true("grunts"), is_true("does it run"), is_true("is large"), is_true("is herbivore")]),
        animal(bat, [is_true("has fur"), is_true("screeches"), is_true("does it fly"), is_true("is small"), is_true("is omnivore")])]).

animal(A) :-
    animals(Animals),
    Known0 = [],
    phrase(searchAnimals(Animals, A), [Known0], _).

% For each animal, check if the animal is the one we are looking for
searchAnimals([Animal|Animals], A) -->
    checkAnimalRules(Animal, Animals, A).

% When there are no more rules to check
checkAnimalRules(animal(A0, []), Animals, A) -->
    % if the animal is the one we are looking for
    (   { A0 = A }
    % if the animal is not, continue with the reamining animals
    ;   searchAnimals(Animals, A)
    ).

% Check the rules of the animal
checkAnimalRules(animal(A0, [Rule|Rules]), Animals, A) -->
    updateState(Known0, Known),
    { checkRule(Rule, Answer, Known0, Known) },
    next_animal(Answer, animal(A0,Rules), Animals, A).

% Keep the same animal if the answer is yes
next_animal(yes, Animal, Animals, A)  --> searchAnimals([Animal|Animals], A).
% Move to the next animal if the answer is no
next_animal(no, _, Animals, A)  --> searchAnimals(Animals, A).

% update the state of the rules
updateState(New, Old), [Old] --> [New].

% Check if the rule is true or false
checkRule(is_true(Q), Answer, Known0, Known) :-
    % Check if the rule is already known
    if_(ruleIsKnown(Q,Answer,Known0),
        Known0 = Known,
    % If the rule is not known
    ( format("~s?\n", [Q]),
        read(Answer),
        Known = [known(Q,Answer)|Known0])).

% Check if the rule is already known
ruleIsKnown(What, Answer, Known, Truth) :-
    % Check if the rule exists and if it is true
    if_(memberd_t(known(What,yes), Known),
        ( Answer = yes, Truth = true ),
    % Check if the rule exists and if it is false
    if_(memberd_t(known(What,no), Known),
        ( Answer = no, Truth = true),
    % If the rule is not known
        Truth = false)).
:- use_module(library(reif)).

% Define the categories for different characteristics
mapToCategory("barks", sound).
mapToCategory("says meow", sound).
mapToCategory("grunts", sound).
mapToCategory("screeches", sound).
mapToCategory("is silent", sound).
mapToCategory("chirps", sound).
mapToCategory("clucks", sound).
mapToCategory("says moo", sound).
mapToCategory("roars", sound).
mapToCategory("clicks", sound).
mapToCategory("trumpets", sound).
mapToCategory("croaks", sound).
mapToCategory("bleats", sound).
mapToCategory("snuffles", sound).
mapToCategory("humms", sound).
mapToCategory("chortles", sound).
mapToCategory("chatters", sound).
mapToCategory("booms", sound).
mapToCategory("hoots", sound).
mapToCategory("squawks", sound).
mapToCategory("calls", sound).
mapToCategory("hisses", sound).
mapToCategory("clacks", sound).
mapToCategory("whistles", sound).
mapToCategory("howls", sound).

mapToCategory("is omnivore", diet).
mapToCategory("is carnivore", diet).
mapToCategory("is herbivore", diet).

mapToCategory("is domestic", habitat).
mapToCategory("is wild", habitat).

mapToCategory("does it run", movement).
mapToCategory("does it fly", movement).
mapToCategory("does it swim", movement).
mapToCategory("does it crawl", movement).
mapToCategory("does it hop", movement).

mapToCategory("is tiny", size).
mapToCategory("is small", size).
mapToCategory("is regular-sized", size).
mapToCategory("is large", size).
mapToCategory("is huge", size).

mapToCategory("has fur", coating).
mapToCategory("has feathers", coating).
mapToCategory("has scales", coating).
mapToCategory("has skin", coating).
mapToCategory("has spines", coating).
mapToCategory("has jelly", coating).
mapToCategory("has denticles", coating).
mapToCategory("has shell", coating).

animals([
        animal(dog, [is_true("is omnivore"), is_true("is regular-sized"), is_true("does it run"), is_true("has fur"), is_true("is domestic"), is_true("barks")]),
        animal(chicken, [is_true("is omnivore"), is_true("is small"), is_true("does it run"), is_true("has feathers"), is_true("is domestic"), is_true("clucks")]),
        animal(bat, [is_true("is omnivore"), is_true("is small"), is_true("does it fly"), is_true("has fur"), is_true("is wild"), is_true("screeches")]),
        animal(chameleon, [is_true("is omnivore"), is_true("is small"), is_true("does it crawl"), is_true("has scales"), is_true("is wild"), is_true("hisses")]),        
        animal(dinosaur, [is_true("is omnivore"), is_true("is huge"), is_true("does it run"), is_true("has scales"), is_true("is wild"), is_true("roars")]),
        animal(cat, [is_true("is carnivore"), is_true("is small"), is_true("does it run"), is_true("has fur"), is_true("is domestic"), is_true("says meow")]),
        animal(cheetah, [is_true("is carnivore"), is_true("is large"), is_true("does it run"), is_true("has fur"), is_true("is wild"), is_true("chirps")]),
        animal(crocodile, [is_true("is carnivore"), is_true("is large"), is_true("does it crawl"), is_true("has scales"), is_true("is wild"), is_true("roars")]),
        animal(camel, [is_true("is herbivore"), is_true("is large"), is_true("does it run"), is_true("has fur"), is_true("is domestic"), is_true("grunts")]),
        animal(cow, [is_true("is herbivore"), is_true("is large"), is_true("does it run"), is_true("has fur"), is_true("is domestic"), is_true("says moo")]),
        animal(deer, [is_true("is herbivore"), is_true("is large"), is_true("does it run"), is_true("has fur"), is_true("is wild"), is_true("bleats")])
        ]).
        
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
        (mapToCategory(Q, Category) ->
            updateCategory(Category, Q, Answer, Known0, Known)
        ;
            Known = [known(Q, Answer)|Known0]))).

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

% Helper predicate to update known facts based on category
% if the answer is yes, then the rule is true and all other rules in the same category are false
updateCategory(Category, Q, yes, Known0, Known) :-
    findall(known(OtherQ, no), (mapToCategory(OtherQ, Category), OtherQ \= Q), OtherQs),
    append([known(Q, yes)|OtherQs], Known0, Known).
% if the answer is no, then the rule is false
updateCategory(_, Q, no, Known0, [known(Q, no)|Known0]).

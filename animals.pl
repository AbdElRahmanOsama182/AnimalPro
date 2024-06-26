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

mapToCategory("is omnivore (eats both plants and animals)", diet).
mapToCategory("is carnivore (Meat-Eater)", diet).
mapToCategory("is herbivore (Plant-Eater)", diet).

mapToCategory("is domestic", habitat).
mapToCategory("is wild", habitat).

mapToCategory("does it run", movement).
mapToCategory("does it fly", movement).
mapToCategory("does it swim", movement).
mapToCategory("does it crawl", movement).
mapToCategory("does it climb", movement).
mapToCategory("does it hop", movement).
mapToCategory("does it fly & swim", movement).
mapToCategory("does it swim & run", movement).

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
        animal(dinosaur, [is_true("is omnivore (eats both plants and animals)"), is_true("is huge"), is_true("does it run"), is_true("has scales"), is_true("is wild"), is_true("roars")]),
        animal(ostrich, [is_true("is omnivore (eats both plants and animals)"), is_true("is large"), is_true("does it run"), is_true("has feathers"), is_true("is wild"), is_true("booms")]),
        animal(dog, [is_true("is omnivore (eats both plants and animals)"), is_true("is regular-sized"), is_true("does it run"), is_true("has fur"), is_true("is domestic"), is_true("barks")]),
        animal(monkey, [is_true("is omnivore (eats both plants and animals)"), is_true("is regular-sized"), is_true("does it climb"), is_true("has fur"), is_true("is wild"), is_true("chatters")]),
        animal('flying fish', [is_true("is omnivore (eats both plants and animals)"), is_true("is small"), is_true("does it fly & swim"), is_true("has scales"), is_true("is wild"), is_true("is silent")]),
        animal(penguin, [is_true("is omnivore (eats both plants and animals)"), is_true("is small"), is_true("does it swim & run"), is_true("has fur"), is_true("is domestic"), is_true("squawks")]),
        animal(chicken, [is_true("is omnivore (eats both plants and animals)"), is_true("is small"), is_true("does it run"), is_true("has feathers"), is_true("is domestic"), is_true("clucks")]),
        animal(bat, [is_true("is omnivore (eats both plants and animals)"), is_true("is small"), is_true("does it fly"), is_true("has fur"), is_true("is wild"), is_true("screeches")]),
        animal(turtle, [is_true("is omnivore (eats both plants and animals)"), is_true("is small"), is_true("does it swim"), is_true("has skin"), is_true("is wild"), is_true("clacks")]),
        animal(chameleon, [is_true("is omnivore (eats both plants and animals)"), is_true("is small"), is_true("does it crawl"), is_true("has scales"), is_true("is wild"), is_true("hisses")]),        
        animal(lizard, [is_true("is omnivore (eats both plants and animals)"), is_true("is small"), is_true("does it crawl"), is_true("has scales"), is_true("is wild"), is_true("is silent")]),
        animal(hedgehog, [is_true("is omnivore (eats both plants and animals)"), is_true("is small"), is_true("does it crawl"), is_true("has spines"), is_true("is wild"), is_true("snuffles")]),
        animal(rat, [is_true("is omnivore (eats both plants and animals)"), is_true("is tiny"), is_true("does it run"), is_true("has fur"), is_true("is domestic"), is_true("screeches")]),
        
        animal(whale, [is_true("is carnivore (Meat-Eater)"), is_true("is huge"), is_true("does it swim"), is_true("has skin"), is_true("is wild"), is_true("whistles")]),
        animal(lion, [is_true("is carnivore (Meat-Eater)"), is_true("is large"), is_true("does it run"), is_true("has fur"), is_true("is wild"), is_true("roars"),is_true("known as the king of the jungle")]),
        animal(tiger, [is_true("is carnivore (Meat-Eater)"), is_true("is large"), is_true("does it run"), is_true("has fur"), is_true("is wild"), is_true("roars")]),
        animal(dolphin, [is_true("is carnivore (Meat-Eater)"), is_true("is large"), is_true("does it swim"), is_true("has skin"), is_true("is wild"), is_true("clicks")]),
        animal(shark, [is_true("is carnivore (Meat-Eater)"), is_true("is large"), is_true("does it swim"), is_true("has denticles"), is_true("is wild"), is_true("is silent")]),
        animal(wolf, [is_true("is carnivore (Meat-Eater)"), is_true("is large"), is_true("does it run"), is_true("has fur"), is_true("is wild"), is_true("howls")]),
        animal(cheetah, [is_true("is carnivore (Meat-Eater)"), is_true("is large"), is_true("does it run"), is_true("has fur"), is_true("is wild"), is_true("chirps")]),
        animal(crocodile, [is_true("is carnivore (Meat-Eater)"), is_true("is large"), is_true("does it crawl"), is_true("has scales"), is_true("is wild"), is_true("roars")]),
        animal(eagle, [is_true("is carnivore (Meat-Eater)"), is_true("is large"), is_true("does it fly"), is_true("has feathers"), is_true("is wild"), is_true("screeches")]),
        animal(snake, [is_true("is carnivore (Meat-Eater)"), is_true("is regular-sized"), is_true("does it crawl"), is_true("has skin"), is_true("is wild"), is_true("hisses")]),
        animal(cat, [is_true("is carnivore (Meat-Eater)"), is_true("is small"), is_true("does it run"), is_true("has fur"), is_true("is domestic"), is_true("says meow")]),
        animal(octopus, [is_true("is carnivore (Meat-Eater)"), is_true("is small"), is_true("does it swim"), is_true("has skin"), is_true("is wild"), is_true("is silent")]),
        animal(owl, [is_true("is carnivore (Meat-Eater)"), is_true("is small"), is_true("does it fly"), is_true("has feathers"), is_true("is wild"), is_true("hoots")]),
        animal(frog, [is_true("is carnivore (Meat-Eater)"), is_true("is small"), is_true("does it hop"), is_true("has skin"), is_true("is wild"), is_true("croaks")]),
        animal(jellyfish, [is_true("is carnivore (Meat-Eater)"), is_true("is small"), is_true("does it swim"), is_true("has jelly"), is_true("is wild"), is_true("is silent")]),
        
        animal(hippopotamus, [is_true("is herbivore (Plant-Eater)"), is_true("is huge"), is_true("does it swim & run"), is_true("has skin"), is_true("is wild"), is_true("grunts")]),
        animal(giraffe, [is_true("is herbivore (Plant-Eater)"), is_true("is huge"), is_true("does it run"), is_true("has fur"), is_true("is wild"), is_true("bleats")]),
        animal(elephant, [is_true("is herbivore (Plant-Eater)"), is_true("is huge"), is_true("does it run"), is_true("has skin"), is_true("is wild"), is_true("trumpets")]),
        animal(kangaroo, [is_true("is herbivore (Plant-Eater)"), is_true("is large"), is_true("does it hop"), is_true("has fur"), is_true("is wild"), is_true("chortles")]),
        animal(panda, [is_true("is herbivore (Plant-Eater)"), is_true("is large"), is_true("does it climb"), is_true("has fur"), is_true("is wild"), is_true("bleats")]),
        animal(cow, [is_true("is herbivore (Plant-Eater)"), is_true("is large"), is_true("does it run"), is_true("has fur"), is_true("is domestic"), is_true("says moo")]),
        animal(deer, [is_true("is herbivore (Plant-Eater)"), is_true("is large"), is_true("does it run"), is_true("has fur"), is_true("is wild"), is_true("bleats")]),
        animal(camel, [is_true("is herbivore (Plant-Eater)"), is_true("is large"), is_true("does it run"), is_true("has fur"), is_true("is domestic"), is_true("grunts")]),
        animal(zebra, [is_true("is herbivore (Plant-Eater)"), is_true("is large"), is_true("does it run"), is_true("has fur"), is_true("is wild"), is_true("barks")]),
        animal(peacock, [is_true("is herbivore (Plant-Eater)"), is_true("is regular-sized"), is_true("does it run"), is_true("has feathers"), is_true("is wild"), is_true("calls")]),
        animal(parrot, [is_true("is herbivore (Plant-Eater)"), is_true("is small"), is_true("does it fly"), is_true("has feathers"), is_true("is domestic"), is_true("squawks")]),
        animal(hummingbird, [is_true("is herbivore (Plant-Eater)"), is_true("is tiny"), is_true("does it fly"), is_true("has feathers"), is_true("is wild"), is_true("humms")])
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

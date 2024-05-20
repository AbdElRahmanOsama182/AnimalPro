# AnimalPro

Welcome to AnimalPro, your expert guide in the world of zoology! AnimalPro is an application designed to assist users in identifying various species of animals quickly and accurately. Powered by Prolog's logical programming capabilities and PyQt's graphical interface.

![Untitled](assets/Untitled.png)

## Overview:

AnimalPro uses a knowledge base of facts and rules in Prolog to facilitate the identification of animals. Users interact with the AnimalPro through PyQt GUI, where they can answer yes or no to questions about the characteristics of an animal, such as its habitat, physical features, sound, diet, and behavior. Behind the scenes, AnimalPro leverages Prolog's inference engine to deduce the most likely matches based on the provided criteria.

## Key Features:

1. **Categories and Characteristics Mapping**:
    
    AnimalPro maps animal characteristics to specific categories, helping in organizing data, which simplifies the rule-checking process.
    
2. **Animal Definitions:**
    
    AnimalPro defines an extensive list of animals along with their characteristics. Each animal is represented as a term with two arguments: the name of the animal and a list of characteristics.
    
3. **Rule-Based Inference**:
    1.  Characteristics of animals are represented as rules.
    2.  Check each rule against the characteristics of animals in the knowledge base, by recursively traversing the list of animals and evaluating each rule against the characteristics of each animal.
4. **Interactive Querying**:
    
    AnimalPro interacts with the user by asking questions about the characteristics of the animal they are interested in, then updates the known facts based on the user's answers.
    

## How to Run:

1. Install SWI-Prolog from the official site: [https://www.swi-prolog.org/download/stable](https://www.swi-prolog.org/download/stable)
2.  Clone AnimalPro repository.
3. Jump into AnimalPro directory:

```bash
cd AnimalPro
```

4. Open the SWI-Prolog terminal:

```bash
swipl
```

5. Install the **`reif`** package:

```bash
pack_install(reif).
```

6. Consult the **`animals.pl`** file:

```bash
consult('animals.pl').
```

7. Go back to the terminal
8. Install required Python packages:

```bash
pip install -r requirements.txt
```

9. Run the GUI:

```bash
python GUI.py
```

## Conclusion:

If you find a weird animal in your backyard, don't worry! You can use AnimalPro to learn more about it. Just tell us what it looks like or any special things it does, and we'll try to tell you what it might be.

- A Trial Video:
    
    [AnimalPro.mp4](assets/AnimalPro.mp4)

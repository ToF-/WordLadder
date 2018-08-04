

- on a fini le kata ! :) 
- le programme naif haskell va plus vite que le programme naif Rust (mackwic: :( )
- satisfait de la couverture et du flow
- on a fait du inside-out
- on (TOF) a eu un plan en 3 steps:
    1. les mots adjacents
    2. cheminer dans un graphe marqué
    3. fouiller un graphe en largeur en le marquant (de manière mutable)  
    
- Wow, plein de `.clones()` partout !
    - Tof: il faut des helpers !
    - C'est comme une voiture qui broute en changeant de vitesse: difficile d'écrire les annotations de variable du premier coup ! :(
    - mackwic: c'est parce que c'est pas des choix informés
    - Trop pressé de faire l'algo et finir plutot que passer du temps
    - Besoin d'une seconde session pour nettoyer les clones, sélectionner les bon types
        - ex: pourquoi pas des int autant que possible ?
        - on est stringly typed partout, il ça manque d'abstraction de types

- On a abordé les aspects de programmation défensive
    - où protéger le code ?
    - Tof: aux limites des méthodes publiques
    - TDD + Typage devrait garantir les propriétés internes + parfois les assertions pour documenter
    - mackwic: TIL que assertion n'est pas de la programmation défensive
  
- mackwic: j'ai mis du temps à comprendre les couches de ton design
    - Tof: je ne comprenais pas la nuance entre accessible et public

- mackwic: J'aurais pété une durite plus vite sur les given à rallonge
    - TOF: tout le code de test est à factoriser
    - des helpers principalement, mais tout ce qui est possible
(define (problem aldrics-quest-for-light)
    (:domain valdoria-quest)
    (:objects
        aldric - prince
        king-father - king
        valdorian-council - council-member
        shadow-legion-guards - shadow-creature
        crystal-of-eternal-light - crystal
        royal-castle - castle
        forbidden-mountains - forbidden-mountains
        treacherous-path - treacherous-path
    )

    (:init
        ;; Initial state: Prince Aldric is in the royal castle of Valdoria.
        (at aldric royal-castle)

        ;; Prince Aldric has just discovered a prophecy about the Crystal.
        (knows-prophecy aldric)

        ;; The kingdom is currently afflicted by the ancient curse.
        (curse-active)

        ;; Obstacle 1: His overprotective father, who forbids him from leaving the castle.
        (at king-father royal-castle)
        (king-forbids-departure)

        ;; Obstacle 2: A treacherous council plotting to usurp the throne in his absence.
        (at valdorian-council royal-castle) ; Assuming the council is also physically present in the castle
        (council-plotting)

        ;; Obstacle 3: The Shadow Legion, dark creatures that guard the Crystal of Eternal Light in the Forbidden Mountains.
        (at shadow-legion-guards forbidden-mountains)
        (legion-guards forbidden-mountains)

        ;; The Crystal of Eternal Light is in the Forbidden Mountains, but not yet located or acquired by Aldric.
        ;; (The 'at crystal-of-eternal-light forbidden-mountains' is implied by the quest and the find-crystal-of-light action's effects,
        ;; as items without an 'at' predicate for all objects are generally considered to be at their fixed location or acquired.)
    )

    (:goal (and
        ;; Goal: Find the Crystal of Eternal Light in the Forbidden Mountains to break the ancient curse on Valdoria and save the kingdom.
        (kingdom-saved)
    ))
)
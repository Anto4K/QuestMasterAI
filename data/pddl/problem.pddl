(define (problem playful-hunt-quest)
    (:domain playful-hunt)
    (:objects
        lupo1 - wolf
        agnello1 - lamb
        prato1 collina1 ruscello1 - location ; Multiple locations to allow for movement and branching in 'engage-in-chase-game'.
    )

    (:init
        ;; Initial state as per quest description: "Il lupo ha fame e individua un agnello come sua prossima preda."
        (hungry lupo1)
        (sees lupo1 agnello1)
        (at lupo1 prato1)
        (at agnello1 prato1)

        ;; Obstacles:
        ;; 1. "L'agnello e' particolarmente vivace e sfuggente."
        ;; 2. "Il lupo, data la sua natura giocherellona, fatica a rimanere serio e concentrato sulla caccia."
        ;; 3. "La caccia si trasforma in un gioco a rincorrersi, con il lupo che deve mantenere la sua pretesa di minaccia."
        ;; These obstacles are implicitly overcome by the successful execution of the 'engage-in-chase-game' action,
        ;; which then sets the 'ready-to-catch' predicate, signifying the wolf's readiness and the lamb's exhaustion/acceptance of the game's turn.

        ;; Initial state of dynamic predicates, set to false
        (not (chasing lupo1 agnello1))
        (not (ready-to-catch lupo1 agnello1))
        (not (eaten agnello1))
    )

    ;; Goal consistent with the quest: "Il lupo deve catturare e mangiare l'agnello in maniera giocosa."
    (:goal (and
        (eaten agnello1)
    ))
)
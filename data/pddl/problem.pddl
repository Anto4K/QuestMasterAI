(define (problem elia-quest-for-rain)
    (:domain elia-quest)
    (:objects
        elia - protagonist
        village - location
        forest - location
        magic-spring - magical-source
    )

    (:init
        ;; Initial state as per quest description:
        ;; "Elia si trova nel suo villaggio, afflitto da una grave siccit√ .
        ;; La comunit√  √® senza speranza e crede che la Fonte Magica sia irrimediabilmente spenta."
        (at elia village)
        (has-drought village)
        (spring-dormant magic-spring)

        ;; Obstacles / Conditions:
        ;; "La siccit√  che affligge il villaggio e mina la speranza." - Covered by (has-drought village).
        ;; "La paura degli abitanti del villaggio che impedisce a chiunque altro di agire." - Implies Elia acts alone.
        ;; "Il silenzio e l'ignoto del bosco, che Elia deve attraversare da sola." - Paths defined, Elia is the only actor.
        (elias-courageous elia) ; Elia possesses the courage to face the unknown.

        ;; "L'acqua della Fonte Magica √® ferma e inerte, priva di vita." - Covered by (spring-dormant magic-spring).

        ;; Define paths between locations:
        (path-exists village forest)
        (path-exists forest magic-spring)
        ;; Optional: Allow return paths for more flexibility, though not strictly needed for the stated goal.
        (path-exists forest village)
        (path-exists magic-spring forest)
    )

    ;; Goal consistent with the quest:
    ;; "Raggiungere la Fonte Magica nel cuore della foresta, risvegliarla con il potere delle sue storie,
    ;; e far tornare la pioggia al villaggio."
    (:goal (and
        (at elia magic-spring) ; Elia must reach the Magic Spring.
        (spring-active magic-spring) ; The Magic Spring must be awakened.
        (rain-returned village) ; Rain must return to the village.
    ))
)
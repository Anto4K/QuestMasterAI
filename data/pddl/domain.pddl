(define (domain playful-hunt)
    (:requirements :strips :typing)
    (:types
        animal
        wolf lamb - animal
        location
    )

    (:predicates
        (at ?a - animal ?l - location) ; An animal is at a specific location.
        (hungry ?w - wolf) ; Indicates the wolf is hungry.
        (sees ?w - wolf ?l - lamb) ; Indicates the wolf sees the lamb.
        (chasing ?w - wolf ?l - lamb) ; The wolf is actively pursuing the lamb.
        (ready-to-catch ?w - wolf ?l - lamb) ; This predicate signifies that the obstacles (elusive lamb, playful wolf, game of chase) have been overcome, and the conditions for capture are met.
        (eaten ?l - lamb) ; The lamb has been "eaten" (final goal, interpreted in a playful context).
    )

    ;; Action: The wolf initiates the playful pursuit of the lamb.
    ;; This action transitions the wolf from being hungry and spotting the lamb to actively chasing it.
    (:action start-chase
        :parameters (?w - wolf ?l - lamb ?loc - location)
        :precondition (and
            (at ?w ?loc)
            (at ?l ?loc)
            (hungry ?w)
            (sees ?w ?l)
        )
        :effect (and
            (chasing ?w ?l)
            (not (hungry ?w))
            (not (sees ?w ?l))
        )
    )

    ;; Action: The wolf and lamb engage in a playful game of chase.
    ;; This action embodies the "game of chase" obstacle. By its completion, it implicitly resolves the lamb's
    ;; elusiveness (the lamb becomes sufficiently tired) and the wolf's playful nature (the wolf maintains
    ;; enough "pretense of threat" or focus during the game). This sets the 'ready-to-catch' condition.
    (:action engage-in-chase-game
        :parameters (?w - wolf ?l - lamb ?from ?to - location)
        :precondition (and
            (at ?w ?from)
            (at ?l ?from)
            (chasing ?w ?l)
            (not (ready-to-catch ?w ?l)) ; They are not yet ready for capture.
        )
        :effect (and
            (not (at ?w ?from))
            (not (at ?l ?from))
            (at ?w ?to)
            (at ?l ?to)
            (ready-to-catch ?w ?l) ; After this playful interaction, the conditions for capture are met.
        )
    )

    ;; Action: The wolf performs the playful capture and "eating" of the lamb.
    ;; This action achieves the quest's final goal once the conditions for capture are set by the chase game.
    (:action perform-playful-capture
        :parameters (?w - wolf ?l - lamb ?loc - location)
        :precondition (and
            (at ?w ?loc)
            (at ?l ?loc)
            (ready-to-catch ?w ?l) ; Wolf and lamb are in the state where capture is possible.
            (chasing ?w ?l) ; The playful chase is still ongoing up to the point of capture.
        )
        :effect (and
            (eaten ?l) ; The lamb is "eaten" playfully, achieving the goal.
            (not (chasing ?w ?l)) ; The chase ends with the capture.
            (not (ready-to-catch ?w ?l)) ; The conditions for capture are no longer relevant as it's completed.
        )
    )
)
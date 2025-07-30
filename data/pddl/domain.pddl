(define (domain elia-quest)
    (:requirements :strips :typing)
    (:types
        person
        location
        protagonist - person ; Elia, the main character.
        magical-source - location ; The Magic Spring, a special location.
    )

    (:predicates
        (at ?p - person ?l - location) ; Indicates where a person is located.
        (has-drought ?l - location) ; Signifies that a location (e.g., the village) is suffering from drought.
        (spring-dormant ?s - magical-source) ; The state where the Magic Spring is lifeless and inactive.
        (spring-active ?s - magical-source) ; The state where the Magic Spring is revived and flowing.
        (rain-returned ?l - location) ; Indicates that rain has returned to a specific location, resolving the drought.
        (path-exists ?from ?to - location) ; A general predicate indicating a navigable path between two locations.
        (elias-courageous ?p - protagonist) ; Elia's inherent courage to undertake the journey alone.
    )

    ;; Action: Elia moves from one location to another.
    ;; This action represents Elia traversing various areas, including the mysterious forest.
    (:action go
        :parameters (?p - protagonist ?from ?to - location)
        :precondition (and
            (at ?p ?from)
            (path-exists ?from ?to)
            (elias-courageous ?p) ; Elia's courage allows her to venture into the unknown.
        )
        :effect (and
            (not (at ?p ?from))
            (at ?p ?to)
        )
    )

    ;; Action: Elia awakens the Magic Spring with the power of her stories.
    ;; This is the central magical action that resolves the main quest objective.
    (:action awaken-spring
        :parameters (?p - protagonist ?spring - magical-source ?village - location)
        :precondition (and
            (at ?p ?spring)
            (spring-dormant ?spring)
            (not (spring-active ?spring)) ; Ensure it's not already active.
            (has-drought ?village) ; The spring must be awakened to end the drought.
            (elias-courageous ?p) ; Elia's courage is needed for this significant act.
        )
        :effect (and
            (not (spring-dormant ?spring))
            (spring-active ?spring)
            (not (has-drought ?village)) ; The drought at the village ends.
            (rain-returned ?village) ; Rain returns to the village as a result.
        )
    )
)
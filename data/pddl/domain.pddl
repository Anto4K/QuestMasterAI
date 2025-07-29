(define (domain valdoria-quest)
    (:requirements :strips :typing)
    (:types
        character ; Generic type for intelligent entities (persons, creatures)
        location ; Places in the world
        item ; Tangible objects that can be acquired
        prince king council-member shadow-creature - character ; Specific character types
        crystal prophecy - item ; Specific item types
        castle forbidden-mountains treacherous-path - location ; Specific locations in Valdoria
    )

    (:predicates
        ;; Predicate: A character is at a specific location.
        (at ?c - character ?l - location)
        ;; Predicate: The prince possesses an item.
        (has ?p - prince ?i - item)

        ;; Predicate: Prince Aldric has discovered the prophecy.
        (knows-prophecy ?p - prince)

        ;; Predicate: Indicates the ancient curse is still afflicting Valdoria.
        (curse-active)
        ;; Predicate: The ultimate goal - the kingdom's curse is broken and saved.
        (kingdom-saved)

        ;; Obstacle 1 Predicates: The overprotective father (King)
        ;; The King currently prevents Aldric from leaving the castle.
        (king-forbids-departure)
        ;; The King has been convinced by Aldric to allow his departure.
        (king-persuaded)

        ;; Obstacle 2 Predicates: Treacherous council
        ;; The council is actively plotting to usurp the throne in Aldric's absence.
        (council-plotting)
        ;; The council's internal threat has been dealt with.
        (council-neutralized)

        ;; Obstacle 3 Predicates: The Shadow Legion
        ;; The Shadow Legion guards a specific location (the Forbidden Mountains).
        (legion-guards ?l - location)
        ;; The Shadow Legion has been defeated at a location.
        (legion-defeated ?l - location)

        ;; Predicate for the Crystal of Eternal Light
        ;; The Crystal of Eternal Light has been successfully located/found.
        (crystal-located)
    )

    ;; Action: Discover and understand the prophecy
    ;; Prince Aldric reads the ancient prophecy, becoming aware of his quest.
    (:action discover-prophecy
        :parameters (?p - prince ?cas - castle)
        :precondition (and
            (at ?p ?cas)
            (not (knows-prophecy ?p)) ; Ensure he hasn't already discovered it
        )
        :effect (and
            (knows-prophecy ?p)
        )
    )

    ;; Action: Persuade the overprotective King
    ;; Aldric must convince his father to allow him to leave on the perilous quest,
    ;; using the prophecy as justification.
    (:action persuade-king
        :parameters (?p - prince ?k - king ?cas - castle)
        :precondition (and
            (at ?p ?cas)
            (at ?k ?cas)
            (knows-prophecy ?p)
            (king-forbids-departure)
        )
        :effect (and
            (not (king-forbids-departure))
            (king-persuaded)
        )
    )

    ;; Action: Neutralize the treacherous council
    ;; Aldric must secure the kingdom from internal threats before embarking on his journey,
    ;; preventing the council from usurping the throne in his absence.
    (:action neutralize-council
        :parameters (?p - prince ?c - council-member ?cas - castle)
        :precondition (and
            (at ?p ?cas)
            (at ?c ?cas) ; Assuming council members are also at the castle
            (knows-prophecy ?p)
            (council-plotting)
        )
        :effect (and
            (not (council-plotting))
            (council-neutralized)
        )
    )

    ;; Action: Leave the royal castle
    ;; This action allows the prince to begin his external journey,
    ;; requiring both his father's permission and the council's neutralization.
    (:action leave-royal-castle
        :parameters (?p - prince ?from - castle ?to - treacherous-path)
        :precondition (and
            (at ?p ?from)
            (king-persuaded)
            (council-neutralized)
            (knows-prophecy ?p)
        )
        :effect (and
            (not (at ?p ?from))
            (at ?p ?to)
        )
    )

    ;; Action: Traverse a path towards the Forbidden Mountains
    ;; General action for moving between intermediate locations on the quest.
    (:action traverse-path
        :parameters (?p - prince ?from - treacherous-path ?to - forbidden-mountains)
        :precondition (and
            (at ?p ?from)
            (knows-prophecy ?p)
        )
        :effect (and
            (not (at ?p ?from))
            (at ?p ?to)
        )
    )

    ;; Action: Confront and defeat the Shadow Legion
    ;; Aldric must overcome the dark creatures guarding the Crystal of Eternal Light.
    (:action confront-shadow-legion
        :parameters (?p - prince ?sc - shadow-creature ?fm - forbidden-mountains)
        :precondition (and
            (at ?p ?fm)
            (at ?sc ?fm) ; The Shadow Legion is present at this location
            (legion-guards ?fm)
            (knows-prophecy ?p)
        )
        :effect (and
            (not (legion-guards ?fm))
            (legion-defeated ?fm)
        )
    )

    ;; Action: Find the Crystal of Eternal Light
    ;; After overcoming the guardians, Aldric can locate and acquire the Crystal.
    (:action find-crystal-of-light
        :parameters (?p - prince ?c - crystal ?fm - forbidden-mountains)
        :precondition (and
            (at ?p ?fm)
            (legion-defeated ?fm)
            (knows-prophecy ?p)
        )
        :effect (and
            (crystal-located)
            (has ?p ?c)
        )
    )

    ;; Action: Break the ancient curse
    ;; The final step: Aldric uses the Crystal of Eternal Light to save Valdoria.
    (:action break-ancient-curse
        :parameters (?p - prince ?c - crystal ?fm - forbidden-mountains)
        :precondition (and
            (at ?p ?fm)
            (has ?p ?c)
            (crystal-located)
            (curse-active)
        )
        :effect (and
            (not (curse-active))
            (kingdom-saved)
        )
    )
)
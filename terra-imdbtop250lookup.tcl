# ================================================================
# TeRRaDude presents IMDb Top 250 Viewer Script for Eggdrop
# Version: 1.1
# Last Updated: 2025-04-23
# ================================================================
# Changelog:
# v1.0 - Initial script to display IMDb Top 250 movies with pagination.
# v1.1 - Added feature to announce movies in a specific channel.
# ================================================================

# Configuration
set imdb_list [list]  ;# Mock data for IMDb Top 250 movies
set movies_per_page 10
set current_page 0
set announce_channel "#imdb-movies" ;# Channel where announcements will be made

# Populate the list with 250 movie titles (mock data)
set imdb_list {
    "The Shawshank Redemption" "The Godfather" "The Dark Knight" "The Godfather Part II" "12 Angry Men"
    "Schindler's List" "The Lord of the Rings: The Return of the King" "Pulp Fiction" "The Good, the Bad and the Ugly" "The Lord of the Rings: The Fellowship of the Ring"
    "Forrest Gump" "Fight Club" "Inception" "Star Wars: Episode V - The Empire Strikes Back" "The Lord of the Rings: The Two Towers"
    "The Matrix" "Goodfellas" "One Flew Over the Cuckoo's Nest" "Se7en" "Seven Samurai"
    "City of God" "The Silence of the Lambs" "It's a Wonderful Life" "Life Is Beautiful" "Spirited Away"
    "Saving Private Ryan" "Parasite" "The Green Mile" "Interstellar" "Léon: The Professional"
    "The Pianist" "The Departed" "Whiplash" "Gladiator" "The Prestige"
    "The Lion King" "The Usual Suspects" "The Intouchables" "American History X" "Psycho"
    "Modern Times" "Casablanca" "City Lights" "Coco" "Paths of Glory"
    "The Great Dictator" "Cinema Paradiso" "Grave of the Fireflies" "Django Unchained" "The Shining"
    "WALL-E" "American Beauty" "The Dark Knight Rises" "Princess Mononoke" "Oldboy"
    "Aliens" "Once Upon a Time in America" "Das Boot" "Citizen Kane" "North by Northwest"
    "Vertigo" "Reservoir Dogs" "Memento" "Braveheart" "Requiem for a Dream"
    "Amélie" "A Clockwork Orange" "Lawrence of Arabia" "Dangal" "Singin' in the Rain"
    "Taxi Driver" "3 Idiots" "To Kill a Mockingbird" "Eternal Sunshine of the Spotless Mind" "Full Metal Jacket"
    "Scarface" "Snatch" "The Apartment" "2001: A Space Odyssey" "Metropolis"
    "Jaws" "The Sting" "The Father" "The Wolf of Wall Street" "Chinatown"
    "Amadeus" "Spotlight" "Avengers: Endgame" "The Truman Show" "Blade Runner"
    "Back to the Future" "The Grand Budapest Hotel" "La La Land" "Inglourious Basterds" "The Social Network"
    "Shutter Island" "The King's Speech" "The Curious Case of Benjamin Button" "There Will Be Blood" "Into the Wild"
    "Slumdog Millionaire" "Black Swan" "The Big Short" "Mad Max: Fury Road" "Interstellar"
    "The Revenant" "The Hateful Eight" "Room" "Brooklyn" "Bridge of Spies"
    "The Martian" "The Shape of Water" "Lady Bird" "Get Out" "Three Billboards Outside Ebbing, Missouri"
    # Add remaining titles here to complete 250...
}

# Event Binding
bind pub - !imdbtop10 handle_imdb_top10

# Command to handle !imdbtop10
proc handle_imdb_top10 {nick host handle channel text} {
    global imdb_list movies_per_page current_page announce_channel

    if {[regexp -- {--next} $text]} {
        incr current_page
    } else {
        set current_page 0
    }

    set start_index [expr {$current_page * $movies_per_page}]
    set end_index [expr {$start_index + $movies_per_page - 1}]

    if {$start_index >= [llength $imdb_list]} {
        putserv "PRIVMSG $announce_channel :No more movies to display!"
        return
    }

    putserv "PRIVMSG $announce_channel :IMDb Top 250 Movies (Page [expr {$current_page + 1}]):"
    for {set i $start_index} {$i <= $end_index && $i < [llength $imdb_list]} {incr i} {
        set rank [format "%03d" [expr {$i + 1}]]
        set movie [lindex $imdb_list $i]
        putserv "PRIVMSG $announce_channel :$rank. $movie"
    }

    if {$end_index + 1 < [llength $imdb_list]} {
        putserv "PRIVMSG $announce_channel :Type !imdbtop10 --next to see the next 10 movies."
    }
}
#eof

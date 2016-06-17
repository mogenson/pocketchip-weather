#!/bin/bash
# this script fetches the current weather from http:wttr.in
# and formats it in a way that's nice for the PocketCHIP
# author: michael.mogenson@gmail.com

# global variables
LOCATION=""
INTERVAL=0

function print_help {
    echo
    echo "fetch current weather from http://wttr.in"
    echo
    echo "set location with -l followed by zipcode or city name"
    echo "    no argument will use location from your ip address"
    echo "set time interval with -i followed by number of minutes"
    echo "    no argument will fetch weather once then exit"
    echo
}

function get_arguments {
    while getopts ":hl:i:" OPTION; do
        case ${OPTION} in
            h)  # show help message
                print_help
                exit 0
                ;;
            l)  # set location
                LOCATION=$OPTARG
                ;;
            i)  # set time interval
                INTERVAL=$OPTARG
                ;;
            \?)
                echo "invalid option: -$OPTARG"
                exit 1
                ;;
            :)
                echo "option -$OPTARG requires an argument"
                exit 1
                ;;
        esac
    done
}

function fetch_weather {
    for i in {1..12}
    do
        echo # clear the terminal with a bunch of blank lines
    done

    # get the current weather because that's all that will fit on the screen
    local WEATHER=$(curl -s wttr.in/"$LOCATION" | head -n 7)

    # PocketCHIP's terminal app can't display all characters :(
    # strip out the characters that won't render like arrows and degree signs
    WEATHER=$(echo "$WEATHER" | tr -d '\200-\377')

    echo "$WEATHER" # display the weather

    sleep "$((INTERVAL * 60))"
}

function main {
    get_arguments "$@" # get user input

    fetch_weather # fetch at least once

    if [ "$INTERVAL" -eq 0 ]
    then
        exit 0
    fi
    
    xset -s off -dpms # keep screen from blanking

    while true
    do
        fetch_weather # fetch weather continuously
    done
}

main "$@" # program enters here

# Current weather script for PocketCHIP

![alt tag](image.jpg)

### Here's a BASH script to fetch the current weather from http//wttr.in and display it in ASCII in the PocketCHIP's terminal.

Download from your PocketCHIP with the command: `wget http://tiny.cc/getweather`

Make it executable with: `chmod +x getweather`

And run it with: `./getweather`

Provide a location with: `./getweather -l 02139` or `./getweather -l "Cambridge MA"`
By default the http://wttr.in weather service will look up your location from your IP address.

Provide a time interval in minutes between weather updates with: `./getweather -i 10`
By default the script will fetch the weather once then exit.

Use `./getweather -h` for a usage reminder.

Dont forget to increase the text size in your terminal so the weather diagram fills the screen.

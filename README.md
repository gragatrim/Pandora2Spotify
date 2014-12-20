Pandora2Spotify
===============

This will take a pandora station and convert it to a spotify playlist. It has a few manual bits you need to enter, but beyond that, it should just work!

##How to run pandora2spotify

sh pandora2spotify.sh <pandora_station_id> <temp_file_to_put_artists_songs> <spotify_username> <spotify_playlist_id> <oauth_token>

Below I outline how to get the necessary arguments if you don't know how to find them yourself

##Limitations
* Written in bash and awk, because I like them, no other reason
* Searching spotify's song database isn't the smartest, this just grabs the first result
* No real error checking or hand holding when calling
* Produces a fair bit of output to the console while running

##Instructions
1. Log into pandora and find the station id you will want to copy
  1. Choose a station and view station details, your url should change to show the station id
  2. Should be an integer, eg. 22947617204321760
  3. Sometimes it may not change, then you'll need to use developer tools to find the station id
2. Next you'll need to create a new playlist on spotify
3. Grab the id of the playlist
  1. This will be in the url after you create the playlist
  2. This will be a long string of characters, eg. 71AYLmXpcaikNHdZU2sagc
4. Now you'll need an oauth token
  1. I generated mine by going to https://developer.spotify.com/web-api/console/post-playlist-tracks/
  2. Scroll down until you see "GET OAUTH TOKEN", click that, you'll need to log in
  3. After you log in that input will have a value and you'll need that to use this
  4. The oauth tokens generated don't last very long, so before running make sure to use a fresh one
5. ????
6. Profit!

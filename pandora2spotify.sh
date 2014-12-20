#!/bin/bash
pandora_station=$1
results_file=$2
spotify_user=$3
spotify_playlist=$4
spotify_auth=$5
spotify_ids=()
#if the file exists we will assume data exists so no need to curl
if [ ! -f $results_file ]; then
  i=0
  echo 'Grabbing pandora playlist'
  while [ $(curl -s "http://www.pandora.com/content/station_track_thumbs?stationId=${pandora_station}&page=true&posFeedbackStartIndex=${i}&posSortAsc=false&posSortBy=date&cachebuster%3A=1419029831107" | tee -a ${results_file} | sed 's/\s*//' | uniq | wc -l) -gt 1 ]; do
    let i=$i+10
    printf "*"
  done
fi
tIFS=$IFS
IFS=$'\n'
echo -e "\nTurning pandora playlist into spotify track track uri array"
for result in $(cat ${results_file} | awk -f html_to_spotify); do
  artist=${result#*:}
  track=${result%:*}
  #This isn't very smart, just grabs the first track found, could probably do some more parsing to get better results
  spotify_ids+=( $(curl -s -X GET "https://api.spotify.com/v1/search?q=artist:${artist// /%20/}+track:${track// /%20/}&type=track" | awk -f spotify_parser) )
  printf "."
done
echo -e "\nAdding the first track found based on query for artist & track from pandora list"
for a in ${spotify_ids[@]}; do
  curl -s -X POST "https://api.spotify.com/v1/users/${spotify_user}/playlists/${spotify_playlist}/tracks?position=0&uris=spotify%3Atrack%3A${a}" -H "Accept: application/json" -H "Authorization: Bearer ${spotify_auth}"
  printf "#"
done
IFS=$tIFS

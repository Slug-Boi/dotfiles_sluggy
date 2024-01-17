function setbg {
  cd "/home/slug/Downloads/alberts_dotfiles/dynamic_desktop_script/wallpaper"
  num=$1

  export DISPLAY=:0

  #if [ $num > 1 ]; then
  #  old_bg="$(($num - 1))"

  #  for per in 25 50 75; do
  #  convert fuji-$old_bg.png -fill black -colorize $per% transistion.png
  #  feh --bg-scale transistion.png
  #  done
  #fi

  #sleep 0.5

  feh --bg-scale  fuji-$num.png

  #export DISPLAY=:0 && feh --bg-scale  fuji-$num.png
  notify-send "wallpaper changed"
}

hour=$(date +%H)
time_of_day=$(sunwait poll 55.687760N 12.489840E)
[[ $time_of_day == "DAY" ]] && [ $hour -lt 7 ] && setbg 1 # morning
[[ $time_of_day == "DAY" ]] && [ $hour -lt 12 ] && setbg 2 # formiddag/before midday
[ $hour -gt 11 ] && [ $hour -lt 15 ]            && setbg 4 # midday
[ $hour -gt 15 ] && [[ $time_of_day == "DAY" ]] && setbg 5 # dusk
[[ $time_of_day == "NIGHT" ]]                   && setbg 7 # night


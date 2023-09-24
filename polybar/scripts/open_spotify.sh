#?/usr/bin/zsh
# playerctld shift
# find where is spotify playing and run

# get last used item from playerctl - it keeps it in order
ACTIVE=$(playerctl -l 1 | head -1)
if [ "spotify" = $ACTIVE ]; then
exec i3-msg "workspace $(i3get --instance spotify -r w)" 
else 'not active'
fi


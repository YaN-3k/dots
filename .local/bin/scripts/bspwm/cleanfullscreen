#!/bin/sh
# Clean fullscreen aims to provide a means to have a clean desktop when using
# transparency in bspwm, the issue I found was that when a window entered,
# fullscreen mode I was still able to see the windows behind it, I think this
# looks kind of gross so that's why this exists.

HideBar() {
  polybar-msg cmd hide
}

ShowBar() {
  polybar-msg cmd show
}

HideNodes() {
  for node in $1; do
    bspc node "$node" -g hidden=on
  done
}

HideTiled() {
  Nodes=$(bspc query -N -n .tiled -d "$1")
  HideNodes "$Nodes"
}

ShowNodes() {
  Nodes=$(bspc query -N -n .hidden -d "$1")

  for node in $Nodes; do
    bspc node "$node" -g hidden=off
  done
}

bspc subscribe node_state | while read -r Event Monitor Desktop Node State Active
do
  PrimaryMonitor=$(bspc query -M -m primary)
  # Hide bar and nodes when node becomes fullscreen, otherwise show
  if [ "$State" = "fullscreen" ] && [ "$Active" = "on" ]; then
    # Only consider nodes on primary monitor
    if [ "$PrimaryMonitor" = "$Monitor" ]; then
      HideBar
    fi
      HideTiled "$Desktop"
  else
    if [ "$PrimaryMonitor" = "$Monitor" ]; then
      ShowBar
    fi
    ShowNodes "$Desktop"
  fi
done &

bspc subscribe node_remove | while read Event Monitor Desktop Node
do
  PrimaryMonitor="$(bspc query -M -m primary)"

  # Show bar if no nodes are fullscreen on current desktop
  if [ "$Monitor" = "$PrimaryMonitor" ] && \
    [ -z "$(bspc query -N -n .fullscreen -d "$Desktop")" ]; then
    ShowBar
  fi
  ShowNodes "$Desktop"
done &

bspc subscribe node_transfer | while read -r Event SrcMonitor SrcDesktop SrcNode DestMonitor Dest Desktop DestNode
do
  # Show nodes on src desktop and hide nodes on dest desktop
  # If src node is in full screen mode
  if [ -n "$(bspc query -N -n "$SrcNode".fullscreen)" ]; then
    ShowNodes "$SrcDesktop"
    HideTiled "$DestDesktop"
    ShowBar
  fi

  # Hide any fullscreen nodes on destination desktop
  FullscreenDest=$(bspc query -N -n .fullscreen -d "$DestDesktop" \
    | sed "/$SrcNode/d")
  if [ -n "$FullscreenDest" ]; then
    HideNodes "$FullscreenDest"
  fi
done &

bspc subscribe desktop_focus | while read -r Event Monitor Desktop
do
  PrimaryMonitor="$(bspc query -M -m primary)"
  FullscreenNode="$(bspc query -N -n .fullscreen -d "$Desktop")"

  # Only consider nodes on primary monitor
  if [ "$PrimaryMonitor" = "$Monitor" ]; then
    # Hide bar if desktop contains fullscreen node
    if [ -n "$FullscreenNode" ]; then
      HideBar
    # Otherwise show the bar
    else
      ShowBar
    fi
  fi
done &

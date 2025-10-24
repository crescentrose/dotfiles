pragma Singleton

import Quickshell
import Quickshell.Services.Mpris

Singleton {
  readonly property var player: Mpris.players.values[0]

  readonly property var track: player.trackArtist + ": " + player.trackTitle
}

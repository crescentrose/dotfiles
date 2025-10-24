pragma Singleton

import Quickshell

Singleton {
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  property string time: Qt.formatDateTime(clock.date, "hh:mm")
}

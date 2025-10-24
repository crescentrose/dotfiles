pragma Singleton

import Quickshell

Singleton {
  SystemClock {
    id: clock
    precision: SystemClock.Hours
  }

  property string date: Qt.formatDateTime(clock.date, "yyyy-MM-dd")
}

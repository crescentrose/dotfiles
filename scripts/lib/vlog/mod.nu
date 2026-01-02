export def "info" [message: string] {
  log info $message
}

export def "done" [message: string] {
  log done $message
}

export def "debug" [message: string] {
  log debug $message
}

export def "warn" [message: string] {
  log warn $message
}

export def "error" [message: string] {
  log error $message
}

export def "fatal" [message: string, exitValue: int = 1] {
  log error $message
  log error "💔 Previous error was fatal; terminating!"
  exit $exitValue
}

export def "timed" [name: string, block: closure] {
  let start = date now

  try {
    do $block
  } catch { |err|
    log error $err.msg
    print -e $err.rendered
    log error $"🌧️ ($name) failed in (time-since $start)."
    return
  }

  log done $"✨ ($name) completed in (time-since $start)!"
}

def time-since [start: datetime] {
  let end = date now

  let diff = ($end - $start)
  if $diff >= 1min {
    $diff | format duration "min"
  } else {
    $diff | format duration "sec"
  }
}

def log [level: string, message: string] {
  let desiredLogLevel = ($env.VLOG_LEVEL? | default "info")
  if (log-level $level) < (log-level $desiredLogLevel) {
    return
  }

  let message = $"(ansi default_bold)($message)(ansi reset)"

  let parts = [
    (current-timestamp)
    # (current-script)
    (log-badge $level)
    ($message)
  ]

  print -e ($parts | str join ' ')
}

def current-timestamp [] {
  $"(ansi dark_gray)(date now | format date '%Y-%m-%d %H:%M:%S')(ansi reset)"
}

def current-script [] {
  $env.CURRENT_FILE
  $"(ansi light_gray)($env.CURRENT_FILE)(ansi reset)"
}

def log-badge [level: string] {
  match $level {
    "debug" => $"(ansi black_reverse) DEBG (ansi reset)",
    "done" => $"(ansi purple_reverse) DONE (ansi reset)",
    "info" => $"(ansi green_reverse) INFO (ansi reset)",
    "warn" => $"(ansi warn_reverse) WARN (ansi reset)",
    "error" => $"(ansi red_reverse) OOPS (ansi reset)",
    _ => $"(ansi black_reverse) UNKN (ansi reset)",
  }
}

def log-level [level: string] {
  match $level {
    "debug" => -1,
    "done" => 0,
    "info" => 0,
    "warn" => 1,
    "error" => 2,
    _ => 0
  }
}


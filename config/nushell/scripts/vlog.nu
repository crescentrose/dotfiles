export def "vlog info" [message: string] {
  log info $message
}

export def "vlog done" [message: string] {
  log done $message
}

export def "vlog debug" [message: string] {
  log debug $message
}

export def "vlog warn" [message: string] {
  log warn $message
}

export def "vlog error" [message: string] {
  log error $message
}

export def "vlog fatal" [message: string, exitValue: int = 1] {
  log error $message
  log error "💔 Previous error was fatal; terminating!"
  exit $exitValue
}

export def "vlog timed" [name: string, block: closure] {
  let start = date now

  try {
    do $block
  } catch { |err|
    log error $err.msg
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

  print -e $"(ansi dark_gray)(current-timestamp)(ansi reset) (ansi light_gray)(current-script)(ansi reset) (log-badge $level) (ansi default_bold)($message)(ansi reset)"
}

def current-script [] {
  $env.CURRENT_FILE
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

def current-timestamp [] {
  date now | format date "%Y-%m-%d %H:%M:%S"
}

{
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    settings = {

      # Inserts a blank line between shell prompts
      add_newline = true;

      character.success_symbol = ''[\$](bold green)'';
      character.error_symbol = ''[!](bold red)'';

      directory = {
        before_repo_root_style = ''bold cyan'';
        repo_root_style = ''bold cyan'';
        repo_root_format = ''[$before_root_path]($before_repo_root_style)[ $repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) '';
      };

      gcloud.disabled = true;

      git_branch = {
        symbol = "🌱 ";
        truncation_length = 10;
        truncation_symbol = "~";
        ignore_branches = [
          "master"
          "main"
        ];
      };

      git_status = {
        style = ''blue'';
        conflicted = ''[!$count ](bold red)'';
        untracked = ''[+$count ](red)'';
        stashed = ''[󰆓$count ](yellow)'';
        modified = ''[✴$count ](red)'';
        deleted = ''[-$count ](red)'';
        renamed = ''[→$count ](red)'';
        staged = ''[•$count ](bold yellow)'';
        ahead = ''⇡ $count '';
        diverged = ''⇡ $ahead_count ⇣ $behind_count '';
        behind = ''⇣ $count '';
        format = ''[$all_status$ahead_behind]($style)'';
      };

      git_metrics.disabled = true;

      env_var.SECRETS_LOADED = {
        format = "with 🔑 [$env_value secrets]($style) ";
        style = "bold dimmed";
      };
    };
  };
}

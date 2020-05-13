# bundler: reset lockfile after merge conflicts
git reset HEAD Gemfile.lock && bundle lock --update

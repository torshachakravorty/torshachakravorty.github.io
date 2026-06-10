#!/usr/bin/env bash
# Local preview for this site on modern Ruby (4.x).
#
# WHY THIS EXISTS:
#   The default Gemfile uses the old `github-pages` gem (Jekyll 3.9), which
#   CANNOT run on Ruby 3.2+ (it calls String#tainted?, a method Ruby removed).
#   Gemfile.dev uses native Jekyll 4, which works fine. This script just makes
#   sure local preview always uses Gemfile.dev so you never hit that wall.
#
#   NOTE: This is ONLY for local preview. The LIVE site is built by GitHub's
#   own servers (classic GitHub Pages builder) and ignores both Gemfiles.
#
# USAGE (from a terminal in this folder):
#   ./serve.sh
# Then open http://localhost:4000  (Ctrl+C to stop)

export BUNDLE_GEMFILE=Gemfile.dev
bundle install
bundle exec jekyll serve --livereload "$@"

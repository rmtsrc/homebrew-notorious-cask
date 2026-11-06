# frozen_string_literal: true

# Bumps the mpv-app cask, updating the checksum in every macOS-specific block.
#
# `brew bump-cask-pr` only refreshes the block matching the macOS version of the
# machine it runs on, which leaves the other OS-specific checksums stale. This
# script simulates each block's OS and architecture so a single run keeps the
# whole cask current.
#
# It edits the cask text directly instead of using Homebrew's AST helpers,
# because those require `rubocop-ast`, which is not available when running
# `brew ruby` on a stock CI runner.
#
# Usage: brew ruby .github/scripts/bump-mpv-app.rb <version> [cask-path]

require "cask"
require "cask/download"
require "simulate_system"

usage = "Usage: brew ruby .github/scripts/bump-mpv-app.rb <version> [cask-path]"
version = ARGV[0]
raise usage if version.blank?

path = Pathname(ARGV[1] || File.expand_path("../../Casks/m/mpv-app.rb", __dir__)).expand_path
raise "Cask not found: #{path}" unless path.file?

cask = Cask::CaskLoader.from_path(path)
if cask.version.to_s == version
  puts "#{cask.token} is already at #{version}"
  exit 0
end

contents = path.read
root_version = /^(\s*version\s+)"[^"]+"/
raise "Could not find root version stanza in #{path}" unless contents.match?(root_version)

contents = contents.sub(root_version, "\\1\"#{version}\"")

os_blocks = contents.scan(/^\s*on_([a-z_]+)(?:\s|$)/).flatten.uniq.map(&:to_sym)
raise "No OS-specific blocks found in #{path}" if os_blocks.empty?

# Replaces the checksum for `arch` inside the matching `on_<os>` block. Blocks
# with multiple architectures use `sha256 arm: "...", intel: "..."`; blocks
# limited to one architecture use a bare `sha256 "..."`.
replace_checksum = lambda do |text, os, arch, sha|
  lines = text.lines
  start = lines.index { |line| line.match?(/^\s*on_#{os}(?:\s|$)/) }
  raise "Could not find on_#{os} block" if start.nil?

  indent = lines[start][/\A\s*/]
  finish = (start + 1...lines.length).find { |i| lines[i].match?(/^#{indent}end\s*$/) }
  raise "Could not find end of on_#{os} block" if finish.nil?

  block = lines[start..finish].join
  keyed = /(\b#{arch}:\s*)"[0-9a-f]{64}"/
  bare = /^(\s*sha256\s+)"[0-9a-f]{64}"/
  updated = if block.match?(keyed)
    block.sub(keyed, "\\1\"#{sha}\"")
  elsif block.match?(bare)
    block.sub(bare, "\\1\"#{sha}\"")
  end
  raise "Could not update #{os}/#{arch} checksum" if updated.nil? || updated == block

  lines[start..finish] = [updated]
  lines.join
end

os_blocks.each do |os|
  %i[arm intel].each do |arch|
    simulated_cask = Homebrew::SimulateSystem.with(os: os, arch: arch) do
      Cask::CaskLoader.from_content(contents)
    end
    next if simulated_cask.url.blank?

    required_arches = simulated_cask.depends_on.arch
    next if required_arches.present? && required_arches.none? { |a| a[:type] == arch }

    old_sha = simulated_cask.sha256
    raise "No checksum to update for #{os}/#{arch}" if old_sha.nil? || old_sha == :no_check

    downloaded = Cask::Download.new(simulated_cask).fetch(verify_download_integrity: false)
    new_sha = downloaded.sha256
    next if old_sha.to_s == new_sha

    contents = replace_checksum.call(contents, os, arch, new_sha)
    puts "Updated #{os}/#{arch} to #{new_sha}"
  end
end

path.atomic_write(contents)
puts "Updated #{path} to #{version}"

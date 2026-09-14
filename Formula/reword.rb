class Reword < Formula
  desc "A plain-text flashcard CLI with FSRS spaced repetition"
  homepage "https://github.com/joshuamotoaki/reword"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.4/reword-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c339748e07c3930aa7bfdc72d84ec07db7283c018c0f8f9a92d25587858c05c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.4/reword-cli-x86_64-apple-darwin.tar.xz"
      sha256 "6925188a77b796bd888e0886f99964dab2aaa9352ed21724b47c890b18f23f80"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.4/reword-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ca6d63b0d54de4390b02a466e4d92d2a1f9de4e40bbc82aba6850742c4e45f69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.4/reword-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8343333045bdf0da02741712af95d03ccda88b21e2532d86f9577f9e97eb0ace"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "reword"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "reword"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "reword"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "reword"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

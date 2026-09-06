class Reword < Formula
  desc "A plain-text flashcard CLI with FSRS spaced repetition"
  homepage "https://github.com/joshuamotoaki/reword"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.1/reword-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b5aa49dadd98f975af4bab1f86aad3209c4e2e53c73ab75140077c8d31ea6baf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.1/reword-cli-x86_64-apple-darwin.tar.xz"
      sha256 "2db81d5ccae72ba0a9309191fc769b452d6ddbbafc4aaadf8b3dd6f5669de695"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.1/reword-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8f223a6f1df166a5fa02ee65b63078f344f02e6b472e7ddde6ff276b1e8f8bf8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.1/reword-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3596ac5ad5ba640c4b3e490ef350efc50c11da76ae81cb5071b112dbaf2fb52d"
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

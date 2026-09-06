class Reword < Formula
  desc "A plain-text flashcard CLI with FSRS spaced repetition"
  homepage "https://github.com/joshuamotoaki/reword"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.3/reword-cli-aarch64-apple-darwin.tar.xz"
      sha256 "760fca6d26c2cd67e5e7c03607788a5df5aa711f6ed46852b3f5d2803a28df6c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.3/reword-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7be8d02d3be77bc6b8815e4cfaedbd9b7adaa1749a2aa63f4a581449cd7bd17d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.3/reword-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "744a2c887af34f567a813af775a006ba1848d5be58077ecb7338e4e554760886"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.3/reword-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d2ca7bfa5bc724c84335f536611f06f98020bffed5bbd22131b9c25d85363bf1"
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

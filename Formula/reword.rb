class Reword < Formula
  desc "A plain-text flashcard CLI with FSRS spaced repetition"
  homepage "https://github.com/joshuamotoaki/reword"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.0/reword-cli-aarch64-apple-darwin.tar.xz"
      sha256 "12790a9f84fc5f0e5cae5908db668c6da6b0c6edd4c312397f24af65e93d7bfa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.0/reword-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a28b818f7bf8e06e12a1f16c24bc87fb39b048297ae46484e08892fcffeeb060"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.0/reword-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b7290a1d130be26c3f5f5649d85f10d15a324119f5bb8cfde553d412a163f2ec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.0/reword-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c014de6e2d7c2d0d415cb3c25fda763210be528ed42c4144d4b3434addea5493"
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

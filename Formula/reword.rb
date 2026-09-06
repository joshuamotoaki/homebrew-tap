class Reword < Formula
  desc "A plain-text flashcard CLI with FSRS spaced repetition"
  homepage "https://github.com/joshuamotoaki/reword"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.2/reword-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e7636a1cea8c7ee06b6069a7374b48973a6b6f5c84d2f88dd58e7e5e43ca40bd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.2/reword-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f6f0493442f69d540a36a32a229c62b0081cafb729da61d8a10e98faab66a0ca"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.2/reword-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e23b32cfcc1345e73468cbc29ee67b65d64f10d095f0e255df049e451bc717a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshuamotoaki/reword/releases/download/v0.1.2/reword-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6cf431409348b6ee6d7c6f98ab8b21784d33346d7bf80051ef1b27fc3bf8f6a7"
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

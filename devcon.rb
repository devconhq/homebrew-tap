class Devcon < Formula
  desc "DevCon One - Your Mission-Critical Dev Environment Manager"
  homepage "https://github.com/devconhq/devcon"
  version "0.2.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.6/devcon-macos-arm64"
      sha256 "01b59c608ef4cb3a1b1453610c13c63d3d0153631058e114062d52a8608d1b04"
    end

    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.6/devcon-macos-universal"
      sha256 "c0666763fa5b08188350bb9b21eaefcf892ac5160a95e59dd1968239f7552310"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.6/devcon-ubuntu-x86_64"
      sha256 "bca1b852e6a866f328038fa265995d2a75ae7ec7e69d625b31d277bd6c44545b"
    end

    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.6/devcon-ubuntu-arm64"
      sha256 "415cce201a62c5b2ebe5020a67c85245a3a47603adddf8a62dc8e9fae20076c2"
    end
  end

  def install
    bin.install "devcon-macos-arm64" => "devcon" if OS.mac? && Hardware::CPU.arm?
    bin.install "devcon-macos-universal" => "devcon" if OS.mac? && Hardware::CPU.intel?
    bin.install "devcon-ubuntu-x86_64" => "devcon" if OS.linux? && Hardware::CPU.intel?
    bin.install "devcon-ubuntu-arm64" => "devcon" if OS.linux? && Hardware::CPU.arm?
  end

  def caveats
    <<~EOS
      DevCon requires a container runtime to function properly.
      
      Please ensure you have one of the following installed:
        • Docker Desktop (https://www.docker.com/products/docker-desktop/)
        • Apple's Container Runtime (macOS only, included with macOS 15+)
      
      To verify your installation, run:
        devcon --version
    EOS
  end

  test do
    assert_match "devcon", shell_output("#{bin}/devcon --version")
  end
end

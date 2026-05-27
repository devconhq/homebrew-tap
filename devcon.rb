class Devcon < Formula
  desc "DevCon One - Your Mission-Critical Dev Environment Manager"
  homepage "https://github.com/devconhq/devcon"
  version "0.2.14"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.14/devcon-macos-arm64"
      sha256 "46c47f57de6a3e8d0f6bb7a35244a4e01ba128d489bbc1d4ebdaf7c96ba3e5eb"
    end

    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.14/devcon-macos-universal"
      sha256 "62dcc190bd97973f0634e15645e593e451e9418a8ebdd01d1e1ad72d832d18d0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.14/devcon-linux-x86_64"
      sha256 "ad92e4a1cacabf7634045268b806c37cfa85bae139bbdd97007a8d4c28ae66ab"
    end

    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.14/devcon-linux-arm64"
      sha256 "50e1e91295bb61f8c8ccd58854a1083ab160d36744750703a58cbd1d7d4d2179"
    end
  end

  def install
    bin.install "devcon-macos-arm64" => "devcon" if OS.mac? && Hardware::CPU.arm?
    bin.install "devcon-macos-universal" => "devcon" if OS.mac? && Hardware::CPU.intel?
    bin.install "devcon-linux-x86_64" => "devcon" if OS.linux? && Hardware::CPU.intel?
    bin.install "devcon-linux-arm64" => "devcon" if OS.linux? && Hardware::CPU.arm?
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

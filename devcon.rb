class Devcon < Formula
  desc "DevCon One - Your Mission-Critical Dev Environment Manager"
  homepage "https://github.com/devconhq/devcon"
  version "0.2.12"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.12/devcon-macos-arm64"
      sha256 "54c0bd0fb11067c89eb30835b6a690a2f74bcaecc45caaeb25dcffe54b8a7535"
    end

    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.12/devcon-macos-universal"
      sha256 "b21d8bf47145f36a255f7f75eeb946afbd0d3f3fbfab0ecadd5fc0fe729ef52a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.12/devcon-linux-x86_64"
      sha256 "2b066838d624c89e5f56b873774675f961425388c128a37494a448444fef4267"
    end

    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.12/devcon-linux-arm64"
      sha256 "8ea9dbceb1ca1153edbf12a3a01b7394da4c96934ef913fe61bbcdb0d9d4efa4"
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

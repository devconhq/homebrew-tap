class Devcon < Formula
  desc "DevCon One - Your Mission-Critical Dev Environment Manager"
  homepage "https://github.com/devconhq/devcon"
  version "0.2.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.10/devcon-macos-arm64"
      sha256 "f1ef311d28e31a73a4b20e0233f4cd79e2984ea2c04fa4084d5d5d37a34db481"
    end

    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.10/devcon-macos-universal"
      sha256 "5d23b21f221224279bdfcc549014813b07c67a5aa60d6a832f8279e69526e76a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.10/devcon-linux-x86_64"
      sha256 "a5ccda51f17425661c2adf8689df80b0f1e10e379a4379658cb65699931053d2"
    end

    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.10/devcon-linux-arm64"
      sha256 "92163efa230156145a471c980f2533ed106adb22036f3afe02713c5597f2e413"
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

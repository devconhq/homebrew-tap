class Devcon < Formula
  desc "DevCon One - Your Mission-Critical Dev Environment Manager"
  homepage "https://github.com/devconhq/devcon"
  version "0.2.11"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.11/devcon-macos-arm64"
      sha256 "bf731b60692b1f06eb803698cbeea21fa171bb0a32d97db52be15da6603eb76e"
    end

    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.11/devcon-macos-universal"
      sha256 "33bd20aa3edd996fe104ed2e99494b74f0688ce4cec28f9e43279f79df2092af"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.11/devcon-linux-x86_64"
      sha256 "2e3b49c48ccb6ae7c5a111d47b226e9ec67fbbc936113275e1c1137377420b33"
    end

    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.11/devcon-linux-arm64"
      sha256 "f144187f6e050fd59ba4d9da2e2e843c933e76a534adc0768b8f655750af7d9b"
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

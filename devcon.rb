class Devcon < Formula
  desc "DevCon One - Your Mission-Critical Dev Environment Manager"
  homepage "https://github.com/devconhq/devcon"
  version "0.2.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.9/devcon-macos-arm64"
      sha256 "9314fe7cc40461bde5d5bf02349d1493c177334d0329bf9baf4bff1b9e00f63d"
    end

    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.9/devcon-macos-universal"
      sha256 "d3ff9def2b3399caa259b419f2bddc832f062d25ed6bfb9568a7c93b7ec1fda5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.9/devcon-linux-x86_64"
      sha256 "3d70618ffa57c18c7ea0b5c72e88708e410f27bcced062a7806111a9307a90f8"
    end

    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.9/devcon-linux-arm64"
      sha256 "fb634aade9a4a448b73ed5914589f6437d506fb481a80fd67c3974b2b626ac29"
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

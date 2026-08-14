class Devcon < Formula
  desc "DevCon One - Your Mission-Critical Dev Environment Manager"
  homepage "https://github.com/devconhq/devcon"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.3.1/devcon-macos-arm64"
      sha256 "cde6e93d3f9a05784d5c58590978438f7de3f2ed9e234a0e6a3c8eef1996b96a"
    end

    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.3.1/devcon-macos-universal"
      sha256 "6d38c02d13c9e5ee5fd1f7b0487c56178400f0d2cd3a163f8d8897f8b51b8b4d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.3.1/devcon-linux-x86_64"
      sha256 "a9c6a2e401b8883a2d233be4019914775bb450f50a31c3a023c87a93191401a1"
    end

    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.3.1/devcon-linux-arm64"
      sha256 "3e948098ea7d57618553c705901003ed80f6bca0fda517ff777fc3f557edae82"
    end
  end

  def install
    bin.install "devcon-macos-arm64" => "devcon" if OS.mac? && Hardware::CPU.arm?
    bin.install "devcon-macos-universal" => "devcon" if OS.mac? && Hardware::CPU.intel?
    bin.install "devcon-linux-x86_64" => "devcon" if OS.linux? && Hardware::CPU.intel?
    bin.install "devcon-linux-arm64" => "devcon" if OS.linux? && Hardware::CPU.arm?
  end

  service do
    run [opt_bin/"devcon", "serve"]
    keep_alive true
    working_dir var
    log_path var/"log/devcon-serve.log"
    error_log_path var/"log/devcon-serve.log"
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

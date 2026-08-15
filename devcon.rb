class Devcon < Formula
  desc "DevCon One - Your Mission-Critical Dev Environment Manager"
  homepage "https://github.com/devconhq/devcon"
  version "V0.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/vV0.3.2/devcon-macos-arm64"
      sha256 "2ad22dccdd58a026a4114043000f3f792f5d4230194deb70c0e0f1cbfb7f1ade"
    end

    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/vV0.3.2/devcon-macos-universal"
      sha256 "2bd036dd60ee359d0c4bca7f921fce05c45376ce265347f0d7f246e458a2d09a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/vV0.3.2/devcon-linux-x86_64"
      sha256 "40cd1d86372965b8805477880f020f4ca665ae1dfbed2a73d3055f3e031becd9"
    end

    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/vV0.3.2/devcon-linux-arm64"
      sha256 "cc620d4fe5144496c290ec60737a2f9c8f85ecfb3a758a9e6e868bb86b9b9f52"
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

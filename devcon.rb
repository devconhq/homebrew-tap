class Devcon < Formula
  desc "DevCon One - Your Mission-Critical Dev Environment Manager"
  homepage "https://github.com/devconhq/devcon"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.3.0/devcon-macos-arm64"
      sha256 "eab5d73c927b23d281df85fb50882b26c4b5fb692d7475644ba4fff9927ee867"
    end

    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.3.0/devcon-macos-universal"
      sha256 "10f904282a176a657752f63bad91e629ef3c9a86e833c11a9e93c54eb3bdb715"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.3.0/devcon-linux-x86_64"
      sha256 "7828ee51ccf0c1dc908e2e4429ef44e42e75eebd0732eec3cb1c10255eeff9dd"
    end

    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.3.0/devcon-linux-arm64"
      sha256 "05694f162ac2f7753739557fcf75a4054109acf6859a3977bf84b9fc03f64f63"
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

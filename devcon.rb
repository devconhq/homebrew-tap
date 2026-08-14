class Devcon < Formula
  desc "DevCon One - Your Mission-Critical Dev Environment Manager"
  homepage "https://github.com/devconhq/devcon"
  version "0.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.3.2/devcon-macos-arm64"
      sha256 "9849ea12ac57d0f68539fd42eb83a5d7e1aab45ab77e49fc8578520e227fb6ec"
    end

    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.3.2/devcon-macos-universal"
      sha256 "6cacde1b588e0f491b1684d6c715def8391c77d898d3f3c41360d01ce310bdcf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.3.2/devcon-linux-x86_64"
      sha256 "de9463406ff103fd2855359e5e4e33a8de05cbd504944657e5c0d03f6152f63c"
    end

    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.3.2/devcon-linux-arm64"
      sha256 "43de39085b340f9695521d1751e66fa54bd70d77cdaf7db68ad8183bd5b55103"
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

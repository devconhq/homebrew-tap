class Devcon < Formula
  desc "DevCon One - Your Mission-Critical Dev Environment Manager"
  homepage "https://github.com/devconhq/devcon"
  version "0.2.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.7/devcon-macos-arm64"
      sha256 "66f64236f1db69a6d8ef4f3199ec36157fbb8397cc8e0c62f4ea293af7b5c317"
    end

    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.7/devcon-macos-universal"
      sha256 "2ce22dff6deecbdfb45b5ce44e76e2f999b69ab88abcef3c38466c979eae84d0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.7/devcon-linux-x86_64"
      sha256 "3e8e2e9fecea6c90243ee98ef73dd848587a77a8caa861db32a942b44c3649a6"
    end

    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.7/devcon-linux-arm64"
      sha256 "a797c7a475b2e1bcaee7b0959a2a729733f02589e1f86fbbaf39fb01640ed4f2"
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

class Devcon < Formula
  desc "DevCon One - Your Mission-Critical Dev Environment Manager"
  homepage "https://github.com/devconhq/devcon"
  version "0.2.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.8/devcon-macos-arm64"
      sha256 "cec92256e17f6495de5022eb4d9775d5f4c114c79e483e46e8f31637dd8bf444"
    end

    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.8/devcon-macos-universal"
      sha256 "1dc6c98eefc2bb21b86bed92c83d0604b48d9e04ea27d6763a25c5badf99931a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.8/devcon-linux-x86_64"
      sha256 "08c62626609dd8d752b74fba5e1fd243e40f1cc71061f5e75f2cf307b11964ef"
    end

    on_arm do
      url "https://github.com/devconhq/devcon/releases/download/v0.2.8/devcon-linux-arm64"
      sha256 "89f2dc794096131a363761bd9d3b45b8bdf03c5b96aa9bc046773b4498bf5dc4"
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

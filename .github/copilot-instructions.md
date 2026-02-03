# Copilot Instructions - DevConHQ Homebrew Tap

## Repository Purpose

This is a Homebrew tap for DevConHQ. Taps are third-party repositories that extend Homebrew's package manager with additional formulae.

## Homebrew Formula Conventions

### Formula Structure

- Formula files use Ruby and inherit from `Formula` class
- Filename must match the formula name (e.g., `devcon.rb` for `devcon` formula)
- Place all formulae in the repository root (not in subdirectories)

### Required Formula Elements

```ruby
class Devcon < Formula
  desc "Short description of the tool"
  homepage "https://project-homepage.com"
  url "https://url-to-source-archive.tar.gz"  # or binary
  sha256 "checksum-of-archive"
  version "1.0.0"
  
  def install
    # Installation logic here
  end
  
  test do
    # Test logic to verify installation
  end
end
```

### Bottles (Pre-compiled Binaries)

For tools with separate binaries per platform, use platform-specific URLs instead of bottles:

```ruby
class Devcon < Formula
  desc "Short description"
  homepage "https://project-homepage.com"
  version "1.0.0"
  
  on_macos do
    on_arm do
      url "https://releases.example.com/devcon-v1.0.0-darwin-arm64.tar.gz"
      sha256 "arm64-checksum"
    end
    
    on_intel do
      url "https://releases.example.com/devcon-v1.0.0-darwin-amd64.tar.gz"
      sha256 "intel-checksum"
    end
  end
  
  on_linux do
    on_arm do
      url "https://releases.example.com/devcon-v1.0.0-linux-arm64.tar.gz"
      sha256 "linux-arm64-checksum"
    end
    
    on_intel do
      url "https://releases.example.com/devcon-v1.0.0-linux-x86_64.tar.gz"
      sha256 "linux-intel-checksum"
    end
  end
  
  def install
    bin.install "devcon"
  end
  
  test do
    system "#{bin}/devcon", "--version"
  end
end
```

**Key points:**

- Use `on_macos`/`on_linux` for OS-specific logic
- Use `on_arm`/`on_intel` for architecture-specific logic
- Each platform block needs its own `url` and `sha256`
- Calculate checksums: `shasum -a 256 <file>` for each binary
- All platforms share the same `install` and `test` blocks unless you need platform-specific logic

### Installation Methods

- **Binaries**: Use `bin.install "binary-name"` for pre-built executables
- **Go projects**: Use `system "go", "build"` followed by `bin.install`
- **Other languages**: Follow Homebrew's language-specific conventions

### Version Updates

When updating formula versions:

1. Update `version` field
2. Update all platform-specific `url` fields to point to new release
3. Download each binary and calculate SHA256: `shasum -a 256 <file>`
4. Update each platform's `sha256` field with new checksum
5. Test installation on your platform: `brew install ./devcon.rb`

**For multi-platform formulas, update all three:**

- macOS ARM64 (`darwin-arm64`)
- macOS AMD64 (`darwin-amd64`)  
- Linux x86_64 (`linux-x86_64`)
- Linux ARM64 (`linux-arm64`)

### Testing

- Run `brew audit --strict --online devcon` before committing
- Test installation locally: `brew install devcon` (after tapping)
- Verify with `brew test devcon`

## Tap Usage

Users install from this tap with:

```bash
brew tap devconhq/tap
brew install devcon
```

Or in one command:

```bash
brew install devconhq/tap/devcon
```

## Common Tasks

### Update formula for new release

```bash
# Edit devcon.rb with new version, URL, and SHA256
brew audit --strict --online devcon
brew install --build-from-source ./devcon.rb
brew test devcon
git commit -am "Update devcon to vX.Y.Z"
```

### Test formula locally

```bash
brew install --build-from-source ./devcon.rb
brew test devcon
brew uninstall devcon
```

### Validate formula

```bash
brew audit --strict --online devcon
brew style devcon
```

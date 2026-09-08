class Mave < Formula
  desc "Manage Mave videos, collections, and uploads from the command line"
  homepage "https://github.com/maveio/mave-cli"
  version "0.1.0"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/maveio/mave-cli/releases/download/v0.1.0/mave-0.1.0-macos_arm64.tar.gz"
      sha256 "6733eb1b554d588cecde3084e1d4603aa2d2502e595bf3fd91ca1fb2a3ddf4d9"
    end
    on_intel do
      url "https://github.com/maveio/mave-cli/releases/download/v0.1.0/mave-0.1.0-macos_x86_64.tar.gz"
      sha256 "df3db728544ace4e904de56d0c4a8d123bb41b706855161305bbb0ea7d14057f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maveio/mave-cli/releases/download/v0.1.0/mave-0.1.0-linux_arm64.tar.gz"
      sha256 "871f088ad2d543edc3689c9ec662cd9a61ef4cf25f6a2fa7a94113a452dd4150"
    end
    on_intel do
      url "https://github.com/maveio/mave-cli/releases/download/v0.1.0/mave-0.1.0-linux_x86_64.tar.gz"
      sha256 "d20b8a296e1cfa5f9ee3a6a3c3c9710abe5589b8c8825a3a4cf056f6e7994308"
    end
  end

  def install
    bin.install "mave"
    pkgshare.install "LICENSE", "licenses", "THIRD_PARTY_NOTICES.md", "build-info.json"
  end

  test do
    ENV["MAVE_CONFIG_HOME"] = testpath/"config"
    ENV.delete("MAVE_TOKEN")
    assert_equal version.to_s, shell_output("#{bin}/mave --version").strip
    assert_match "mave videos list", shell_output("#{bin}/mave --help")
    result = JSON.parse(shell_output("#{bin}/mave upload-token test-subject --token test-secret"))
    assert_equal "test-subject", result.fetch("subject")
    assert_match "ongeldige optie", shell_output("#{bin}/mave --invalid-option 2>&1", 1)
  end
end

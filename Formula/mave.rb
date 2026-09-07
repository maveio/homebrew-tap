class Mave < Formula
  desc "Manage Mave videos, collections, and uploads from the command line"
  homepage "https://github.com/maveio/mave-cli"
  version "0.5.0"
  license "AGPL-3.0-only"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/maveio/mave-cli/releases/download/v0.5.0/mave-0.5.0-macos_arm64.tar.gz"
      sha256 "3202c65a4df222a154ef3a75cfaf415c26ac03225aaa81f6a17e9425d13c5005"
    end
    on_intel do
      url "https://github.com/maveio/mave-cli/releases/download/v0.5.0/mave-0.5.0-macos_x86_64.tar.gz"
      sha256 "2235d4ec985ae7458a72cfe29a209e4d18017749fbc85314d4d25ff931c87acf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maveio/mave-cli/releases/download/v0.5.0/mave-0.5.0-linux_arm64.tar.gz"
      sha256 "e8884b82695a0b4c5aa8de5823c4129778295827c5a1e485fb4c7dbf7bc3791f"
    end
    on_intel do
      url "https://github.com/maveio/mave-cli/releases/download/v0.5.0/mave-0.5.0-linux_x86_64.tar.gz"
      sha256 "278e29ec469a96470f2d0c1d59575ac0f97a3ba027f1b26dedc98d0593ac69a9"
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

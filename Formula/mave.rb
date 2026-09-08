class Mave < Formula
  desc "Manage Mave videos, collections, and uploads from the command line"
  homepage "https://github.com/maveio/mave-cli"
  version "0.1.0"
  license "AGPL-3.0-only"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/maveio/mave-cli/releases/download/v0.1.0/mave-0.1.0-macos_arm64.tar.gz"
      sha256 "47972e2b584450c3cdc64d5c93b0a8cf75b73e3f920594d5aaf629bbda5d7ffc"
    end
    on_intel do
      url "https://github.com/maveio/mave-cli/releases/download/v0.1.0/mave-0.1.0-macos_x86_64.tar.gz"
      sha256 "a00983ac799b17c636f46ddd01eb91459e7d441c1248be463e6415734bcbea7a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maveio/mave-cli/releases/download/v0.1.0/mave-0.1.0-linux_arm64.tar.gz"
      sha256 "b8e547746d0519dc439823e4a130eff59bbf00d64247980084ae5d06cbda4ba2"
    end
    on_intel do
      url "https://github.com/maveio/mave-cli/releases/download/v0.1.0/mave-0.1.0-linux_x86_64.tar.gz"
      sha256 "dfd3c38a89efa4e50ef2bdf08b1c2519840a64adf0ffe7486482a7ead43802b6"
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

class Mave < Formula
  desc "Manage Mave videos, collections, and uploads from the command line"
  homepage "https://github.com/maveio/mave-cli"
  version "0.2.0"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/maveio/mave-cli/releases/download/v0.2.0/mave-0.2.0-macos_arm64.tar.gz"
      sha256 "49b8c1543d721067bd06bd0ce095228939128cb91fe469762166ab6b0158775e"
    end
    on_intel do
      url "https://github.com/maveio/mave-cli/releases/download/v0.2.0/mave-0.2.0-macos_x86_64.tar.gz"
      sha256 "aa4284443c11e65f3c9c03d7961aceca935cc1769614ed2a5e3877e0991d0362"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maveio/mave-cli/releases/download/v0.2.0/mave-0.2.0-linux_arm64.tar.gz"
      sha256 "e5f03cdf39cebbafa167fe403e16d03a5b8add3bf22043f1c3f9e1be51485ac6"
    end
    on_intel do
      url "https://github.com/maveio/mave-cli/releases/download/v0.2.0/mave-0.2.0-linux_x86_64.tar.gz"
      sha256 "752cf6981b223dd2f77d26ec940e32eb762b876e9ed678c460f21ace8106bdfe"
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
    assert_match "invalid option", shell_output("#{bin}/mave --invalid-option 2>&1", 1)
  end
end

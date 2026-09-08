class Mave < Formula
  desc "Manage Mave videos, collections, and uploads from the command line"
  homepage "https://github.com/maveio/mave-cli"
  version "0.1.0"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/maveio/mave-cli/releases/download/v0.1.0/mave-0.1.0-macos_arm64.tar.gz"
      sha256 "c16a0e3376f328f0834e6cd4078a52bce7670b85c2a13da5c56ed31c5f6853a3"
    end
    on_intel do
      url "https://github.com/maveio/mave-cli/releases/download/v0.1.0/mave-0.1.0-macos_x86_64.tar.gz"
      sha256 "3d6c8a1ca0cee7fe54aa98079f6ac4dfc2be7c876d5295adb6f4dee2c010417f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maveio/mave-cli/releases/download/v0.1.0/mave-0.1.0-linux_arm64.tar.gz"
      sha256 "3267edeb2a8bbd07b4799d9b1c65e28da95f34614d2d0e23367fe6ff212c409a"
    end
    on_intel do
      url "https://github.com/maveio/mave-cli/releases/download/v0.1.0/mave-0.1.0-linux_x86_64.tar.gz"
      sha256 "67b18a5f53f22670e68ea9da6ff2d795d64201579227e717a563731da6193c2c"
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

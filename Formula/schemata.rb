class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v1.4.0/schemata-1.4.0-macos-arm64.tar.gz"
      sha256 "5ccdc048c6e7d78bb8c1e64ad51c193119a3580ce0f93e14d6bd4fc2bc866b46"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v1.4.0/schemata-1.4.0-macos-x64.tar.gz"
      sha256 "f63826060e7cc9d4c0e68f22a61f63fbbf0d9b91ddaae312fc448b6075660f59"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v1.4.0/schemata-1.4.0-linux-x64.tar.gz"
      sha256 "91f6a5e51851692d0bbeacb79b31a7fb5bb2d830b658ba05f4e3a5e52106436a"
    end
  end

  def install
    bin.install "schemata"
  end

  test do
    (testpath/"t.schemata").write <<~EOS
      namespace t

      enum Kind { #1 personal, #2 work }

      record Contact { @sql(key) #1 id: int64  #2 kind: Kind = personal }
    EOS
    assert_match "schemata #{version}", shell_output("#{bin}/schemata --version")
    # A default is lossy for Protobuf, so `check` reports warnings and exits 2.
    shell_output("#{bin}/schemata check #{testpath}/t.schemata", 2)
  end
end

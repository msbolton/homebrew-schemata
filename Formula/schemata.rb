class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v1.0.0/schemata-1.0.0-macos-arm64.tar.gz"
      sha256 "333067851ea84dee91b4df1716da8ec64f0bd46d97eb40f7ebbee5485fc79c1d"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v1.0.0/schemata-1.0.0-macos-x64.tar.gz"
      sha256 "b782ba4465e2b52fe194381e53b905510a26015172228c168b800eb8b3b0471f"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v1.0.0/schemata-1.0.0-linux-x64.tar.gz"
      sha256 "d3a3078163b67909b8cc3664f1644653be78922a11a332a39d6cbb3ff812c20c"
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

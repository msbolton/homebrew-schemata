class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v2.1.0/schemata-2.1.0-macos-arm64.tar.gz"
      sha256 "3d24da1666e54a4819724de2f243db4d9fe6f93e1eae80027f0cabdd89fda687"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.1.0/schemata-2.1.0-macos-x64.tar.gz"
      sha256 "cf528c30d1dd489aacaab0810f9f52b10e01ec3a0fdf648024f1110a3d1e0707"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.1.0/schemata-2.1.0-linux-x64.tar.gz"
      sha256 "bfc3ae5f2c2b3e190f2429469698b49993328819a9d34d4d9bfcfd352b9bfb77"
    end
  end

  def install
    bin.install "schemata"
  end

  test do
    (testpath/"t.schemata").write <<~EOS
      schema t

      enum Kind { personal work }

      model Contact { id int64 { id }  kind Kind = personal }
    EOS
    assert_match "schemata #{version}", shell_output("#{bin}/schemata --version")
    # A default is lossy for Protobuf, so `check` reports warnings and exits 2.
    shell_output("#{bin}/schemata check #{testpath}/t.schemata", 2)
  end
end

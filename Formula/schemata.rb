class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v2.7.0/schemata-2.7.0-macos-arm64.tar.gz"
      sha256 "e2c8b2e5068d891d37dd44852288dd93433ff5950d524eefd6fe5790d4532dfb"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.7.0/schemata-2.7.0-macos-x64.tar.gz"
      sha256 "79808311ee31ce80c281abfc7a76b6df9f6401522fb16492288930ef5ef43168"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.7.0/schemata-2.7.0-linux-x64.tar.gz"
      sha256 "da645fafc88fa2f7492aa8ed9f811982ee918df17c698dd07c1b888aca6701b8"
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

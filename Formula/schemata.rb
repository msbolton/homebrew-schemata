class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v0.7.0/schemata-0.7.0-macos-arm64.tar.gz"
      sha256 "468e6af4f5688a687ed61d95f0301d7082362b829d3edf72c0f4dc6941389044"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v0.7.0/schemata-0.7.0-macos-x64.tar.gz"
      sha256 "70757969c13deb3a8c4af018061267bd6da8b5068fbae84c414cdc08b18d11d0"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v0.7.0/schemata-0.7.0-linux-x64.tar.gz"
      sha256 "55a4417072a1728780772b3b3203e76910d8b8b4174c326fd80daff2c36ae062"
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

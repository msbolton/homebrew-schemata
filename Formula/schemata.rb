class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v2.0.0/schemata-2.0.0-macos-arm64.tar.gz"
      sha256 "9dd5ed93858979a26d018c0e38a1bd3a5ba3bff222160a9811f69dac5bfa319a"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.0.0/schemata-2.0.0-macos-x64.tar.gz"
      sha256 "7b4270ac1d21a7a173c058fa7adf16959374f551a24855222f420d2ddfaa615c"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.0.0/schemata-2.0.0-linux-x64.tar.gz"
      sha256 "853953e6db98680e4b8054c5d250d311ea32f8a5cb381671a5caa1fc80082ed5"
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

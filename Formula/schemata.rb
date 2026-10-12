class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v2.6.0/schemata-2.6.0-macos-arm64.tar.gz"
      sha256 "51e35c0f168ddf2e79e8f3829bf381ac80c5574dd30861a13c87f21cbea5d516"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.6.0/schemata-2.6.0-macos-x64.tar.gz"
      sha256 "4576194e67ef64e1dac84e33c73395d99ffb95cdfb309d7cb5ca91a4a0a283a5"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.6.0/schemata-2.6.0-linux-x64.tar.gz"
      sha256 "6fb5100a0c5b2fa753cabfd5502128ad698292fc16c19dacf99d0d11e14fa27e"
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

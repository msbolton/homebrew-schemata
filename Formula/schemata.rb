class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v1.2.0/schemata-1.2.0-macos-arm64.tar.gz"
      sha256 "d1b0cdbd3752e04fa725888d5d46cbb2509d15aa1e790811fc7967a64208f880"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v1.2.0/schemata-1.2.0-macos-x64.tar.gz"
      sha256 "edd7e668ceecfabfda07539b8b9a16fa9ed48bd8968f9324ad160474d05411ff"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v1.2.0/schemata-1.2.0-linux-x64.tar.gz"
      sha256 "d8df71ae59c67ed4d94a2aefd7429422e20b3bc210a58e69f59c350b8388fe73"
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

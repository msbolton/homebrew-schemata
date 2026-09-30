class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v0.4.0/schemata-0.4.0-macos-arm64.tar.gz"
      sha256 "be3ad20e45beac83fdcc933919e3bc8d6fb142d9d2c60755587f02a89aad0d01"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v0.4.0/schemata-0.4.0-macos-x64.tar.gz"
      sha256 "c21406de5d0041658a5d0b50b6a7562aefee6dfce8ff626f33d4d8236ed23d05"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v0.4.0/schemata-0.4.0-linux-x64.tar.gz"
      sha256 "7f6c331c005eb7b1d9e2696980634e12b19ef9a315a3b0089785c0d39b2b1618"
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

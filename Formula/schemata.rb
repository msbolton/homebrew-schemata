class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v0.6.0/schemata-0.6.0-macos-arm64.tar.gz"
      sha256 "e135d6a898e189c9f62118996402a8dd7c3dbab6a9a542a6f3c61eedb7eb17f2"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v0.6.0/schemata-0.6.0-macos-x64.tar.gz"
      sha256 "cf5e4f25721e840a1323879b7e7e35cc8dc9e5fcb95744b8bdcf5421e5954a34"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v0.6.0/schemata-0.6.0-linux-x64.tar.gz"
      sha256 "5bce179e15d90a9dc52699d64512e8a6766ebafb9aedcbac1cda9efcaaa83cb6"
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

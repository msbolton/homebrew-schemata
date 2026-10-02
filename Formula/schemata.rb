class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v0.8.0/schemata-0.8.0-macos-arm64.tar.gz"
      sha256 "38f500d4b57aa3c4f6f8d402ae42c8811b5bff5905c2c8187b87e4aa0219489b"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v0.8.0/schemata-0.8.0-macos-x64.tar.gz"
      sha256 "ddc2edaf56a6f18a715ab03882931f13c2143b3fed48689142363a7ff3804082"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v0.8.0/schemata-0.8.0-linux-x64.tar.gz"
      sha256 "39bf134d5697302192080e747c231947009690c9c9a5d9681618cd4bc8327dff"
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

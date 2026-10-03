class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v0.9.0/schemata-0.9.0-macos-arm64.tar.gz"
      sha256 "9573a855e72a3b3ac9585bda93e30cedbb73904345f84816a00d8e4e3f2303d1"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v0.9.0/schemata-0.9.0-macos-x64.tar.gz"
      sha256 "f4402355ae66f36f11b7a00d97096f434af9044fab70b4a1c37d76cacd2d47bc"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v0.9.0/schemata-0.9.0-linux-x64.tar.gz"
      sha256 "3d111eab9534914cbc64c0fa9a37bbe5d512d8678ec3a84fe10f77656e26b438"
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

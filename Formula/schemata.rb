class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v2.2.0/schemata-2.2.0-macos-arm64.tar.gz"
      sha256 "d5b593a431403d1a100c8a9cfbac6c7fa3052534ad35641e9bc6284bb01a3932"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.2.0/schemata-2.2.0-macos-x64.tar.gz"
      sha256 "a4a43afc2c87d6fbfc3f1d4fdd05bc014975b8883fff2a551ea9531de58949be"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.2.0/schemata-2.2.0-linux-x64.tar.gz"
      sha256 "b70fd76eff9a0bf70306517c7d2f75fb9c86097259d1964d7f991620b54181d0"
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

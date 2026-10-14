class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v2.10.0/schemata-2.10.0-macos-arm64.tar.gz"
      sha256 "118faa5efdb037698908dd43f0a33a05175be16338a09f73e702e7d5b62aff5e"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.10.0/schemata-2.10.0-macos-x64.tar.gz"
      sha256 "4691bbec454e876a314d4eb4ec549638e0a982f3e15571047a2a3aa7f3a2f0a5"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.10.0/schemata-2.10.0-linux-x64.tar.gz"
      sha256 "67c5d405336295d174b12f4d7da47c8d14f84000dd24e8909e9bf211122fe3c4"
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

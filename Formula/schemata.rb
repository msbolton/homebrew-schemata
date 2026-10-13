class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v2.9.0/schemata-2.9.0-macos-arm64.tar.gz"
      sha256 "a0e72cd7f458920aa0de1a5f6b05f9ed9a17f225c2f6c6897fc4bab007bf7685"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.9.0/schemata-2.9.0-macos-x64.tar.gz"
      sha256 "39e925d084565bc1ee3940fb9d947f8b24f7d85f52977ecfc38945942c30c5d2"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.9.0/schemata-2.9.0-linux-x64.tar.gz"
      sha256 "d6411db6d83e2bcdc1ed12c268635d165533284166a05a3207995da2f625ecdb"
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

class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v2.5.0/schemata-2.5.0-macos-arm64.tar.gz"
      sha256 "520720cc47d49d3629bf8c54f7b3fcb51a714d3d8ef4c68ba05ffb398c62049b"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.5.0/schemata-2.5.0-macos-x64.tar.gz"
      sha256 "c35a35eca82127d2a3002da2062543f75f3b947e2a8516f18b07f47997da2437"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.5.0/schemata-2.5.0-linux-x64.tar.gz"
      sha256 "3b61f70cbc318b5de14a57c952a2825aaabfba7e7dcf7ba1a5e1c16ff04dfdb7"
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

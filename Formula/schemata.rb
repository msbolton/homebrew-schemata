class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v0.5.1/schemata-0.5.1-macos-arm64.tar.gz"
      sha256 "124448b409fb732830aed002e9eb50af0ac296444453e96ec78764d0edc416e4"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v0.5.1/schemata-0.5.1-macos-x64.tar.gz"
      sha256 "406ed7f45084233ad5ca4f344c23e57eac534178fdf872a2e9e6c34c26abb2a9"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v0.5.1/schemata-0.5.1-linux-x64.tar.gz"
      sha256 "c7a19a6e85bd3706097bfa1197a588e44fcd331b36446d9a053b308908f89884"
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

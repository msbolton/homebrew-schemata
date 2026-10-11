class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v2.3.0/schemata-2.3.0-macos-arm64.tar.gz"
      sha256 "c820dd11a90b22bba946c15411e08d2dce68c0fd0f301efc6abb72fabc963eee"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.3.0/schemata-2.3.0-macos-x64.tar.gz"
      sha256 "364aa3fcdd1e46cfa2b417a9c8d21d2f7c8eca438e4f81f709d3ef971beeb76a"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.3.0/schemata-2.3.0-linux-x64.tar.gz"
      sha256 "cfda7e2512c38b7bac35382cd19e09f8e14b52764b00b5909913c695ad4738cc"
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

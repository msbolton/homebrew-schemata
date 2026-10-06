class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v1.3.0/schemata-1.3.0-macos-arm64.tar.gz"
      sha256 "12357dcfdce29857cce5ac05416d01f8356cc85535267afe0e458cfe44e2b047"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v1.3.0/schemata-1.3.0-macos-x64.tar.gz"
      sha256 "48101669b5962411ba9982541fa4322b20a9106447921b3e4da69918e7ddc1aa"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v1.3.0/schemata-1.3.0-linux-x64.tar.gz"
      sha256 "7691eb285d1b6e94ee441685d7c4e8badeaab25550dcd20d06cfbb24bfdcc6f9"
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

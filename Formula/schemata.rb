class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v0.5.0/schemata-0.5.0-macos-arm64.tar.gz"
      sha256 "7fafaef969d2e95f3da6812c6aa36ad9d0ed228f85334b6b93d74175de5a6201"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v0.5.0/schemata-0.5.0-macos-x64.tar.gz"
      sha256 "d3a937b3497709f65e3a2aa2da34da62dd5d595f7e78f7e208f8d335f745ff87"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v0.5.0/schemata-0.5.0-linux-x64.tar.gz"
      sha256 "7c18ae2a96dd1ff009f94c23da63f790a76b9536764c698c7dcc255a5c545fa9"
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

class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v2.11.0/schemata-2.11.0-macos-arm64.tar.gz"
      sha256 "a38c4f051c4f821fbd4a174ae830781ab5e28418ba332ccf6b5b441facf5bb08"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.11.0/schemata-2.11.0-macos-x64.tar.gz"
      sha256 "ee9618f029584ae9b149abca8244bd208ff7f291450e059eb27e46999f73c33b"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.11.0/schemata-2.11.0-linux-x64.tar.gz"
      sha256 "a3afe054300029cb0b0f143c7187e6d5fed18f22a0381950cd45ffa2b1a71a53"
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

class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v2.8.0/schemata-2.8.0-macos-arm64.tar.gz"
      sha256 "deaa92485772540952036fd28443ff65fa0572d51966baf5e654cb3dfed4041c"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.8.0/schemata-2.8.0-macos-x64.tar.gz"
      sha256 "001fc1703a422938d3f8aeec3c54b90f470fda5751c68c5c1cf0ec925842292b"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.8.0/schemata-2.8.0-linux-x64.tar.gz"
      sha256 "c617e3f11c17df21bfaf0aaaa6d42f030c41e1331cc39f038d74f6649c013ef1"
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

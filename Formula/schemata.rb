class Schemata < Formula
  desc "Schema-of-schemas compiler: one model, Protobuf, Postgres DDL, XML Schema out"
  homepage "https://github.com/msbolton/Schemata"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/msbolton/Schemata/releases/download/v2.4.0/schemata-2.4.0-macos-arm64.tar.gz"
      sha256 "399663fe44e1e459c38e29977f9ff7b3cc5dc2918ca93c80cfde22fb6c621c5d"
    end
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.4.0/schemata-2.4.0-macos-x64.tar.gz"
      sha256 "425b395555fd61304a393f71f38ce82ad781449a11e6b398e1d9e431971eae3f"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/msbolton/Schemata/releases/download/v2.4.0/schemata-2.4.0-linux-x64.tar.gz"
      sha256 "2fe40fd4a8e54501feabe41f149fc7b30866c2b9649a60891dfa3a1f04abdfba"
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

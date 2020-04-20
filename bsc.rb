class Bsc < Formula
  desc "Bluespec System Verilog (BSV) Compiler (bsc)"
  homepage "https://github.com/B-Lang-org/bsc"
  url "https://github.com/baryberri/homebrew-bsc/releases/download/6a8cedf/bsc.tar.gz"
  version "6a8cedf"
  sha256 "4a54c15791577fddbde83c7753c825d5ea599de51a6b4b77a0edff3999dc157f"

  bottle do
    root_url "https://github.com/baryberri/homebrew-bsc/releases/download/6a8cedf"
    cellar :any
    sha256 "2a6850f54b780c5edf96e6c4de0d9ba1ebd90ffd48a7a4dbc7c7f507fa02b8d8" => :catalina
  end

  depends_on "autoconf"
  depends_on "cabal-install"
  depends_on "gperf"
  depends_on "icarus-verilog"
  depends_on "pkg-config"
  depends_on "gmp"

  def install
    system "cabal", "update"

    system "cabal", "v1-install",
                    "old-time",
                    "regex-compat",
                    "split",
                    "syb"

    system "make", "PREFIX=#{libexec}",
                   "-j4",
                   "GHCJOBS=4",
                   "GHCRTSFLAGS=+RTS -M4500M -A128m -RTS",
                   "MACOSX_DEPLOYMENT_TARGET=10.15"

    bin.write_exec_script("#{libexec}/bin/bsc")
    bin.write_exec_script("#{libexec}/bin/bluetcl")
  end
  
  def caveats
    <<~EOS
      🍗 Please set BLUESPECDIR environment (At ~/.zshrc):
        export BLUESPECDIR="#{libexec}/lib"
    EOS
  end

  test do
    system "false"
  end
end

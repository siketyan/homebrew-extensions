# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/20dfc41053f694558e80c781edf6f40c6db8b096.tar.gz?commit=20dfc41053f694558e80c781edf6f40c6db8b096"
  version "8.4.0"
  sha256 "90da3c03029779b6ac7a4edddea588c16fbb6d2e6d01868accbd458de03b3621"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any,                 arm64_sonoma:   "c2632cf261fc00991f4981162e571ed082696c1e2ab0782800d96d4ba7cfd211"
    sha256 cellar: :any,                 arm64_ventura:  "3161843d4d5dbd42b30df3245c93e0c4e16947258b12a9c85ae675c2fb1c8e00"
    sha256 cellar: :any,                 arm64_monterey: "43c23489e5416ae7e0aa3e4cda1892a292cb92cf7772da97bfb52ca369a9cb97"
    sha256 cellar: :any,                 ventura:        "ce48f93bf0b24ee44234ccb4137c09b9afdbe917363ca99898aaa6f972eff561"
    sha256 cellar: :any,                 monterey:       "91e88868cd97af526b0be98d3284a2e1c79feac06ddcf12941e10987b976424e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f676ee00deafa78d70de377d837797da809c3ab82cb626ca4b91f08254fdcc96"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end

require 'formula'

class RubyLdap <Formula
  url 'http://github.com/alexey-chebotar/ruby-ldap/tarball/0.9.11'
  homepage 'http://github.com/alexey-chebotar/ruby-ldap'
  md5 '89238a764ab70ec6307d329862994973'

  def install
    # Borrowed from ruby-odbc recipe
    # extconf.rb assumes it will install ruby-ldap within a folder in your
    # current ruby installation.
    system "ruby", "extconf.rb"

    # The following modifications to the Makefile ensure that it is installed
    # within your homebrew directories.
    inreplace 'Makefile' do |s|
      s.change_make_var! "prefix", prefix
      s.change_make_var! "sitearchdir", lib
    end

    lib.mkpath
    system 'make'
    system 'make install'
  end

  def caveats; <<-EOS
    Installed #{lib}/ldap.bundle

    You will need to add this to your RUBYLIB by adding the following line to
    .profile or .bashrc or equivalent:

    export RUBYLIB="#{HOMEBREW_PREFIX}/lib:$RUBYLIB"

    EOS
  end
end
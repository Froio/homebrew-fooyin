class Fooyin < Formula
  desc "Customisable music player (development HEAD)"
  homepage "https://fooyin.org"
  license "GPL-3.0-or-later"
  head "https://github.com/fooyin/fooyin.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "ffmpeg"
  depends_on "icu4c@77"
  depends_on "libarchive"
  depends_on "qt"
  depends_on "sdl2"
  depends_on "taglib"

  def install
    system "cmake", "-S", ".", "-B", "build", "-G", "Ninja",
           "-DCMAKE_BUILD_TYPE=Release",
           "-DCMAKE_INSTALL_PREFIX=#{prefix}",
           "-DCMAKE_PREFIX_PATH=#{Formula["qt"].opt_prefix}",
           "-DLibArchive_ROOT=#{Formula["libarchive"].opt_prefix}",
           "-DBUILD_ALSA=OFF",
           "-DBUILD_TESTING=OFF",
           "-DINSTALL_FHS=OFF"
    system "cmake", "--build", "build", "--parallel"
    system "cmake", "--install", "build"
    # Bundle ICU data alongside the ICU libraries copied by upstream.
    frameworks = prefix/"fooyin.app/Contents/Frameworks"
    frameworks.mkpath
    cp Formula["icu4c@77"].opt_lib/"libicudata.77.dylib", frameworks/"libicudata.77.dylib"
    bin.install_symlink prefix/"fooyin.app/Contents/MacOS/fooyin"

  end

  def caveats
    <<~EOS
      Development build from fooyin master; macOS support is experimental.
      Launch with: open #{opt_prefix}/fooyin.app
      Optional Applications shortcut:
        ln -s #{opt_prefix}/fooyin.app /Applications/fooyin.app
      To fetch newer commits: brew uninstall fooyin && brew install --HEAD froio/fooyin/fooyin
    EOS
  end
end

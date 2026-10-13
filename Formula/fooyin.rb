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
    bin.install_symlink prefix/"fooyin.app/Contents/MacOS/fooyin"
    # Homebrew manages the app in the Cellar; link it into /Applications.
    # Avoid overwriting a separately installed fooyin.app.
    app_target = Pathname("/Applications/fooyin.app")
    if app_target.exist? || app_target.symlink?
      opoo "#{app_target} already exists; leaving it unchanged"
    else
      app_target.make_symlink(prefix/"fooyin.app")
    end
  end

  def caveats
    <<~EOS
      Development build from fooyin master; macOS support is experimental.
      Launch from /Applications/fooyin.app (or open #{opt_prefix}/fooyin.app).
      If /Applications/fooyin.app already existed, it was left unchanged.
      To fetch newer commits: brew reinstall --HEAD fooyin
    EOS
  end
end

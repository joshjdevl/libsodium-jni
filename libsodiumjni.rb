class Libsodiumjni < Formula
  desc "NaCl networking and cryptography library"
  homepage "https://github.com/joshjdevl/libsodium-jni/"
  url "https://github.com/joshjdevl/libsodium-jni/archive/2c0cc0011aef567432b67a9d904eee0882c86291.zip"

  head do
    url "https://github.com/joshjdevl/libsodium-jni.git"

    depends_on "libtool" => :build
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "swig" => :build
    depends_on "android-sdk" => :build
    depends_on "android-ndk" => :build
    depends_on "gradle" => :build
  end

  option :universal

  def install
    ENV.universal_binary if build.universal?

    system "whoami"    
    system "./build.sh"
    system "cd jni && ./compile.sh"
    system "mvn -q clean install"
    system "./singleTest.sh"
    system "ndk-build"
    system "gradle build" 
    #system "./autogen.sh" if build.head?
    #system "./configure", "--disable-debug", "--disable-dependency-tracking",
    #                      "--prefix=#{prefix}"
    #system "make", "check"
    #system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <assert.h>
      #include <sodium.h>

      int main()
      {
        assert(sodium_init() != -1);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-lsodium", "-o", "test"
    system "./test"
  end
end


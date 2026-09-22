{ pkgs ? import <nixpkgs> { } }:

let
  jdk = pkgs.jdk25;

  # Native libraries needed only by `./gradlew runClient` (LWJGL / OpenGL / audio).
  runtimeLibs = with pkgs; [
    libGL
    glfw
    openal
    libpulseaudio
    alsa-lib
    udev
    xorg.libX11
    xorg.libXcursor
    xorg.libXext
    xorg.libXrandr
    xorg.libXxf86vm
    xorg.libXi
  ];
in
pkgs.mkShell {
  packages = [ jdk pkgs.git ];

  # Use the project's Gradle wrapper, but make sure it runs on JDK 25.
  JAVA_HOME = "${jdk}";
  GRADLE_OPTS = "-Dorg.gradle.java.home=${jdk}";

  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath runtimeLibs;

  shellHook = ''
    # A global -XX:+UseG1GC here clashes with the Kotlin daemon's own GC choice.
    unset _JAVA_OPTIONS
    echo "Maze3Dplus dev shell: $(java -version 2>&1 | grep -m1 version)"
    echo "  ./gradlew build       build the mod jar"
    echo "  ./gradlew runServer   start a dev server"
    echo "  ./gradlew runClient   start a dev client"
  '';
}

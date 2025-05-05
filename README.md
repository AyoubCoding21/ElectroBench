# ElectroBench
ElectroBench is a 45-second long benchmark specifiacally designed to run on old and modern PCs, don't critise it by it using OpenGL 2.1, and GLSL 1.2, Even office PCs have low scores at it.
It uses OpenGL 2.1, and C++, and uses Conan and CMake for compilation. It is designed to be a replacement for glmark (even though it is great and I used it before).

# Effects

In this benchmark, we are using realistic lighting techniques, thanks to the shaders (with some limitations, of course), then we load 90 UZIs (!!) with 6 textures each onto the screen.

You can move the camera by long-clicking and moving the mouse.

# How the score is calculated ?
The score is calculated using this formula : ```fps*2/(1.01/fps)``` 

# How to run ?

Make sure you have `conan 2` installed and then run the following
command on your machine after cloning repo and going into the 0.1 directory:

***Make sure that you have clang installed and that you copy conanprofile's contents into ~/.conan2/profiles/default in order for this to work.***

```sh
conan install . --output-folder="conan/deb" -sbuild_type=Debug --build=missing -pr conanprofile
mkdir build 
cmake . -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=conan/deb/conan_toolchain.cmake -DCMAKE_POLICY_DEFAULT_CMP0091=NEW -DCMAKE_BUILD_TYPE=Debug -B build/
cd build/
make
cd ..
./build/ElectroBench
```

# Contributions

Contributions are welcome, just post a PR / issue.

# Donating

Send me in my email or post an issue : ayoubprogramming96@outlook.com

# Special thanks

[Fransisco Ramirez](https://github.com/franramirez688) : for fixing an issue with pulseaudio/14.2 recipe when installing sdl2 in conan2

[Matheus Gomes](https://github.com/matheusgomes28) : for giving me ideas and tips to improve the project, and he was the origin of me using conan for the next ElectroBench versions.

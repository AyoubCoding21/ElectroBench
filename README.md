# ElectroBench
ElectroBench is a 45-second long benchmark specifiacally designed to run on old and modern PCs, don't critise it by it using OpenGL 2.1/3.0, and GLSL 1.2/1.3, Even office PCs have low scores at it.
It uses OpenGL 2.1/3.0, and C++, and uses Make and CMake for compilation. It is designed to be a replacement for glmark (even though it is great and I used it before).

# Effects
So in v0.1-stable, We are using lambertian + blinn-phong lighting, and FBM based-off 3D Simplex noise to make a procedural texture and then mixing the lighting and the texture together, and then adding some effects, like bloom, pulsating color, uv distortion, shadowing and vignette effect, also the benchmark calculates the score and prints in the terminal.

In v0.2-stable, We are using 3 noise types with high-precision and then mixing them and re-mixing them, then we use phong lighting with no ambient color + frensel reflection, and we use material procedural textures using noising, like brick texture and metal textures and noise color and then mixing them with lighting and showing it on the screen.

In the screen is rendered a teapot and then applying the shaders on them.

In 0.3, We are using Disney PBR specular term, Lambertian diffuse term and ambient occulsion sampling with noising and we are loading 4 M4A1 obj with 3 textures into the screen, you can zoom-in by scrolling up and zoom-out by scrolling down.

It's recommended in the benchmark that you zoom in into the maximum in v0.3 to maximize GPU utilisation.

# How the score is calculated ?
The score is calculated using this formula : ```fps*2/frametime``` (in version 0.3 only).

For v0.1 and v0.2 : ```fps*9/frametime```.

### PS : 0.1-alpha and 0.2-alpha are considered now stable and aren't maintianed anymore.

# How to run ?

Debian-based Operating Systems:

*v0.1-stable*

```bash
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench
cd ElectroBench/ElectroBench-0.1-stable
make install all
```

*v0.2-stable*
```bash
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench
cd ElectroBench/ElectroBench-0.2-stable
make install all
```

# Build Instructions for v0.3-alpha

Make sure you have `conan 2` installed and then run the following
command on your machine after cloning repo and going into the 0.3 directory:

***Make sure that you have clang-15 or more installed and that you copy conanprofile's contents into ~/.conan2/profiles/default in order for this to work.***

```sh
conan install . --output-folder="conan/deb" -sbuild_type=Debug --build=missing -pr conanprofile
mkdir build 
cmake . -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=conan/deb/conan_toolchain.cmake -DCMAKE_POLICY_DEFAULT_CMP0091=NEW -DCMAKE_BUILD_TYPE=Debug -B build/
cd build/
make
cd ..
./build/ElectroBench
```

# Donating

Send me an e-mail : ayoubprogramming96@outlook.com

# Special thanks

[Fransisco Ramirez](https://github.com/franramirez688) : for fixing an issue with pulseaudio/14.2 recipe when installing sdl2 in conan2

[Matheus Gomes](https://github.com/matheusgomes28) : for giving me ideas and tips to improve the project, and he was the origin of me using conan for the next ElectroBench versions.

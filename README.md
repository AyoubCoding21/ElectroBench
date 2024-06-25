# ElectroBench
ElectroBench is a 45-second long benchmark specifiacally designed to run on old and modern PCs, don't critise it by it using OpenGL 2.1/3.0, and GLSL 1.2/1.3, Even office PCs have low scores at it.
It uses OpenGL 2.1/3.0, and C++, and uses Make and CMake for compilation. It is designed to be a replacement for glmark (even though it is great and I used it before).

# Effects
So in v0.1-alpha, We are using lambertian + blinn-phong lighting, and FBM based-off 3D Simplex noise to make a procedural texture and then mixing the lighting and the texture together, and then adding some effects, like bloom, pulsating color, uv distortion, shadowing and vignette effect, also the benchmark calculates the score and prints in the terminal.

In v0.2-alpha, We are using 3 noise types with high-precision and then mixing them and re-mixing them, then we use phong lighting with no ambient color + frensel reflection, and we use material procedural textures using noising, like brick texture and metal textures and noise color and then mixing them with lighting and showing it on the screen.

In the screen is rendered a teapot and then applying the shaders on them.

# How the score is calculated ?
The score is calculated using this formula : ```fps*4/frametime```.

# How to run ?

Debian-based Operating Systems:

*v0.1-alpha*

```bash
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench
cd ElectroBench/ElectroBench-0.1-alpha
make install all
```

*v0.2-alpha*
```bash
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench
cd ElectroBench/ElectroBench-0.2-alpha
make install clean all
```
*v0.3-still-in-dev*
```bash
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench
cd ElectroBench/ElectroBench-0.3-still-in-dev
make install all
```

# Donating

Send me an e-mail : ayoubprogramming96@outlook.com

# Build Instructions for v0.3

Make sure you have `conan 2` installed and then run the following
command on your machine:

```sh
conan install . --output-folder="conan/deb" -sbuild_type=Debug --build=missing
```

To configure CMake, don't forget to pass `CMAKE\_TOOLCHAIN\_FILE":

```sh
cmake . -DCMAKE_TOOLCHAIN_FILE="$(pwd)/conan/deb/conan_toolchain.cmake"
```


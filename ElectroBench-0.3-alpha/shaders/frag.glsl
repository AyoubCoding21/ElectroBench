#version 120

uniform sampler2D uTexture;
uniform sampler2D uTexture2;
uniform sampler2D uTexture3;
uniform sampler2D uTexture4;
uniform sampler2D uTexture5;

varying vec3 vNormal;
varying vec3 vPosition;
varying vec2 vTexCoord;

vec3 mod289(vec3 x)
{
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 mod289(vec4 x)
{
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 permute(vec4 x)
{
  return mod289(((x*34.0)+10.0)*x);
}

vec4 taylorInvSqrt(vec4 r)
{
  return 1.79284291400159 - 0.8537347209531 * r;
}

vec3 fade(vec3 t) {
  return t*t*t*(t*(t*6.0-15.0)+10.0);
}

vec3 mod7(vec3 x) {
  return x - floor(x * (1.0 / 7.0)) * 7.0;
}

vec3 permute(vec3 x) {
  return mod289((34.0 * x + 10.0) * x);
}


float mod289(float x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

float permute(float x) {
     return mod289(((x*34.0)+10.0)*x);
}

vec2 rgrad2(vec2 p, float rot) {
#if 0
  float u = permute(permute(p.x) + p.y) * 0.0243902439 + rot;
  u = 4.0 * fract(u) - 2.0;
  return vec2(abs(u)-1.0, abs(abs(u+1.0)-2.0)-1.0);
#else
  float u = permute(permute(p.x) + p.y) * 0.0243902439 + rot;
  u = fract(u) * 6.28318530718;
  return vec2(cos(u), sin(u));
#endif
}

vec2 mod289(vec2 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

float snoise(vec3 v)
{
  const vec2  C = vec2(1.0/6.0, 1.0/3.0);
  const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);

  vec3 i  = floor(v + dot(v, C.yyy));
  vec3 x0 =   v - i + dot(i, C.xxx);
  vec3 g = step(x0.yzx, x0.xyz);
  vec3 l = 1.0 - g;
  vec3 i1 = min(g.xyz, l.zxy);
  vec3 i2 = max(g.xyz, l.zxy);

  vec3 x1 = x0 - i1 + C.xxx;
  vec3 x2 = x0 - i2 + C.yyy; // 2.0*C.x = 1/3 = C.y
  vec3 x3 = x0 - D.yyy;      // -1.0+3.0*C.x = -0.5 = -D.y

  i = mod289(i);
  vec4 p = permute(permute(permute(
             i.z + vec4(0.0, i1.z, i2.z, 1.0))
           + i.y + vec4(0.0, i1.y, i2.y, 1.0))
           + i.x + vec4(0.0, i1.x, i2.x, 1.0));

  float n_ = 0.142857142857; // 1.0/7.0
  vec3 ns = n_ * D.wyz - D.xzx;
  vec4 j = p - 49.0 * floor(p * ns.z * ns.z);  //  mod(p,7*7)
  vec4 x_ = floor(j * ns.z);
  vec4 y_ = floor(j - 7.0 * x_ );    // mod(j,N)
  vec4 x = x_ *ns.x + ns.yyyy;
  vec4 y = y_ *ns.x + ns.yyyy;
  vec4 h = 1.0 - abs(x) - abs(y);
  vec4 b0 = vec4( x.xy, y.xy );
  vec4 b1 = vec4( x.zw, y.zw );
  vec4 s0 = floor(b0)*2.0 + 1.0;
  vec4 s1 = floor(b1)*2.0 + 1.0;
  vec4 sh = -step(h, vec4(0.0));
  vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
  vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;
  vec3 p0 = vec3(a0.xy,h.x);
  vec3 p1 = vec3(a0.zw,h.y);
  vec3 p2 = vec3(a1.xy,h.z);
  vec3 p3 = vec3(a1.zw,h.w);
  vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;
  vec4 m = max(0.5 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
  m = m * m;
  return 105.0 * dot( m*m, vec4(dot(p0,x0), dot(p1,x1),
                                dot(p2,x2), dot(p3,x3)));
}
// Classic Perlin noise
float rand(vec3 P)
{
  vec3 Pi0 = floor(P); // Integer part for indexing
  vec3 Pi1 = Pi0 + vec3(1.0); // Integer part + 1
  Pi0 = mod289(Pi0);
  Pi1 = mod289(Pi1);
  vec3 Pf0 = fract(P); // Fractional part for interpolation
  vec3 Pf1 = Pf0 - vec3(1.0); // Fractional part - 1.0
  vec4 ix = vec4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
  vec4 iy = vec4(Pi0.yy, Pi1.yy);
  vec4 iz0 = Pi0.zzzz;
  vec4 iz1 = Pi1.zzzz;

  vec4 ixy = permute(permute(ix) + iy);
  vec4 ixy0 = permute(ixy + iz0);
  vec4 ixy1 = permute(ixy + iz1);

  vec4 gx0 = ixy0 * (1.0 / 7.0);
  vec4 gy0 = fract(floor(gx0) * (1.0 / 7.0)) - 0.5;
  gx0 = fract(gx0);
  vec4 gz0 = vec4(0.5) - abs(gx0) - abs(gy0);
  vec4 sz0 = step(gz0, vec4(0.0));
  gx0 -= sz0 * (step(0.0, gx0) - 0.5);
  gy0 -= sz0 * (step(0.0, gy0) - 0.5);

  vec4 gx1 = ixy1 * (1.0 / 7.0);
  vec4 gy1 = fract(floor(gx1) * (1.0 / 7.0)) - 0.5;
  gx1 = fract(gx1);
  vec4 gz1 = vec4(0.5) - abs(gx1) - abs(gy1);
  vec4 sz1 = step(gz1, vec4(0.0));
  gx1 -= sz1 * (step(0.0, gx1) - 0.5);
  gy1 -= sz1 * (step(0.0, gy1) - 0.5);

  vec3 g000 = vec3(gx0.x,gy0.x,gz0.x);
  vec3 g100 = vec3(gx0.y,gy0.y,gz0.y);
  vec3 g010 = vec3(gx0.z,gy0.z,gz0.z);
  vec3 g110 = vec3(gx0.w,gy0.w,gz0.w);
  vec3 g001 = vec3(gx1.x,gy1.x,gz1.x);
  vec3 g101 = vec3(gx1.y,gy1.y,gz1.y);
  vec3 g011 = vec3(gx1.z,gy1.z,gz1.z);
  vec3 g111 = vec3(gx1.w,gy1.w,gz1.w);

  vec4 norm0 = taylorInvSqrt(vec4(dot(g000, g000), dot(g010, g010), dot(g100, g100), dot(g110, g110)));
  g000 *= norm0.x;
  g010 *= norm0.y;
  g100 *= norm0.z;
  g110 *= norm0.w;
  vec4 norm1 = taylorInvSqrt(vec4(dot(g001, g001), dot(g011, g011), dot(g101, g101), dot(g111, g111)));
  g001 *= norm1.x;
  g011 *= norm1.y;
  g101 *= norm1.z;
  g111 *= norm1.w;
  float n000 = dot(g000, Pf0);
  float n100 = dot(g100, vec3(Pf1.x, Pf0.yz));
  float n010 = dot(g010, vec3(Pf0.x, Pf1.y, Pf0.z));
  float n110 = dot(g110, vec3(Pf1.xy, Pf0.z));
  float n001 = dot(g001, vec3(Pf0.xy, Pf1.z));
  float n101 = dot(g101, vec3(Pf1.x, Pf0.y, Pf1.z));
  float n011 = dot(g011, vec3(Pf0.x, Pf1.yz));
  float n111 = dot(g111, Pf1);

  vec3 fade_xyz = fade(Pf0);
  vec4 n_z = mix(vec4(n000, n100, n010, n110), vec4(n001, n101, n011, n111), fade_xyz.z);
  vec2 n_yz = mix(n_z.xy, n_z.zw, fade_xyz.y);
  float n_xyz = mix(n_yz.x, n_yz.y, fade_xyz.x);
  return 2.2 * n_xyz;
}
vec2 cellular(vec3 P) {
#define K 1/7
#define Ko 1/2-K/2
#define K2 1/49
#define Kz 1/6
#define Kzo 1/2-1/6*2
#define jitter 1.9762844847 // smaller jitter gives more regular pattern

    vec3 Pi = mod289(floor(P));
    vec3 Pf = fract(P) - 0.5;

    vec3 Pfx = Pf.x + vec3(1.0, 0.0, -1.0);
    vec3 Pfy = Pf.y + vec3(1.0, 0.0, -1.0);
    vec3 Pfz = Pf.z + vec3(1.0, 0.0, -1.0);

    vec3 p = permute(Pi.x + vec3(-1.0, 0.0, 1.0));
    vec3 p1 = permute(p + Pi.y - 1.0);
    vec3 p2 = permute(p + Pi.y);
    vec3 p3 = permute(p + Pi.y + 1.0);

    vec3 p11 = permute(p1 + Pi.z - 1.0);
    vec3 p12 = permute(p1 + Pi.z);
    vec3 p13 = permute(p1 + Pi.z + 1.0);

    vec3 p21 = permute(p2 + Pi.z - 1.0);
    vec3 p22 = permute(p2 + Pi.z);
    vec3 p23 = permute(p2 + Pi.z + 1.0);

    vec3 p31 = permute(p3 + Pi.z - 1.0);
    vec3 p32 = permute(p3 + Pi.z);
    vec3 p33 = permute(p3 + Pi.z + 1.0);

    vec3 ox11 = fract(p11*K) - Ko;
    vec3 oy11 = mod7(floor(p11*K))*K - Ko;
    vec3 oz11 = floor(p11*K2)*Kz - Kzo; // p11 < 289 guaranteed

    vec3 ox12 = fract(p12*K) - Ko;
    vec3 oy12 = mod7(floor(p12*K))*K - Ko;
    vec3 oz12 = floor(p12*K2)*Kz - Kzo;

    vec3 ox13 = fract(p13*K) - Ko;
    vec3 oy13 = mod7(floor(p13*K))*K - Ko;
    vec3 oz13 = floor(p13*K2)*Kz - Kzo;

    vec3 ox21 = fract(p21*K) - Ko;
    vec3 oy21 = mod7(floor(p21*K))*K - Ko;
    vec3 oz21 = floor(p21*K2)*Kz - Kzo;

    vec3 ox22 = fract(p22*K) - Ko;
    vec3 oy22 = mod7(floor(p22*K))*K - Ko;
    vec3 oz22 = floor(p22*K2)*Kz - Kzo;

    vec3 ox23 = fract(p23*K) - Ko;
    vec3 oy23 = mod7(floor(p23*K))*K - Ko;
    vec3 oz23 = floor(p23*K2)*Kz - Kzo;

    vec3 ox31 = fract(p31*K) - Ko;
    vec3 oy31 = mod7(floor(p31*K))*K - Ko;
    vec3 oz31 = floor(p31*K2)*Kz - Kzo;

    vec3 ox32 = fract(p32*K) - Ko;
    vec3 oy32 = mod7(floor(p32*K))*K - Ko;
    vec3 oz32 = floor(p32*K2)*Kz - Kzo;

    vec3 ox33 = fract(p33*K) - Ko;
    vec3 oy33 = mod7(floor(p33*K))*K - Ko;
    vec3 oz33 = floor(p33*K2)*Kz - Kzo;

    vec3 dx11 = Pfx + jitter*ox11;
    vec3 dy11 = Pfy.x + jitter*oy11;
    vec3 dz11 = Pfz.x + jitter*oz11;

    vec3 dx12 = Pfx + jitter*ox12;
    vec3 dy12 = Pfy.x + jitter*oy12;
    vec3 dz12 = Pfz.y + jitter*oz12;

    vec3 dx13 = Pfx + jitter*ox13;
    vec3 dy13 = Pfy.x + jitter*oy13;
    vec3 dz13 = Pfz.z + jitter*oz13;

    vec3 dx21 = Pfx + jitter*ox21;
    vec3 dy21 = Pfy.y + jitter*oy21;
    vec3 dz21 = Pfz.x + jitter*oz21;

    vec3 dx22 = Pfx + jitter*ox22;
    vec3 dy22 = Pfy.y + jitter*oy22;
    vec3 dz22 = Pfz.y + jitter*oz22;

    vec3 dx23 = Pfx + jitter*ox23;
    vec3 dy23 = Pfy.y + jitter*oy23;
    vec3 dz23 = Pfz.z + jitter*oz23;

    vec3 dx31 = Pfx + jitter*ox31;
    vec3 dy31 = Pfy.z + jitter*oy31;
    vec3 dz31 = Pfz.x + jitter*oz31;

    vec3 dx32 = Pfx + jitter*ox32;
    vec3 dy32 = Pfy.z + jitter*oy32;
    vec3 dz32 = Pfz.y + jitter*oz32;

    vec3 dx33 = Pfx + jitter*ox33;
    vec3 dy33 = Pfy.z + jitter*oy33;
    vec3 dz33 = Pfz.z + jitter*oz33;

    vec3 d11 = dx11 * dx11 + dy11 * dy11 + dz11 * dz11;
    vec3 d12 = dx12 * dx12 + dy12 * dy12 + dz12 * dz12;
    vec3 d13 = dx13 * dx13 + dy13 * dy13 + dz13 * dz13;
    vec3 d21 = dx21 * dx21 + dy21 * dy21 + dz21 * dz21;
    vec3 d22 = dx22 * dx22 + dy22 * dy22 + dz22 * dz22;
    vec3 d23 = dx23 * dx23 + dy23 * dy23 + dz23 * dz23;
    vec3 d31 = dx31 * dx31 + dy31 * dy31 + dz31 * dz31;
    vec3 d32 = dx32 * dx32 + dy32 * dy32 + dz32 * dz32;
    vec3 d33 = dx33 * dx33 + dy33 * dy33 + dz33 * dz33;

#if 0
    vec3 d1 = min(min(d11,d12), d13);
    vec3 d2 = min(min(d21,d22), d23);
    vec3 d3 = min(min(d31,d32), d33);
    vec3 d = min(min(d1,d2), d3);
    d.x = min(min(d.x,d.y),d.z);
    return vec2(sqrt(d.x));
#else
    vec3 d1a = min(d11, d12);
    d12 = max(d11, d12);
    d11 = min(d1a, d13); // Smallest now not in d12 or d13
    d13 = max(d1a, d13);
    d12 = min(d12, d13); // 2nd smallest now not in d13
    vec3 d2a = min(d21, d22);
    d22 = max(d21, d22);
    d21 = min(d2a, d23); // Smallest now not in d22 or d23
    d23 = max(d2a, d23);
    d22 = min(d22, d23); // 2nd smallest now not in d23
    vec3 d3a = min(d31, d32);
    d32 = max(d31, d32);
    d31 = min(d3a, d33); // Smallest now not in d32 or d33
    d33 = max(d3a, d33);
    d32 = min(d32, d33); // 2nd smallest now not in d33
    vec3 da = min(d11, d21);
    d21 = max(d11, d21);
    d11 = min(da, d31); // Smallest now in d11
    d31 = max(da, d31); // 2nd smallest now not in d31
    d11.xy = (d11.x < d11.y) ? d11.xy : d11.yx;
    d11.xz = (d11.x < d11.z) ? d11.xz : d11.zx; // d11.x now smallest
    d12 = min(d12, d21); // 2nd smallest now not in d21
    d12 = min(d12, d22); // nor in d22
    d12 = min(d12, d31); // nor in d31
    d12 = min(d12, d32); // nor in d32
    d11.yz = min(d11.yz,d12.xy); // nor in d12.yz
    d11.y = min(d11.y,d12.z); // Only two more to go
    d11.y = min(d11.y,d11.z); // Done! (Phew!)
    return sqrt(d11.xy); // F1, F2
#endif
}
float benchNoise(vec2 P)
{
    float res = 0.0;
    float time = 0.0;
    for (float i = 0; i < 1; i++)
    {
        res = cellular(vec3(P + time, i + 0.4)).x +
              snoise(vec3(P + time, i + 0.8)) +
              rand(vec3(P + time, i + 0.02));
        time += 0.5;
    }
    return res;
}

// Parameters for lighting
vec3 lightColors[8] = vec3[](
    vec3(0.3, 0.3, 0.3),
    vec3(0.3, 0.3, 0.3),
    vec3(0.6, 0.6, 0.6),
    vec3(0.8, 0.8, 0.8),
    vec3(0.08, 0.08, 0.08),
    vec3(0.9, 0.9, 0.9),
    vec3(0.3, 0.4, 0.4),
    vec3(0.5, 0.5, 0.5)
);
vec3 lightPositions[8] = vec3[](
    vec3(10.0, 10.0, 10.0),
    vec3(-10.0, 5.0, 5.0),
    vec3(5.0, -10.0, 5.0),
    vec3(-5.0, 10.0, -5.0),
    vec3(-7.0, 0.0, 1.0),
    vec3(-10.0, 5.0, 5.0),
    vec3(0.0, 10.0, 10.0),
    vec3(-10.0, 5.0, -5.0)
);
vec3 ambientColor = vec3(0.15, 0.15, 0.15);
vec3 specularColor = vec3(0.15, 0.15, 0.15);
float shininess = 1024.0;
float fresnelPower = 5.0;
float metallic = 0.9;
float roughness = 0.5;
uniform float timeFactor;

float GGXDistribution(float alpha, float NoH) {
    float a2 = alpha * alpha;
    float denom = max(1.0, NoH * (a2 - 1.0) + 1.0);
    return a2 / (3.14159 * denom * denom);
}

float GGXVisibility(float alpha, float NoV, float NoL) {
    float a = alpha * alpha;
    float k = a / 2.0;
    return 1.0 / (NoV * (1.0 - k) + k) * 1.0 / (NoL * (1.0 - k) + k);
}

float SphericalHarmonics(float x, float y, float z, int l, int m) {
    if (l == 0 && m == 0) return 0.282095;
    if (l == 1 && m == -1) return 0.488603 * y;
    if (l == 1 && m == 0) return 0.488603 * z;
    if (l == 1 && m == 1) return 0.488603 * x;
    if (l == 2 && m == -2) return 1.092548 * x * y;
    if (l == 2 && m == -1) return 1.092548 * y * z;
    if (l == 2 && m == 0) return 0.315392 * (x * x - y * y);
    if (l == 2 && m == 1) return 1.092548 * x * z;
    if (l == 2 && m == 2) return 0.546274 * (x * x - y * y);
    return 0.0;
}

float AmbientOcclusion(vec3 normal, vec3 viewDir, vec3 position) {
    float ao = 0.0;
    for (int i = 0; i < 8; ++i) {
        vec3 samplePos = position + vec3(benchNoise(vec2(position.xy) * 123.456) * 2.0 - 1.0, benchNoise(vec2(position.xy) * 234.567) * 2.0, 1.0) * 0.1;
        vec3 sampleNormal = normalize(samplePos - position);
        ao += max(dot(normal, sampleNormal), 0.0);
    }
    ao /= 8.0;
    return ao;
}
float SubSurfaceScattering(vec3 normal, vec3 viewDir, vec3 position) {
    float sss = 0.0;
    for (int i = 0; i < 16; ++i) {
        vec3 samplePos = position + vec3(benchNoise(vec2(position.xy) * 345.678) * 2.0 - 1.0, benchNoise(vec2(position.xy) * 456.789) * 2.0, 1.0) * 0.1;
        vec3 sampleNormal = normalize(samplePos - position);
        sss += max(dot(normal, sampleNormal), 0.0);
    }
    sss /= 16.0;
    return sss;
}

void main() {
    vec3 normal = normalize(vNormal);
    vec3 viewDir = normalize(-vPosition);

    vec3 albedo1 = texture2D(uTexture, vTexCoord).rgb;
    vec3 albedo2 = texture2D(uTexture2, vTexCoord).rgb;
    vec3 albedo3 = texture2D(uTexture3, vTexCoord).rgb;
    vec3 albedo4 = texture2D(uTexture4, vTexCoord).rgb;
    vec3 albedo5 = texture2D(uTexture5, vTexCoord).rgb;
    float mixFactor = 0.56;
    vec3 albedo = mix(albedo1, albedo2, mixFactor);
    albedo += mix(albedo2, albedo3, 0.504);
    albedo += mix(albedo3, albedo4, 0.555);
    albedo += mix(albedo4, albedo5, 0.7);


    vec3 finalDiffuse = vec3(0.0);
    vec3 finalSpecular = vec3(0.0);

    // Iterate over light sources
    for (int i = 0; i < 8; ++i) {
        vec3 lightDir = normalize(lightPositions[i] - vPosition);
        vec3 halfwayDir = normalize(lightDir + viewDir);

        // Diffuse lighting
        float diff = max(dot(normal, lightDir), 0.0);
        finalDiffuse += diff * lightColors[i] * albedo;

        // Cook-Torrance specular
        float NDF = GGXDistribution(roughness, dot(normal, halfwayDir));
        float G = GGXVisibility(roughness, dot(normal, viewDir), dot(normal, lightDir));
        vec3 F = specularColor + (1.0 - specularColor) * pow(1.0 - dot(viewDir, halfwayDir), fresnelPower);

        vec3 spec = (NDF * G * F) / max(0.001, 4.0 * dot(normal, viewDir) * dot(normal, lightDir));
        finalSpecular += spec * lightColors[i];
    }

    // Fresnel effect
    float fresnel = pow(1.0 - dot(viewDir, normal), fresnelPower);
    vec3 fresnelEffect = fresnel * specularColor;

    // Additional effects
    // Rim lighting
    float rim = pow(1.0 - dot(normal, viewDir), 2.0);
    vec3 rimColor = vec3(1.0, 0.5, 0.2);
    finalDiffuse += rim * rimColor * albedo;

    // Ambient Occlusion
    float ao = AmbientOcclusion(normal, viewDir, vPosition);
    finalDiffuse *= ao;

    // Vignette effect
    float vignette = smoothstep(0.5, 0.8, length(vTexCoord - vec2(0.5, 0.5)));
    finalDiffuse *= vignette;

    // God rays
    float godRays = pow(clamp(dot(normal, viewDir), 0.0, 1.0), 4.0);
    godRays *= pow(length(lightPositions[0] - vPosition), -2.0);
    finalDiffuse += godRays * vec3(1.0, 0.8, 0.6) * albedo;

    // Lens flares
    float lensFlare = pow(clamp(dot(normal, viewDir), 0.0, 1.0), 8.0);
    lensFlare *= pow(length(lightPositions[0] - vPosition), -4.0);
    finalDiffuse += lensFlare * vec3(1.0, 0.9, 0.8) * albedo;

    // Spherical Harmonics lighting
    vec3 sphericalHarmonics = vec3(0.0);
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < 3; ++j) {
            sphericalHarmonics += SphericalHarmonics(normal.x, normal.y, normal.z, i, j) * albedo;
        }
    }
    finalDiffuse += sphericalHarmonics;

    // Sub-Surface Scattering
    float sss = SubSurfaceScattering(normal, viewDir, vPosition);
    finalDiffuse += sss * albedo;

    vec3 color  = ambientColor * albedo + finalDiffuse * (1.0 - metallic) + finalSpecular * metallic + fresnelEffect;

    // Dynamic effect based on time
    float wave = sin(vPosition.x * 0.5 + timeFactor) * 0.5 + 0.5;
    vec3 finalColor = color * wave;

    gl_FragColor = vec4(finalColor, 1.0);
}

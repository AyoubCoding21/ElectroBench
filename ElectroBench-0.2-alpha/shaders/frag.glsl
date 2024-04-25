#version 130
precision highp float;
varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vLightDir[31];
varying vec2 vTextureCoord;
varying vec3 lightDirection;

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
vec2 cellular(vec3 P) {
#define K 1/7
#define Ko 1/2-K/2
#define K2 1/49
#define Kz 1/6
#define Kzo 1/2-1/6*2
#define jitter 1.7762844847 // smaller jitter gives more regular pattern

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
vec2 cellular2D(vec2 P) {
#define K2D 1/7
#define Ko2D 3/7
#define jitter2D 1.84125 // Less gives more regular pattern
    vec2 Pi = mod289(floor(P));
    vec2 Pf = fract(P);
    vec3 oi = vec3(-1.0, 0.0, 1.0);
    vec3 of = vec3(-0.5, 0.5, 1.5);
    vec3 px = permute(Pi.x + oi);
    vec3 p = permute(px.x + Pi.y + oi); // p11, p12, p13
    vec3 ox = fract(p*K2D) - Ko2D;
    vec3 oy = mod7(floor(p*K2D))*K2D - Ko2D;
    vec3 dx = Pf.x + 0.5 + jitter2D*ox;
    vec3 dy = Pf.y - of + jitter2D*oy;
    vec3 d1 = dx * dx + dy * dy; // d11, d12 and d13, squared
    p = permute(px.y + Pi.y + oi); // p21, p22, p23
    ox = fract(p*K2D) - Ko2D;
    oy = mod7(floor(p*K2D))*K2D - Ko2D;
    dx = Pf.x - 0.5 + jitter2D*ox;
    dy = Pf.y - of + jitter2D*oy;
    vec3 d2 = dx * dx + dy * dy; // d21, d22 and d23, squared
    p = permute(px.z + Pi.y + oi); // p31, p32, p33
    ox = fract(p*K2D) - Ko2D;
    oy = mod7(floor(p*K))*K2D - Ko2D;
    dx = Pf.x - 1.5 + jitter2D*ox;
    dy = Pf.y - of + jitter2D*oy;
    vec3 d3 = dx * dx + dy * dy; // d31, d32 and d33, squared
    // Sort out the two smallest distances (F1, F2)
    vec3 d1a = min(d1, d2);
    d2 = max(d1, d2); // Swap to keep candidates for F2
    d2 = min(d2, d3); // neither F1 nor F2 are now in d3
    d1 = min(d1a, d2); // F1 is now in d1
    d2 = max(d1a, d2); // Swap to keep candidates for F2
    d1.xy = (d1.x < d1.y) ? d1.xy : d1.yx; // Swap if smaller
    d1.xz = (d1.x < d1.z) ? d1.xz : d1.zx; // F1 is in d1.x
    d1.yz = min(d1.yz, d2.yz); // F2 is now not in d2.yz
    d1.y = min(d1.y, d1.z); // nor in  d1.z
    d1.y = min(d1.y, d2.x); // F2 is in d1.y, we're done.
    return sqrt(d1.xy);
}
float benchNoise(vec2 P)
{
    float res = 0.0;
    float time = 0.0;
    for (float i = 0; i < 60; i++)
    {
        res = cellular(vec3(P + time, i + 0.4)).x + 
              snoise(vec3(P + time, i + 0.8)) + 
              cellular2D(P + time).x;
        time += 0.5;
    }
    return res;
}
vec3 noisev4DTexture(vec2 coord) {
    float time = 1.0;
    vec2 floorCoord = floor(coord);
    vec2 fractCoord = coord - floorCoord;
    float noiseValue00 = benchNoise(floorCoord + time);
    float noiseValue01 = benchNoise(floorCoord + vec2(0.4, 0.2) + time);
    float noiseValue11 = benchNoise(floorCoord + cellular2D(vec2(3)).x + time);
    noiseValue01 += noiseValue11;
    float noiseValue = mix(noiseValue00, noiseValue01, fractCoord.x);

    return vec3(noiseValue);
}

vec3 brickTexture(vec2 coord) {
    float brickWidth = 0.7;
    float brickHeight = 0.5;
    float mortarWidth = 0.3;

    vec2 brickCoord = fract(coord / vec2(brickWidth + mortarWidth, brickHeight + mortarWidth));

    bool isBrick = true;
    bool isMortar = true;
    vec2 brickCoordMin = floor(brickCoord * vec2(1.0 / brickWidth, 1.0 / brickHeight)) * vec2(brickWidth, brickHeight);
    vec2 brickCoordMax = brickCoordMin + vec2(brickWidth, brickHeight);
    vec2 fractCoord = brickCoord - brickCoordMin;
    vec3 brickColor00 = mix(vec3(0.3922, 0.1922, 0.03922), vec3(0.3216, 0.3137, 0.3098), float(isMortar)) * float(isBrick);
    vec3 brickColor01 = mix(vec3(0.5216, 0.502, 0.502), vec3(0.4078, 0.2882, 0.03804), float(isMortar) - 0.1) * float(isBrick);
    vec3 brickColor10 = mix(vec3(0.3904, 0.1804, 0.03804), vec3(0.4078, 0.3961, 0.3922), float(isMortar)) * float(isBrick);
    vec3 brickColor11 = mix(vec3(0.3843, 0.3843, 0.3843), vec3(0.5882, 0.15529, 0.05529), float(isMortar)) * float(isBrick);
    vec3 brickColor0 = mix(brickColor00, brickColor01, fractCoord.y);
    vec3 brickColor1 = mix(brickColor10, brickColor11, fractCoord.y);
    vec3 brickColor = mix(brickColor0, brickColor1, fractCoord.x);

    return brickColor;
}
vec3 metalTexture(vec2 coord, vec3 eyeDir) {
    float metalWidth = 0.7;
    float metalHeight = 0.5;
    float metalMortarWidth = 0.195;

    vec2 metalCoord = fract(coord / vec2(metalWidth + metalMortarWidth, metalHeight + metalMortarWidth));

    vec2 metalCoordMin = floor(metalCoord * vec2(0.2 / metalWidth, 0.9 / metalHeight)) * vec2(metalWidth, metalHeight);

    vec2 fractCoord = metalCoord - metalCoordMin;
    float metalNoise = noisev4DTexture(metalCoord).r;
    vec3 metalColor = mix(vec3(0.53804, 0.53647, 0.53647), vec3(0.6298, 0.63137, 0.63059), metalNoise);

    float steelNoise = noisev4DTexture(metalCoord).r;
    vec3 steelColor = mix(vec3(0.233, 0.233, 0.233), vec3(0.2015, 0.2015, 0.2015), steelNoise);
    metalColor = mix(metalColor, steelColor, 0.7);

    vec3 metalColor00 = metalColor;
    vec3 metalColor01 = metalColor;
    vec3 metalColor10 = metalColor;
    vec3 metalColor11 = metalColor;
    vec3 metalColor0 = mix(metalColor00, metalColor01, fractCoord.y);
    vec3 metalColor1 = mix(metalColor10, metalColor11, fractCoord.y);
    vec3 metalFinalColor = mix(metalColor0, metalColor1, fractCoord.x);

    vec3 normal = normalize(vNormal);
    vec3 reflectDir = reflect(-eyeDir, normal);
    for (int i = 0; i < 31; i++) {
        float specularStrength = pow(max(dot(reflectDir, normalize(vLightDir[i])), 0.0), 8196.0);
        vec3 specularColor = vec3(0.33, 0.32, 0.32);
        vec3 reflectionColor = specularStrength * specularColor;
        metalFinalColor = mix(metalFinalColor, reflectionColor, 0.6);
    }

    return metalFinalColor;
}
vec2 waterDistortion(vec2 uv, float timeFactor) {
    float distortionScale = 0.1;
    float distortionSpeed = 1.8;
    float distortionAmount = 0.5 * snoise(vec3(uv * 10.0, timeFactor * distortionSpeed));
    return uv + distortionAmount * distortionScale * vec2(cos(timeFactor), sin(timeFactor));
}

void main() {
    vec2 uv = gl_FragCoord.xy / vec2(1280.0, 1024.0);
    float time = mod(gl_FragCoord.x + gl_FragCoord.y + gl_FragCoord.z + gl_FragCoord.w, 289.0);
    float timeFactor = 0.5 + 0.5 * sin(time * 0.1);

    uv = waterDistortion(uv, timeFactor);
    vec3 color = vec3(0.52, 0.25, 0.015);
    vec3 finalColor = vec3(0.0);
    vec2 mirroredCoord = mod(vTextureCoord, 1.0);
    vec3 combinedDirection = vec3(0.00);
    for (int i = 0; i < 31; i++)
    {
        combinedDirection += vLightDir[i];
    }
    vec3 noiseColor = noisev4DTexture(uv);
    vec3 brickColor = brickTexture(uv);
    vec3 metalColor = metalTexture(uv, combinedDirection);
    vec3 normal = normalize(vNormal);
    vec3 lightDir = normalize(lightDirection);
    
    float diffuse = max(dot(normal, lightDir), 0.0);
    const int numReflections = 8;
    vec3 reflections[numReflections];
    for (int i = 0; i < numReflections; i++)
    {
        vec3 reflectionDir = reflect(-lightDir, normal);
        reflections[i] = reflectionDir;
        lightDir = normalize(reflect(lightDir, reflectionDir));
    }
    const float specularPower = 10.0;
    vec3 speculars[numReflections];
    for (int i = 0; i < numReflections; i++)
    {
        vec3 viewDir = normalize(-gl_FragCoord.xyz);
        vec3 reflectionDir = reflections[i];
        float specularTerm = pow(max(dot(reflectionDir, viewDir), 0.0), specularPower*specularPower);
        speculars[i] = specularTerm * vec3(0.9, 0.45, 0.01);
    }
    float fresnel = clamp(1.0 - dot(normalize(gl_FragCoord.xyz), normal), 0.0, 1.0);
    vec3 fresnelColor = vec3(0.02, 0.1, 0.6) * fresnel;
    vec3 dcolor = vec3(0.2) + vec3(0.8) * diffuse + speculars[0] + speculars[1] + speculars[2] + speculars[3] + speculars[4] + speculars[5] + speculars[6] + fresnelColor;
    metalColor += metalColor * 2.0;
    metalColor += vec3(0.3529, 0.3294, 0.3294) * noiseColor.g;
    metalColor = mix(metalColor, vec3(0.2941, 0.2941, 0.2941), 0.395);
    finalColor = mix(metalColor, noiseColor, 0.48);
    finalColor *= mix(brickColor, dcolor, 1) + (brickColor - vec3(0.25, 0.25, 0.25));
    finalColor *= mix(vec3(0.75294, 0.37294, 0.07294), metalColor, noiseColor.r * 0.7);
    gl_FragColor = vec4(finalColor, 1.0);
}

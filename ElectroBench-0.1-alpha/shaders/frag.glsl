#version 120
varying vec3 vNormal;
varying vec3 vPosition;

vec4 mod289(vec4 x) {
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

float mod289(float x) {
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 permute(vec4 x) {
    return mod289(((x * 34.0) + 10.0) * x);
}

float permute(float x) {
    return mod289(((x * 34.0) + 10.0) * x);
}

vec4 taylorInvSqrt(vec4 r) {
    return 1.79284291400159 - 0.85373472095314 * r;
}

float taylorInvSqrt(float r) {
    return 1.79284291400159 - 0.85373472095314 * r;
}

vec4 grad4(float j, vec4 ip) {
    const vec4 ones = vec4(1.0, 1.0, 1.0, -1.0);
    vec4 p, s;

    p.xyz = floor(fract(vec3(j) * ip.xyz) * 7.0) * ip.z - 1.0;
    p.w = 1.5 - dot(abs(p.xyz), ones.xyz);
    s = vec4(lessThan(p, vec4(0.0)));
    p.xyz = p.xyz + (s.xyz * 2.0 - 1.0) * s.www;

    return p;
}

#define F4 0.309016994374947451
float snoise(vec3 v) {
    const vec2 C = vec2(1.0 / 6.0, 1.0 / 3.0);
    const vec4 D = vec4(0.0, 0.5, 1.0, 2.0);

    vec3 i = floor(v + dot(v, C.yyy));
    vec3 x0 = v - i + dot(i, C.xxx);
    vec3 g = step(x0.yzx, x0.xyz);
    vec3 l = 1.0 - g;
    vec3 i1 = min(g.xyz, l.zxy);
    vec3 i2 = max(g.xyz, l.zxy);

    vec3 x1 = x0 - i1 + C.xxx;
    vec3 x2 = x0 - i2 + C.yyy;
    vec3 x3 = x0 - D.yyy;

    i = mod(i, 289.0);
    vec4 p = permute(permute(permute(i.z + vec4(0.0, i1.z, i2.z, 1.0))
                                 + i.y + vec4(0.0, i1.y, i2.y, 1.0))
                         + i.x + vec4(0.0, i1.x, i2.x, 1.0));

    float n_ = 1.0 / 7.0;
    vec3 ns = n_ * D.wyz - D.xzx;

    vec4 j = p - 49.0 * floor(p * ns.z * ns.z);
    vec4 x_ = floor(j * ns.z);
    vec4 y_ = floor(j - 7.0 * x_);
    vec4 x = x_ * ns.x + ns.yyyy;
    vec4 y = y_ * ns.x + ns.yyyy;
    vec4 h = 1.0 - abs(x) - abs(y);

    vec4 b0 = vec4(x.xy, y.xy);
    vec4 b1 = vec4(x.zw, y.zw);

    vec4 s0 = floor(b0) * 2.0 + 1.0;
    vec4 s1 = floor(b1) * 2.0 + 1.0;
    vec4 sh = -step(h, vec4(0.0));

    vec4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
    vec4 a1 = b1.xzyw + s1.xzyw * sh.zzww;

    vec3 p0 = vec3(a0.xy, h.x);
    vec3 p1 = vec3(a0.zw, h.y);
    vec3 p2 = vec3(a1.xy, h.z);
    vec3 p3 = vec3(a1.zw, h.w);

    vec4 norm = taylorInvSqrt(vec4(dot(p0, p0), dot(p1, p1), dot(p2, p2), dot(p3, p3)));
    p0 *= norm.x;
    p1 *= norm.y;
    p2 *= norm.z;
    p3 *= norm.w;

    vec4 m = max(0.6 - vec4(dot(x0, x0), dot(x1, x1), dot(x2, x2), dot(x3, x3)), 0.0);
    m = m * m;
    return 48.0 * dot(m * m, vec4(dot(p0, x0), dot(p1, x1), dot(p2, x2), dot(p3, x3)));
}
float fbm(vec3 v) {
    float value = 0.01;
    float amplitude = 0.5;
    vec3 p = v;
    for (int i = 0; i < 500; i++) {
        value += amplitude * snoise(p);
        p *= 2.0;
        amplitude *= 0.3;
    }
    return value;
}

vec3 proceduralTexture(vec2 uv, float timeFactor) {
    uv = fract(uv);
    if (mod(floor(uv.x * 2.0), 2.0) == 1.0)
        uv.x = 1.0 - uv.x;
    if (mod(floor(uv.y * 2.0), 2.0) == 1.0)
        uv.y = 1.0 - uv.y;
    vec3 color1 = vec3(1.0, 0.51, 0.02);
    vec3 color2 = vec3(0.64, 0.64, 0.64);
    vec3 color3 = vec3(0.74, 0.72, 0.72);
    vec3 color4 = vec3(0.33, 0.00, 1.00);
    vec3 textureColor;

    // Use Fractional Brownian Motion (FBM) for more complex noise
    float fbmValue1 = fbm(vec3(uv * 10.0, timeFactor * 0.5));
    float fbmValue2 = fbm(vec3(uv * 10.0, timeFactor));
    float fbmValue3 = fbm(vec3(uv * 10.0, timeFactor * 1.5));

    float noiseValue1 = 0.0;
    for (int i = 0; i < 20; i++) {
        float t = timeFactor * float(i) * 0.1;
        noiseValue1 += snoise(vec3(uv * 10.0, t)) + fbmValue1;
    }
    noiseValue1 /= 5.0;

    float noiseValue2 = 0.0;
    for (int i = 0; i < 20; i++) {
        float t = timeFactor * float(i) * 0.2;
        noiseValue2 += snoise(vec3(uv * 10.0, t)) + fbmValue2;
    }
    noiseValue2 /= 5.0;

    float noiseValue3 = 0.0;
    for (int i = 0; i < 20; i++) {
        float t = timeFactor * float(i) * 0.3;
        noiseValue3 += snoise(vec3(uv * 10.0, t)) + fbmValue3;
    }
    noiseValue3 /= 5.0;

    float mixAmount1 = mix(noiseValue1, noiseValue2, timeFactor);
    float mixAmount2 = mix(noiseValue3, noiseValue2, timeFactor);

    textureColor = mix(mix(color1, color2, mixAmount1), color3, mixAmount1);
    textureColor += mix(textureColor, color4, mixAmount2);

    return textureColor;
}
vec3 pulsatingColor(float timeFactor) {
    float pulsationSpeed = 1.5;
    float pulsationIntensity = 0.1;
    vec3 pulsatingColor = vec3(0.69, 0.69, 0.69);  
    return pulsatingColor * (0.6 + pulsationIntensity * sin(timeFactor * pulsationSpeed));
}
vec2 waterDistortion(vec2 uv, float timeFactor) {
    float distortionScale = 0.1;
    float distortionSpeed = 1.8;
    float distortionAmount = 0.5 * fbm(vec3(uv * 10.0, timeFactor * distortionSpeed));
    return uv + distortionAmount * distortionScale * vec2(cos(timeFactor), sin(timeFactor));
}

void main() {
    vec2 uv = gl_FragCoord.xy / vec2(7850.0, 4320.0);
    float time = mod(gl_FragCoord.x + gl_FragCoord.y + gl_FragCoord.z + gl_FragCoord.w, 289.0);
    float timeFactor = 0.5 + 0.5 * sin(time * 0.1);

    uv = waterDistortion(uv, timeFactor);

    vec3 textureColor = proceduralTexture(uv, timeFactor);
    vec3 lightDir1 = normalize(vec3(0.52898938, 0.6386788, 0.35623453));
    vec3 lightDir2 = normalize(vec3(-0.85446, 0.98786672, -0.3375325));
    vec3 lightDir3 = normalize(vec3(0.0706325, 0.25283, 0.2452452));
    vec3 lightDir4 = normalize(vec3(-0.26558, 0.11365967, -0.86));
    vec3 lightDir5 = normalize(vec3(0.0706, 0.120542057272, 0.0706));
    vec3 lightDir6 = normalize(vec3(-0.07474, 0.11398878737, -0.0706));
    vec3 lightDir7 = normalize(vec3(0.098748, 0.796, 0.0706));
    vec3 lightDir8 = normalize(vec3(-0.877878, -0.1337, -0.097887706));
    vec3 lightDir9 = normalize(vec3(0.7867789, 0.98876, 0.070998678678));
    vec3 lightDir10 = normalize(vec3(-0.86778, 0.768678, -0.070678387));
    vec3 viewDir = normalize(-vPosition);
    vec3 viewDir2 = normalize(-vPosition);
    float lambertian1 = max(dot(vNormal, lightDir1), 0.0);
    vec3 diffuse1 = vec3(0.74, 0.72, 0.72);
    vec3 lighting1 = diffuse1 * lambertian1;
    float lambertian2 = max(dot(vNormal, lightDir2), 0.0);
    vec3 diffuse2 = vec3(0.46, 0.30, 0.90);
    vec3 lighting2 = diffuse2 * lambertian2;
    float lambertian3 = max(dot(vNormal, lightDir3), 0.0);
    vec3 diffuse3 = vec3(0.09, 0.02, 0.26);
    vec3 lighting3 = diffuse3 * lambertian3;
    float lambertian4 = max(dot(vNormal, lightDir4), 0.0);
    vec3 diffuse4 = vec3(1.00, 0.43, 0.00);
    vec3 lighting4 = diffuse4 * lambertian4;
    float lambertian5 = max(dot(vNormal, lightDir5), 0.0);
    vec3 diffuse5 = vec3(0.08, 1.00, 0.00);
    vec3 lighting5 = diffuse5 * lambertian5;
    float lambertian6 = max(dot(vNormal, lightDir6), 0.0);
    vec3 diffuse6 = vec3(0.24, 0.24, 0.24);
    vec3 lighting6 = diffuse6 * lambertian6;
    float lambertian7 = max(dot(vNormal, lightDir7), 0.0);
    vec3 diffuse7 = vec3(0.00, 0.84, 1.00);
    vec3 lighting7 = diffuse7 * lambertian7;
    float lambertian8 = max(dot(vNormal, lightDir8), 0.0);
    vec3 diffuse8 = vec3(0.59, 0.59, 0.58);
    vec3 lighting8 = diffuse8 * lambertian8;
    float lambertian9 = max(dot(vNormal, lightDir9), 0.0);
    vec3 diffuse9 = vec3(0.77, 0.67, 0.61);
    vec3 lighting9 = diffuse9 * lambertian9;
    float lambertian10 = max(dot(vNormal, lightDir10), 0.0);
    vec3 diffuse10 = vec3(0.31, 0.31, 0.31);
    vec3 lighting10 = diffuse10 * lambertian10;
    vec3 lighting = lighting1 + lighting2 + lighting3
     + lighting4 + lighting5
     + lighting6 + lighting7
     + lighting8 + lighting9 + lighting10;
    vec3 specular = vec3(1.00, 0.41, 0.00);
    float shininess = 2048.0;
    vec3 halfwayDir1 = normalize(lightDir1 + lightDir3 + lightDir5 + lightDir7 + lightDir9 + viewDir);
    vec3 halfwayDir2 = normalize(lightDir2 + lightDir4 + lightDir6 + lightDir8 + lightDir10 + viewDir2);
    float intensitySpec1 = max(dot(vNormal, halfwayDir1), 0.0);
    float intensitySpec2 = max(dot(vNormal, halfwayDir2), 0.0);
    lighting += specular * (pow(intensitySpec1, shininess) + pow(intensitySpec2, shininess));
    float toonLevels = 16.0;
    float toonIntensity = floor(max(max(intensitySpec1, intensitySpec2), 0.0) * toonLevels) / toonLevels;
    vec3 toonColor = vec3(0.8, 0.8, 0.8);
    vec3 finalColor = mix(toonColor, lighting, toonIntensity);

    vec3 bloom = vec3(0.0);
    for (int i = 0; i < 5; i++) {
        float bloomAmount = 0.5 * fbm(vec3(uv * 5.0, time * 0.2 + float(i) * 0.3));
        bloom += bloomAmount * lighting;
    }
    finalColor *= pulsatingColor(timeFactor);
    finalColor += bloom;
    finalColor += textureColor;
    float ao = 1.0 - fbm(vec3(uv * 5.0, time * 0.1));
    finalColor += ao;
    float shadowNoise = fbm(vec3(uv * 190.0, 4.0));
    vec3 shadowColor = vec3(0.0, 0.0, 0.0);
    float shadowIntensity = 0.7 + shadowNoise * 0.8;
    finalColor *= mix(lighting, shadowColor, shadowIntensity);
    float vignetteStrength = 0.3;
    float vignetteSize = 0.7;
    float vignette = 1.0 - length(uv - vec2(0.5)) * vignetteSize;
    finalColor *= mix(1.0, vignetteStrength, vignette);
    gl_FragColor = vec4(finalColor, 1.0);
}

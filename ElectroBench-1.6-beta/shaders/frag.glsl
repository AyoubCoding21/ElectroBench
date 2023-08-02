#version 120
varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vViewDir;

vec4 mod289(vec4 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0; 
}

float mod289(float x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 permute(vec4 x) {
     return mod289(((x*34.0)+10.0)*x);
}

float permute(float x) {
     return mod289(((x*34.0)+10.0)*x);
}

vec4 taylorInvSqrt(vec4 r)
{
  return 1.79284291400159 - 0.85373472095314 * r;
}

float taylorInvSqrt(float r)
{
  return 1.79284291400159 - 0.85373472095314 * r;
}

vec4 grad4(float j, vec4 ip)
{
  const vec4 ones = vec4(1.0, 1.0, 1.0, -1.0);
  vec4 p,s;

  p.xyz = floor(fract(vec3(j) * ip.xyz) * 7.0) * ip.z - 1.0;
  p.w = 1.5 - dot(abs(p.xyz), ones.xyz);
  s = vec4(lessThan(p, vec4(0.0)));
  p.xyz = p.xyz + (s.xyz*2.0 - 1.0) * s.www; 

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
    vec4 p = permute(permute(permute(
                i.z + vec4(0.0, i1.z, i2.z, 1.0))
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
    return 42.0 * dot(m*m, vec4(dot(p0, x0), dot(p1, x1), dot(p2, x2), dot(p3, x3)));
}

// Procedural texture function
vec3 proceduralTexture(vec2 uv) {
    vec3 color1 = vec3(1.0, 0.215, 0.0);
    vec3 color2 = vec3(0.9, 0.2, 0.05);
    float noiseValue = snoise(vec3(uv * 10.0, 0.0));
    return mix(color1, color2, noiseValue);
}

void main()
{
    vec2 uv = gl_FragCoord.xy / vec2(7680.0, 4320.0);
    vec3 textureColor = proceduralTexture(uv);

    vec3 lightPositions[10] = vec3[10](
        vec3(1.0, 2.0, 3.0),
        vec3(-2.0, 1.0, 4.0),
        vec3(3.0, 1.0, -2.0),
        vec3(-4.0, 1.0, -3.0),
        vec3(2.0, 3.0, 1.0),
	    vec3(snoise(vec3(.0548587)), 3.5878, 3.558),
	    vec3(2.265565, 6.5558, 1.55885),
	    vec3(2.5878, 5.89, 6.8),
	    vec3(3.688, 2.414, 9.55),
	    vec3(2.645788, snoise(vec3(2.414)), snoise(vec3(pow(9.556895, dot(.98845, .6898)))))
    );

    vec3 lightColors[10] = vec3[10](
        vec3(1.0, 0.0, 0.0),
        vec3(0.0, 1.0, 0.0),
        vec3(0.0, 0.0, 1.0),
        vec3(1.0, 1.0, 0.0),
        vec3(1.0, 0.0, 1.0),
    	vec3(snoise(vec3(.0548587)), 3.5878, 3.558),
	    vec3(2.265565, 6.5558, 1.55885),
	    vec3(2.985, 8.89, 1.8),
	    vec3(3.688, 2.414, 9.55),
	    vec3(2.645788, snoise(vec3(2.414)), snoise(vec3(pow(9.556895, dot(.98845, .6898)))))
    );

    vec3 totalLighting = vec3(0.0);
    for (int i = 0; i < 10; i++) {
        vec3 lightDir = normalize(lightPositions[i] - vPosition);
        vec3 halfwayDir = normalize(lightDir + vViewDir);
        float intensity = max(dot(vNormal, halfwayDir), 0.0);
        vec3 diffuse = lightColors[i];
        vec3 specular = vec3(1.0);
        float shininess = 32.0;
        vec3 lighting = diffuse * intensity + specular * pow(intensity, shininess);
        totalLighting += lighting;
    }

    float rimStrength = 0.5;
    float rimThreshold = 0.2;
    float rim = rimStrength * max(0.0, 1.0 - dot(vNormal, vViewDir));
    vec3 rimColor = vec3(1.0, 0.2824, 0.0);
    vec3 rimLighting = rim * rimColor;

    vec3 shadowColor = vec3(0.0111845758, 0.123456789, 0.8784523523562549256542642);
    float shadowIntensity = snoise(vec3(0.4225598598795785297582975829758298529782975285761469252975259285428428542828542844));
    vec3 finalColor = mix((totalLighting + rimLighting) * textureColor, shadowColor, shadowIntensity);

    gl_FragColor = vec4(finalColor, 1.0);
}


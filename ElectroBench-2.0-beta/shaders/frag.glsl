#version 120
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec2 vTexCoord;

vec3 mod289(vec3 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}
vec2 mod289(vec2 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}
vec3 permute(vec3 x) {
  return mod289(((x*34.0)+10.0)*x);
}
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
#define F4 0.309016994374947451

float random(vec4 v)
{
  const vec4  C = vec4(0.138196601125011, 0.276393202250021, 0.414589803375032, -0.447213595499958); 
  vec4 i = floor(v + dot(v, vec4(F4)));
  vec4 x0 = v - i + dot(i, C.xxxx);
  vec4 i0;
  vec3 isX = step(x0.yzw, x0.xxx);
  vec3 isYZ = step(x0.zww, x0.yyz);
  i0.x = isX.x + isX.y + isX.z;
  i0.yzw = 1.0 - isX;
  i0.y += isYZ.x + isYZ.y;
  i0.zw += 1.0 - isYZ.xy;
  i0.z += isYZ.z;
  i0.w += 1.0 - isYZ.z;
  vec4 i3 = clamp(i0, 0.0, 1.0);
  vec4 i2 = clamp(i0-1.0, 0.0, 1.0);
  vec4 i1 = clamp(i0-2.0, 0.0, 1.0);
  vec4 x1 = x0 - i1 + C.xxxx;
  vec4 x2 = x0 - i2 + C.yyyy;
  vec4 x3 = x0 - i3 + C.zzzz;
  vec4 x4 = x0 + C.wwww;
  i = mod289(i); 
  float j0 = permute(permute(permute(permute(i.w) + i.z) + i.y) + i.x);
  vec4 j1 = permute(permute(permute(permute(
             i.w + vec4(i1.w, i2.w, i3.w, 1.0))
           + i.z + vec4(i1.z, i2.z, i3.z, 1.0))
           + i.y + vec4(i1.y, i2.y, i3.y, 1.0))
           + i.x + vec4(i1.x, i2.x, i3.x, 1.0));
  vec4 ip = vec4(1.0/294.0, 1.0/49.0, 1.0/7.0, 0.0) ;
  vec4 p0 = grad4(j0, ip);
  vec4 p1 = grad4(j1.x, ip);
  vec4 p2 = grad4(j1.y, ip);
  vec4 p3 = grad4(j1.z, ip);
  vec4 p4 = grad4(j1.w, ip);
  vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;
  p4 *= taylorInvSqrt(dot(p4, p4));
  vec3 m0 = max(0.6 - vec3(dot(x0,x0), dot(x1,x1), dot(x2,x2)), 0.0);
  vec2 m1 = max(0.6 - vec2(dot(x3,x3), dot(x4,x4)), 0.0);
  m0 = m0 * m0;
  m1 = m1 * m1;
  return 49.0 * (dot(m0*m0, vec3(dot(p0, x0), dot(p1, x1), dot(p2, x2)))
               + dot(m1*m1, vec2(dot(p3, x3), dot(p4, x4))));
}
float snoise(vec2 v)
{
  const vec4 C = vec4(0.211324865405187, 
                      0.366025403784439, 
                     -0.577350269189626,
                      0.024390243902439); 
  vec2 i  = floor(v + dot(v, C.yy));
  vec2 x0 = v - i + dot(i, C.xx);
  vec2 i1;
  i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;
  i = mod289(i); 
  vec3 p = permute(permute(i.y + vec3(0.0, i1.y, 1.0))
		+ i.x + vec3(0.0, i1.x, 1.0));

  vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
  m = m * m;
  m = m * m;
  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = floor(x + 0.5);
  vec3 a0 = x - ox;
  m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
  vec3 g;
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}
vec2 fade(vec2 t) {
  return t*t*t*(t*(t*6.0-15.0)+10.0);
}

float rand(vec2 P)
{
  vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
  vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
  Pi = mod289(Pi);
  vec4 ix = Pi.xzxz;
  vec4 iy = Pi.yyww;
  vec4 fx = Pf.xzxz;
  vec4 fy = Pf.yyww;

  vec4 i = permute(permute(ix) + iy);

  vec4 gx = fract(i * (1.0 / 41.0)) * 2.0 - 1.0 ;
  vec4 gy = abs(gx) - 0.5 ;
  vec4 tx = floor(gx + 0.5);
  gx = gx - tx;

  vec2 g00 = vec2(gx.x,gy.x);
  vec2 g10 = vec2(gx.y,gy.y);
  vec2 g01 = vec2(gx.z,gy.z);
  vec2 g11 = vec2(gx.w,gy.w);

  vec4 norm = taylorInvSqrt(vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11)));
  g00 *= norm.x;  
  g01 *= norm.y;  
  g10 *= norm.z;  
  g11 *= norm.w;  

  float n00 = dot(g00, vec2(fx.x, fy.x));
  float n10 = dot(g10, vec2(fx.y, fy.y));
  float n01 = dot(g01, vec2(fx.z, fy.z));
  float n11 = dot(g11, vec2(fx.w, fy.w));

  vec2 fade_xy = fade(Pf.xy);
  vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
  float n_xy = mix(n_x.x, n_x.y, fade_xy.y);
  return 2.3 * n_xy;
}

float srnoise(vec2 pos, float rot) 
{
  pos.y += 0.001;
  vec2 uv = vec2(pos.x + pos.y*0.5, pos.y);
  vec2 i0 = floor(uv);
  vec2 f0 = fract(uv);
  vec2 i1 = (f0.x > f0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  vec2 p0 = vec2(i0.x - i0.y * 0.5, i0.y);
  vec2 p1 = vec2(p0.x + i1.x - i1.y * 0.5, p0.y + i1.y);
  vec2 p2 = vec2(p0.x + 0.5, p0.y + 1.0);
  i1 = i0 + i1;
  vec2 i2 = i0 + vec2(1.0, 1.0);
  vec2 d0 = pos - p0;
  vec2 d1 = pos - p1;
  vec2 d2 = pos - p2;
  vec3 x = vec3(p0.x, p1.x, p2.x);
  vec3 y = vec3(p0.y, p1.y, p2.y);
  vec3 iuw = x + 0.5 * y;
  vec3 ivw = y;
  iuw = mod289(iuw);
  ivw = mod289(ivw);
  vec2 g0 = rgrad2(vec2(iuw.x, ivw.x), rot);
  vec2 g1 = rgrad2(vec2(iuw.y, ivw.y), rot);
  vec2 g2 = rgrad2(vec2(iuw.z, ivw.z), rot);
  vec3 w = vec3(dot(g0, d0), dot(g1, d1), dot(g2, d2));
  vec3 t = 0.8 - vec3(dot(d0, d0), dot(d1, d1), dot(d2, d2));
  t = max(t, 0.0);
  vec3 t2 = t * t;
  vec3 t4 = t2 * t2;
  float n = dot(t4, w);
  return 11.0*n;
}

float rsnoise(vec2 pos) {
  return srnoise(pos, 0.0);
}

vec3 brickTexture(vec2 coord) {
    float brickWidth = 0.2;
    float brickHeight = 0.1;
    float mortarWidth = 0.01;
    
    vec2 brickCoord = fract(coord / vec2(brickWidth + mortarWidth, brickHeight + mortarWidth));
    
    bool isBrick = brickCoord.x < brickWidth && brickCoord.y < brickHeight;
    bool isMortar = (brickCoord.x < brickWidth && brickCoord.y < mortarWidth) ||
                    (brickCoord.x < mortarWidth && brickCoord.y < brickHeight);
    
    return mix(vec3(0.8, 0.4, 0.00001), vec3(0.2, 0.2, 0.2), float(isMortar)) * float(isBrick);
}

vec3 noise4DTexture(vec2 coord) {
    float time = 1.0;
    float noiseValue = snoise(coord + time);
    return vec3(noiseValue);
}

vec3 fireTexture(vec2 coord) {
    float time = 1.0;
    float noiseValue = rsnoise(coord + time);
    vec3 fireColor = vec3(1.0, 0.295, 0.01);
    float speed = 2.0;
    float distortion = sin(coord.y * 40.0 + coord.x * speed) * 0.1;
    vec2 offseti = vec2(distortion, 0.0);
    vec2 texCoord = coord + offseti;
    vec3 fireEffect = fireColor * (1.0 - texCoord.y);
    return fireEffect * noiseValue;
}
vec3 blendTextures(vec3 texture1, vec3 texture2, float blendFactor) {
    return mix(texture1, texture2, blendFactor);
}
vec3 multiTexture1(vec2 coord) {
    float time = 1.0;
    float noiseValue = snoise(coord + time);
    return vec3(0.2, 0.2, 0.2) * noiseValue;
}

vec3 multiTexture2(vec2 coord) {
    float time = 1.0;
    float noiseValue = rand(coord + time);
    return vec3(0.8, 0.4, 0.00001) * noiseValue;
}

vec3 multiTexture3(vec2 coord) {
    return brickTexture(coord);
}

vec3 multiTexture4(vec2 coord) {
    return fireTexture(coord);
}

vec3 multiTexture5(vec2 coord) {
    float time = 1.0;
    float noiseValue = snoise(coord + time);
    return vec3(1.0, 0.295, 0.01) * (1.0 - coord.y) * noiseValue;
}
float gpuBenchmarkingEffect(vec2 coord) {
    float value = 0.0;
    float time = 0.0;

    for (int i = 0; i < 450; i++) {
        value += snoise(coord + time) + rand(coord + time) + rsnoise(coord + time);
        value += noise4DTexture(coord + time).x;
        time += 0.5;
    }

    return value / 5.0;
}
vec3 boisWallTexture(vec2 coord) {
    float frequency = 10.0;
    float amplitude = 0.1;
    vec2 noiseCoord = coord * frequency;
    float noiseValue = gpuBenchmarkingEffect(noiseCoord);
    float distortion = sin(noiseValue) * amplitude;
    
    vec2 woodCoord = fract(coord * frequency);
    woodCoord.x += distortion;
    
    return mix(vec3(0.2, 0.08, 0.00), vec3(0.6, 0.3, 0.1), woodCoord.x);
}
void main()
{
    vec3 lightColor = vec3(1.0, 0.3, 0.0);
    vec3 ambientColor = vec3(0.96, 0.25, 0.05);
    vec3 diffuseColor = vec3(0.8, 0.09, 0.00);
    vec3 specularColor = vec3(0.9, 0.13, 0.02);
    float shininess = 128.0;
    vec3 N = normalize(vNormal);
    vec3 E = normalize(-vViewDir);
    vec3 finalColor = ambientColor;
    vec3 fireColor = fireTexture(vTexCoord);
    float d = length(vTexCoord - vec2(0.5));
    vec3 colorOffset = vec3(d * 1.5, d * 0.5, d * 2.0);
    finalColor += colorOffset;
    float redOffset = sin(vTexCoord.x * 12.0) * 0.6;
    float greenOffset = cos(vTexCoord.y * 5.0) * 0.8;
    float blueOffset = sin(vTexCoord.x * vTexCoord.y * 50.0) * 0.1;
    finalColor += vec3(redOffset, greenOffset, blueOffset);
    finalColor = mix(finalColor, vec3(0.6), 0.2);
    finalColor = pow(finalColor, vec3(0.2, 0.8, 1.0));
    float blendFactor1 = 0.5;
    float blendFactor2 = 0.6;
    float blendFactor3 = 0.2;
    float blendFactor4 = 0.3;
    float blendFactor5 = 0.4;
    vec3 texture1 = multiTexture1(vTexCoord);
    vec3 texture2 = multiTexture2(vTexCoord);
    vec3 texture3 = multiTexture3(vTexCoord);
    vec3 texture4 = multiTexture4(vTexCoord);
    vec3 texture5 = multiTexture5(vTexCoord);
    finalColor += blendTextures(finalColor, texture3, blendFactor2);
    finalColor += blendTextures(finalColor, texture4, blendFactor3);
    finalColor += blendTextures(finalColor, texture5, blendFactor4);
    vec3 noiseColor = noise4DTexture(vTexCoord);
    vec3 brickColor = brickTexture(vTexCoord);
    vec3 woodColor = boisWallTexture(vTexCoord);
    finalColor *= mix(mix(mix((noiseColor * 1.5), (brickColor * 1.5), 0.56), fireColor, 0.3), woodColor, 0.5);
    float shadowAmount = 0.00009041;
    float bias = 0.005;
    vec3 lightDir1 = normalize(vec3(random(vec4(pow(0.9687848, 0.5*-0.12+0.1-0.258))), 
                                      random(vec4(-0.5+0.6-0.1*0.9)), 
                                      random(vec4(0.3*.3+0.1-0.9/.256592572972*.55798597-.576597858757/.525652525)))); 
    float NdotL1 = max(dot(N, lightDir1), 0.0);
    vec3 shadowRayDir = normalize(-lightDir1);
    float NdotH1 = max(dot(N, normalize(lightDir1 + E)), 0.0);
    vec3 diffuse1 = diffuseColor * NdotL1;
    vec3 specular1 = specularColor * pow(NdotH1, shininess);
    finalColor += (1.0 - shadowAmount) * (diffuse1 + specular1) * lightColor;
    vec3 lightDir2 = normalize(vec3(random(vec4(0.5*-0.12+0.1+0.258)), 
                                      random(vec4(-0.5+0.6-0.1*0.9)), 
                                      random(vec4(0.3*.3+0.1-0.9/.256592572972*.55798597-.576597858757/.525652525)))); 
    float NdotL2 = max(dot(N, lightDir2), 0.0);
    shadowRayDir += normalize(-lightDir2);
    float NdotH2 = max(dot(N, normalize(lightDir2 + E)), 0.0);
    vec3 diffuse2 = diffuseColor * NdotL2;
    vec3 specular2 = specularColor * pow(NdotH2, shininess);
    finalColor += diffuse2 + specular2;
    vec3 lightDir3 = normalize(vec3(
    random(vec4(0.985423532/.2363-.5236552*0.165252/.65256562+.2693653)), 
    random(vec4(0.26526526*0.165252/.65256562+.2693653)), 
    random(vec4(0.26526526*0.165252/.65256562+.2693653))));
    float NdotL3 = max(dot(N, lightDir3), 0.0);
    shadowRayDir += normalize(-lightDir3); 
    float NdotH3 = max(dot(N, normalize(lightDir3 + E)), 0.0);
    vec3 diffuse3 = lightColor * diffuseColor * NdotL3;
    vec3 specular3 = lightColor * specularColor * pow(NdotH3, shininess);
    finalColor += diffuse3 + specular3;
    vec3 lightDir4 = normalize(vec3(
    random(vec4(permute(permute(taylorInvSqrt(0.15282/0.2*0.3-0.4+0.1/0.565856896))))), 
    random(vec4(0.24534245259785297452/.56252546297524-.55287587*.25824948987+.5885858*0.6/0.5)), 
    random(vec4(0.9-0.52582/.66))));
    float NdotL4 = max(dot(N, lightDir4), 0.0);
    shadowRayDir += normalize(-lightDir4); 
    float NdotH4 = max(dot(N, normalize(lightDir4 + E)), 0.0);
    vec3 diffuse4 = lightColor * diffuseColor * NdotL4;
    vec3 specular4 = lightColor * specularColor * pow(NdotH4, shininess);
    finalColor += diffuse4 + specular4;
    vec3 lightDir5 = normalize(vec3(
    random(vec4(-0.9*.523-0.8*.256652927582-.5795978578/.25298259)), 
    random(vec4(-0.7+0.6-0.7/0.69888*.23525642542426542542452/.8)), 
    random(vec4(-0.1+0.2*0.5/0.855+.558))));
    float NdotL5 = max(dot(N, lightDir5), 0.0);
    shadowRayDir += normalize(-lightDir5); 
    float NdotH5 = max(dot(N, normalize(lightDir5 + E)), 0.0);
    vec3 diffuse5 = lightColor * diffuseColor * NdotL5;
    vec3 specular5 = lightColor * specularColor * pow(NdotH5, shininess);
    finalColor += diffuse5 + specular5;
    vec3 lightDir6 = normalize(vec3(
    random(vec4(0.13242556/-0.12414121/.256565252545*.31652+.266586)), 
    random(vec4(.7421245245/.26525252+0.69256352-0.8273827527/0.26525265*0.9528552745652/0.565624625)), 
    random(vec4(-0.1+0.2*0.5/0.855+.5895857557/.5652652525492+.266279528-.959585985/0.7+0.6-0.7/0.698888))));    
    float NdotH6 = max(dot(N, normalize(lightDir6 + E)), 0.0);
    shadowRayDir += normalize(-lightDir6); 
    float NdotL6 = max(dot(N, lightDir6), 0.0);
    vec3 diffuse6 = lightColor * diffuseColor * NdotL6;
    vec3 specular6 = lightColor * specularColor * pow(NdotH6, shininess);
    finalColor += diffuse6 + specular6;
    vec3 lightDir7 = normalize(vec3(
      random(vec4(-0.12414121/.256565252545*.31652+.266586-.26525265*0.9528552745652/0.5656246256/0.321355286352625265256254528145786*.2652525252/.625262-.2652652)), 
      random(vec4(.524254265225+0.5242542+.125225252-0.7636636563/0.698888)), 
      random(vec4(-0.4223455252541+0.8543434534343*0.54254542452/0.965652872+.55154252454/.87523542/0.105224521+0.464616526-0.62652652+0.26254214/0.0142525258))));    
    float NdotH7 = max(dot(N, normalize(lightDir7 + E)), 0.0);
    shadowRayDir += normalize(-lightDir7); 
    float NdotL7 = max(dot(N, lightDir7), 0.0);
    vec3 diffuse7 = lightColor * diffuseColor * NdotL7;
    vec3 specular7 = lightColor * specularColor * pow(NdotH7, shininess);
    finalColor += diffuse7 + specular7;   
    vec3 lightDir8 = normalize(vec3(
    random(vec4(-0.9*.625652-0.825822*0.75363+0.66533-0.763635/0.698888+0.01042965292/.62556*0.4242542+0.265258562)), 
    random(vec4(.7245245725424+0.6586562582*.562566252+.22525252-0.7/0.698888)), 
    random(vec4(-0.15422+0.245254242*0.5215424254/0.852254525425+.558/0.7+0.6-0.7/0.698888))));    
    float NdotH8 = max(dot(N, normalize(lightDir8 + E)), 0.0);
    shadowRayDir += normalize(-lightDir8); 
    float NdotL8 = max(dot(N, lightDir8), 0.0);
    vec3 diffuse8 = lightColor * diffuseColor * NdotL8;
    vec3 specular8 = lightColor * specularColor * pow(NdotH8, shininess);
    finalColor += diffuse8 + specular8;
    vec3 lightDir9 = normalize(vec3(
      random(vec4(.2656226542545426525446245245265425245+.25656524278297278/.54242752652978*.287259282987-0.763635/0.698888+0.01042965292/.62556*0.4242542+0.265258562)), 
      random(vec4(.7245245725424+0.6586562582*.562566252+.22525252-0.7/0.698888)), 
      random(vec4(-0.15422+0.245254242*0.5215424254/0.852254525425+.558/0.7+0.6-0.7/0.698888))));    
    float NdotH9 = max(dot(N, normalize(lightDir9 + E)), 0.0);
    shadowRayDir += normalize(-lightDir9); 
    float NdotL9 = max(dot(N, lightDir9), 0.0);
    vec3 diffuse9 = lightColor * diffuseColor * NdotL9;
    vec3 specular9 = lightColor * specularColor * pow(NdotH9, shininess);
    finalColor += diffuse9 + specular9;
    vec3 lightDir10 = normalize(vec3(
      random(vec4(.4764577852985298527962578/.526826572657829785297*.26862829752958287+.2656226542545426525446245245265425245+.25656524278297278/.54242752652978*.287259282987-0.763635/0.698888+0.01042965292/.62556*0.4242542+0.265258562)), 
      random(vec4(.462572657267-.559/.7245245725424+0.6586562582*.562566252+.22525252-0.7982578*.5625626525/0.698888)), 
      random(vec4(-.562579629729678*.52652626823/.56828268667-0.15422+0.245254242*0.5215424254/0.852254525425+.558/0.7+0.6-0.7/0.698888))));    
    float NdotH10 = max(dot(N, normalize(lightDir10 + E)), 0.0);
    shadowRayDir += normalize(-lightDir10); 
    float NdotL10 = max(dot(N, lightDir10), 0.0);
    vec3 diffuse10 = lightColor * diffuseColor * NdotL10;
    vec3 specular10 = lightColor * specularColor * pow(NdotH10, shininess);
    finalColor += diffuse10 + specular10;
    vec3 lightDir11 = normalize(vec3(
      random(vec4(.6652257857*0.262665279585/0.5665215287-0.62652525495+0.92656226542545426525446245245265425245+.25656524278297278/.54242752652978*.287259282987-0.763635/0.698888+0.01042965292/.62556*0.4242542+0.265258562)), 
      random(vec4(-.5265242452654*.25626262+.6552688657*.568727852/.7245245725424+0.6586562582*.562566252+.22525252-0.7/0.698888)), 
      random(vec4(-.52527582872578*-.595982/.25687797827-0.15422+0.245254242*0.5215424254/0.2025662542945825492542942879287852578285*.2825555927578+0.852254525425+.558/0.7+0.6-0.7/0.698888))));    
    float NdotH11 = max(dot(N, normalize(lightDir11 + E)), 0.0);
    shadowRayDir += normalize(-lightDir11); 
    float NdotL11 = max(dot(N, lightDir11), 0.0);
    vec3 diffuse11 = lightColor * diffuseColor * NdotL11;
    vec3 specular11 = lightColor * specularColor * pow(NdotH11, shininess);
    finalColor += diffuse11 + specular11;
    vec3 lightDir12 = normalize(vec3(
      random(vec4(taylorInvSqrt(permute(mod289(-.262562792/.52782578269782987927/.2628627892987298727-.26876278297827892872-.6652257857*0.262665279585/0.5665215287-0.62652525495+0.92656226542545426525446245245265425245+.25656524278297278/.54242752652978*.287259282987-0.763635/0.698888+0.01042965292/.62556*0.4242542+0.265258562))))), 
      random(vec4(-.5265242452654*.25626262+.6552688657*.568727852/.7245245725424+0.6586562582*.562566252+.22525252-0.7/0.698888)), 
      random(vec4(-.52527582872578*-.595982/.25687797827-0.15422+0.245254242*0.5215424254/0.2025662542945825492542942879287852578285*.2825555927578+0.852254525425+.558/0.7+0.6-0.7/0.698888))));    
    float NdotH12 = max(dot(N, normalize(lightDir12 + E)), 0.0);
    shadowRayDir += normalize(-lightDir12); 
    float NdotL12 = max(dot(N, lightDir12), 0.0);
    vec3 diffuse12 = lightColor * diffuseColor * NdotL12;
    vec3 specular12 = lightColor * specularColor * pow(NdotH12, shininess);
    finalColor += diffuse12 + specular12;
    vec3 lightDir13 = normalize(vec3(
      random(vec4(.6652257857*.55872368678876768667866666666669+0.262665279585/0.5665215287-0.62652525495+0.92656226542545426525446245245265425245+.25656524278297278/.54242752652978*.287259282987-0.763635/0.698888+0.01042965292/.62556*0.4242542+0.265258562)), 
      random(vec4(-.9788855576858/.25278*.358576978-.5265242452654*.25626262+.6552688657*.568727852/.9287283-.245245725424+0.6586562582*.562566252+.22525252-0.7/0.698888)), 
      random(vec4(-.52527582872578*-.595982/.2527827821785278978267829829726782782978-.3287278/.2327952752723/.25687797827-0.15422+0.245254242*0.5215424254/0.2025662542945825492542942879287852578285*.2825555927578+0.852254525425+.558/0.7+0.6-0.7/0.698888))));    
    float NdotH13 = max(dot(N, normalize(lightDir13 + E)), 0.0);
    shadowRayDir += normalize(-lightDir13); 
    float NdotL13 = max(dot(N, lightDir13), 0.0);
    vec3 diffuse13= lightColor * diffuseColor * NdotL13;
    vec3 specular13 = lightColor * specularColor * pow(NdotH13, shininess);
    finalColor += diffuse13 + specular13;
    float NdotShadowRay = max(dot(N, shadowRayDir), 0.0);    
    if (NdotShadowRay > bias)
    {
        shadowAmount = 2.01;
    }
    finalColor -= vec3(shadowAmount);
    float glowIntensity = NdotL1 * 3.0;
    finalColor += vec3(1.0, 0.2, 0.0) * glowIntensity;
    gl_FragColor = vec4(finalColor, 1.0);
}

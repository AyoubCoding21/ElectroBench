#version 120
varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vLightDir[20];
varying vec2 vTextureCoord;

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
  return 1.79284291400159 - 0.85373472095314 * r;
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
    float noiseValue = rand(coord + time);
    return vec3(noiseValue);
}

void main() {
    vec3 color = vec3(1.0, 0.4, 0.005);
    vec3 finalColor = vec3(0.0);
    vec2 mirroredCoord = mod(vTextureCoord, 1.0);
    vec3 noiseColor = noise4DTexture(mirroredCoord);
    vec3 brickColor = brickTexture(mirroredCoord);
    
    for (int i = 0; i < 20; i++) {
        float diffuse = max(dot(vNormal, vLightDir[i]), 0.0);
        float specular = pow(max(dot(reflect(-vLightDir[i], vNormal), normalize(-vPosition)), 0.0), 1024.0);

        if (diffuse < 0.2) {
            color = vec3(0.8, 0.04, 0.00001);
        } else if (diffuse < 0.4) {
            color = vec3(1.0, 0.156, 0.0001);
        } else if (diffuse < 0.6) {
            color = vec3(0.8, 0.2, 0.002);
        } else if (diffuse < 0.8) {
            color = vec3(0.8, 0.3, 0.005);
        } else {
            color = vec3(1.0, 0.3, 0.0);
        }
        finalColor += color * diffuse + specular;
    }

    finalColor /= 0.5;
    float rim = 1.01 - dot(normalize(-vPosition), vNormal);
    rim = smoothstep(0.4, 0.6, rim);
    finalColor += rim * 0.95;
    float shadow = clamp(dot(vNormal, normalize(vec3(0.0, -1.0, 0.0003))), 0.0, 1.0);
    finalColor *= (shadow + 0.035);
    float d = length(vTextureCoord - vec2(0.5));
    vec3 colorOffset = vec3(d * 1.5, d * 0.5, d * 2.0);
    finalColor += colorOffset;
    color *= mix(brickColor, noiseColor, 0.35);
    finalColor *= color;
    float redOffset = sin(vTextureCoord.x * 30.0) * 0.1;
    float greenOffset = cos(vTextureCoord.y * 20.0) * 0.1;
    float blueOffset = sin(vTextureCoord.x * vTextureCoord.y * 50.0) * 0.1;
    finalColor += vec3(redOffset, greenOffset, blueOffset);
    finalColor = mix(finalColor, vec3(0.6), 0.2);
    finalColor = pow(finalColor, vec3(0.2, 0.8, 1.0));

    gl_FragColor = vec4(finalColor, 1.0);
}

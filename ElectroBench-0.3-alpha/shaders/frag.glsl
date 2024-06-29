#version 120

uniform sampler2D uTexture;

varying vec3 vNormal;
varying vec3 vPosition;
varying vec2 vTexCoord;

vec3 lightPosition[4] = vec3[4](vec3(1.0, 1.0, 1.0), vec3(-1.0, -1.0, -1.0), vec3(-2.2, -1.0, 1.0), vec3(0.7, 0.31, 0.2));
vec3 lightColor[4] = vec3[4](vec3(0.7, 0.31, 0.02), vec3(0.9, 0.41, 0.029), vec3(1.0, 0.6, 0.06), vec3(0.8, 0.5, 0.1));
vec3 ambientLight = vec3(0.1, 0.1, 0.1);

float uRoughness = 0.5;
float ambientOcclusionRadius = 0.1;
float reflectionRayLength = 10.0;
float PI = 3.14159265359;

vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return mod289((34.0 * x + 1.0) * x); }
// Modulo 7 without a division
vec3 mod7(vec3 x) {
  return x - floor(x * (1.0 / 7.0)) * 7.0;
}
vec2 rand(vec2 P) {
#define K 0.142857142857
#define Ko 0.428571428571
#define jitter 1.01
	vec2 Pi = mod289(floor(P));
	vec2 Pf = fract(P);
	vec3 oi = vec3(-1.0, 0.0, 1.0);
	vec3 of = vec3(-0.5, 0.5, 1.5);
	vec3 px = permute(Pi.x + oi);
	vec3 p = permute(px.x + Pi.y + oi);
	vec3 ox = fract(p * K) - Ko;
	vec3 oy = mod7(floor(p * K)) * K - Ko;
	vec3 dx = Pf.x + 0.5 + jitter * ox;
	vec3 dy = Pf.y - of + jitter * oy;
	vec3 d1 = dx * dx + dy * dy;
	p = permute(px.y + Pi.y + oi);
	ox = fract(p * K) - Ko;
	oy = mod7(floor(p * K)) * K - Ko;
	dx = Pf.x - 0.5 + jitter * ox;
	dy = Pf.y - of + jitter * oy;
	vec3 d2 = dx * dx + dy * dy;
	p = permute(px.z + Pi.y + oi);
	ox = fract(p * K) - Ko;
	oy = mod7(floor(p * K)) * K - Ko;
	dx = Pf.x - 1.5 + jitter * ox;
	dy = Pf.y - of + jitter * oy;
	vec3 d3 = dx * dx + dy * dy;
	vec3 d1a = min(d1, d2);
	d2 = max(d1, d2);
	d2 = min(d2, d3);
	d1 = min(d1a, d2);
	d2 = max(d1a, d2);
	d1.xy = (d1.x < d1.y) ? d1.xy : d1.yx;
	d1.xz = (d1.x < d1.z) ? d1.xz : d1.zx;
	d1.yz = min(d1.yz, d2.yz);
	d1.y = min(d1.y, d1.z);
	d1.y = min(d1.y, d2.x);
	return sqrt(d1.xy);
}

float DistributionGGX(vec3 N, vec3 H, float roughness) {
    float a = roughness * roughness;
    float a2 = a * a;
    float NdotH = max(dot(N, H), 0.0);
    float NdotH2 = NdotH * NdotH;

    float num = a2;
    float denom = (NdotH2 * (a2 - 1.0) + 1.0);
    denom = PI * denom * denom;

    return num / denom;
}

float GeometrySchlickGGX(float NdotV, float roughness) {
    float r = (roughness + 1.0);
    float k = (r * r) / 8.0;

    float num = NdotV;
    float denom = NdotV * (1.0 - k) + k;

    return num / denom;
}

float GeometrySmith(vec3 N, vec3 V, vec3 L, float roughness) {
    float NdotV = max(dot(N, V), 0.0);
    float NdotL = max(dot(N, L), 0.0);
    float ggx2 = GeometrySchlickGGX(NdotV, roughness);
    float ggx1 = GeometrySchlickGGX(NdotL, roughness);

    return ggx1 * ggx2;
}

vec3 fresnelSchlick(float cosTheta, vec3 F0) {
    return F0 + (1.0 - F0) * pow(1.0 - cosTheta, 5.0);
}

vec3 subsurfaceScattering(vec3 color, vec3 normal, vec3 lightDir, vec3 viewDir) {
    float NdotL = max(dot(normal, lightDir), 0.0);
    float NdotV = max(dot(normal, viewDir), 0.0);
    float distortion = 0.1;
    float scatteringAmount = 0.5;
    vec3 halfVector = normalize(lightDir + viewDir);
    float HdotN = max(dot(halfVector, normal), 0.0);
    float falloff = exp(-distortion / HdotN);
    return color * scatteringAmount * NdotL * falloff;
}

vec3 traceReflection(vec3 origin, vec3 direction) {
    vec3 color = vec3(0.0);
    vec3 currentPosition = origin;
    vec3 currentDirection = direction;
    float reflectivity = 0.8;

    for (int i = 0; i < 2048; i++) {
        vec4 sampleColor = texture2D(uTexture, currentPosition.st);
        color += sampleColor.rgb * pow(max(dot(currentDirection, normalize(vNormal)), 0.0), 1024.0);
        currentDirection = reflect(currentDirection, normalize(vNormal));
        currentPosition += currentDirection * reflectionRayLength;
        color *= reflectivity;
        reflectivity *= 0.95;
    }
    return color;
}

vec2 waterDistortion(vec2 uv, float timeFactor) {
    float distortionScale = 0.1;
    float distortionSpeed = 1.8;
    float distortionAmount = 0.5 * rand(uv * vec2(timeFactor, distortionSpeed)).x;
    return uv + distortionAmount * distortionScale * vec2(cos(timeFactor), sin(timeFactor));
}

vec3 chromaticAberration(vec2 texCoord) {
    float aberrationAmount = 0.005;
    vec2 redTexCoord = texCoord + vec2(aberrationAmount, 0.0);
    vec2 greenTexCoord = texCoord;
    vec2 blueTexCoord = texCoord - vec2(aberrationAmount, 0.0);

    vec3 redChannel = texture2D(uTexture, redTexCoord).rgb;
    vec3 greenChannel = texture2D(uTexture, greenTexCoord).rgb;
    vec3 blueChannel = texture2D(uTexture, blueTexCoord).rgb;

    return vec3(redChannel.r, greenChannel.g, blueChannel.b);
}

void main() {
	vec2 texCoord = waterDistortion(vTexCoord, 1.2);
    vec3 albedo = texture2D(uTexture, texCoord).rgb;
    float tex = texture2D(uTexture, texCoord).r;
    float roughness = uRoughness;

    albedo += chromaticAberration(texCoord);
    vec3 F0 = mix(vec3(0.04), albedo, tex);

    vec3 totalLight = vec3(0.0);
    vec3 N = normalize(vNormal);
    vec3 V = normalize(-vPosition);

    for (int i = 0; i < 32; i++) {
        vec3 L = normalize(lightPosition[i] - vPosition);
        vec3 H = normalize(V + L);

        float NDF = DistributionGGX(N, H, roughness);
        float G = GeometrySmith(N, V, L, roughness);
        vec3 F = fresnelSchlick(max(dot(H, V), 0.0), F0);

        vec3 kS = F;
        vec3 kD = vec3(1.0) - kS;
        kD *= 1.0 - tex;

        float NdotL = max(dot(N, L), 0.0);
        float NdotV = max(dot(N, V), 0.0);

        vec3 numerator = NDF * G * F;
        float denominator = 4.0 * NdotV * NdotL + 0.001; // Prevent divide by zero
        vec3 specular = numerator / denominator;

        vec3 diffuse = albedo / PI;

        vec3 radiance = lightColor[i-28] * NdotL;

        totalLight += (kD * diffuse + specular) * radiance;
    }

    vec3 subsurfaceContribution = subsurfaceScattering(albedo, N, V, V);

    vec3 reflectionContribution = traceReflection(vPosition, reflect(V, N));

    vec3 ambient = ambientLight * albedo;

    gl_FragColor = vec4(totalLight + subsurfaceContribution + reflectionContribution + ambient, 1.0);
}

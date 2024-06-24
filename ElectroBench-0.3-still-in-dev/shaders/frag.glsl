#version 120

uniform sampler2D uTexture; // the texture of the object

vec3 lightPosition[4] = vec3[4](vec3(1.0, 1.0, 1.0), vec3(-1.0, -1.0, -1.0), vec3(-2.2, -1.0, 1.0), vec3(0.7, 0.31, 0.2));
vec3 lightColor[4] = vec3[4](vec3(0.7, 0.31, 0.2), vec3(0.9, 0.41, 0.29), vec3(1.0, 0.8, 0.6), vec3(0.6, 0.8, 1.0));

// the ambient light
vec3 ambientLight = vec3(0.1, 0.1, 0.1);

// the roughness of the surface
float uRoughness = 0.1;
float PI = 3.14159265359; // Pi

float ambientOcclusionRadius = 0.1;

varying vec3 vNormal;
varying vec3 vPosition; 
varying vec2 vTexCoord; 

vec3 mod289(vec3 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec2 mod289(vec2 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

// Modulo 7 without a division
vec3 mod7(vec3 x) {
  return x - floor(x * (1.0 / 7.0)) * 7.0;
}

// Permutation polynomial: (34x^2 + 6x) mod 289
vec3 permute(vec3 x) {
  return mod289((34.0 * x + 10.0) * x);
}

// Cellular noise, returning F1 and F2 in a vec2.
// Standard 3x3 search window for good F1 and F2 values
vec2 rand(vec2 P) {
#define K 0.142857142857 // 1/7
#define Ko 0.428571428571 // 3/7
#define jitter 1.0 // Less gives more regular pattern
	vec2 Pi = mod289(floor(P));
 	vec2 Pf = fract(P);
	vec3 oi = vec3(-1.0, 0.0, 1.0);
	vec3 of = vec3(-0.5, 0.5, 1.5);
	vec3 px = permute(Pi.x + oi);
	vec3 p = permute(px.x + Pi.y + oi); // p11, p12, p13
	vec3 ox = fract(p*K) - Ko;
	vec3 oy = mod7(floor(p*K))*K - Ko;
	vec3 dx = Pf.x + 0.5 + jitter*ox;
	vec3 dy = Pf.y - of + jitter*oy;
	vec3 d1 = dx * dx + dy * dy; // d11, d12 and d13, squared
	p = permute(px.y + Pi.y + oi); // p21, p22, p23
	ox = fract(p*K) - Ko;
	oy = mod7(floor(p*K))*K - Ko;
	dx = Pf.x - 0.5 + jitter*ox;
	dy = Pf.y - of + jitter*oy;
	vec3 d2 = dx * dx + dy * dy; // d21, d22 and d23, squared
	p = permute(px.z + Pi.y + oi); // p31, p32, p33
	ox = fract(p*K) - Ko;
	oy = mod7(floor(p*K))*K - Ko;
	dx = Pf.x - 1.5 + jitter*ox;
	dy = Pf.y - of + jitter*oy;
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

void main()
{
    // calculate the lighting contributions
    vec3 totalLight = vec3(0.0);
    for (int i = 0; i < 4; i++)
    {
        // calculate the light direction
        vec3 lightDirection = normalize(lightPosition[i] - vPosition);
        // Calculate lambertian reflection 
        float diffuseTerm = clamp(dot(vNormal, lightDirection), 0.0, 1.0);

        // calculate the specular term using the Ward ISO reflection model
        vec3 viewDirection = normalize(gl_FrontFacing ? -vPosition : vPosition);
        vec3 halfVector = normalize(lightDirection + viewDirection);
        float specularTerm = pow(max(dot(vNormal, halfVector), 0.0), 256);

        // calculate the Fresnel term
        float F0 = 0.04;
        float F = F0 + (1.0 - F0) * pow(1.0 - dot(viewDirection, halfVector), 5.0);

        // calculate the final light contribution
        vec3 lightContribution = lightColor[i] * (texture2D(uTexture, vTexCoord).rgb * diffuseTerm + specularTerm);
        totalLight += lightContribution;
    }

    // calculate the ambient occlusion term
    vec3 samplePosition = vPosition + vNormal * ambientOcclusionRadius;
    float occlusion = texture2D(uTexture, vTexCoord).r;
    for (int i = 0; i < 16; i++)
    {
        samplePosition.xy += (2.0 * rand(vec2(i)) - 1.0) * vec2(ambientOcclusionRadius, ambientOcclusionRadius);
        vec4 sampleColor = texture2D(uTexture, samplePosition.st);
        occlusion += sampleColor.r;
    }
    occlusion /= 16.0;

    gl_FragColor = vec4(totalLight + ambientLight * occlusion, 1.0);
}

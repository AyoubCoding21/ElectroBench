#version 130

precision highp float;
precision highp sampler2D;
uniform sampler2D uTexture;  
uniform sampler2D uTexture2; 
uniform sampler2D uTexture3;

in vec3 vNormal;
in vec3 vPosition;
in vec2 vTexCoord;

// Parameters for lighting
vec3 lightColors[8] = vec3[](
    vec3(1.0, 0.9, 0.8),
    vec3(0.8, 0.8, 1.0),
    vec3(0.6, 1.0, 0.6),
    vec3(1.0, 1.0, 0.8),
    vec3(1.0, 0.5, 0.08),
    vec3(0.9, 0.8, 0.7),
    vec3(0.3, 0.4, 0.5),
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
vec3 ambientColor = vec3(0.3, 0.3, 0.3);
vec3 specularColor = vec3(1.0, 1.0, 1.0);
float shininess = 1024.0;
float fresnelPower = 5.0;
float metallic = 0.9;
float roughness = 0.3;
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

void main() {
    vec3 normal = normalize(vNormal);
    vec3 viewDir = normalize(-vPosition);

    vec3 albedo1 = texture2D(uTexture, vTexCoord).rgb;
    vec3 albedo2 = texture2D(uTexture2, vTexCoord).rgb;
    vec3 albedo3 = texture2D(uTexture3, vTexCoord).rgb;
    float mixFactor = 0.56; 
    vec3 albedo = mix(albedo1, albedo2, mixFactor);
    albedo += mix(albedo2, albedo3, 0.404);

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
    vec3 color  = ambientColor * albedo + finalDiffuse * (1.0 - metallic) + finalSpecular * metallic + fresnelEffect;

    // Dynamic effect based on time
    float wave = sin(vPosition.x * 0.5 + timeFactor) * 0.5 + 0.5;
    vec3 finalColor = color * wave;

    gl_FragColor = vec4(finalColor, 1.0);

}


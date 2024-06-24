#version 120

uniform sampler2D uTexture; // the texture of the object

// the position and color of the light sources
vec3 lightPosition[4] = vec3[4](vec3(1.0, 1.0, 1.0), vec3(-1.0, -1.0, -1.0), vec3(-2.2, -1.0, 1.0), vec3(0.7, 0.31, 0.2));
vec3 lightColor[4] = vec3[4](vec3(0.7, 0.31, 0.2), vec3(0.9, 0.41, 0.29), vec3(1.0, 0.8, 0.6), vec3(0.6, 0.8, 1.0));

// the ambient light
vec3 ambientLight = vec3(0.1, 0.1, 0.1);

// the roughness of the surface
float uRoughness = 0.1;
float PI = 3.14159265359;

float ambientOcclusionRadius = 0.1;
varying vec3 vNormal; // the normal vector of the current fragment
varying vec3 vPosition; // the position vector of the current fragment
varying vec2 vTexCoord; // the texture coordinates of the current fragment

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void main()
{
    // calculate the lighting contributions
    vec3 totalLight = vec3(0.0);
    for (int i = 0; i < 4; i++)
    {
        // calculate the light direction
        vec3 lightDirection = normalize(lightPosition[i] - vPosition);

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

    // set the fragment's color to the total light contribution
    gl_FragColor = vec4(totalLight + ambientLight * occlusion, 1.0);
}

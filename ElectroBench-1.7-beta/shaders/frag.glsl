#version 120
varying vec3 vNormal;
varying vec3 vPosition;

void main()
{
    vec3 lightDir = normalize(vec3(0.0706, 0.1137, 0.0706)); 
    vec3 viewDir = normalize(-vPosition);
    vec3 halfwayDir = normalize(lightDir + viewDir);
    float intensity = max(dot(vNormal, halfwayDir), 0.0);
    vec3 diffuse = vec3(0.0235, 0.3451, 0.9412);
    vec3 specular = vec3(0.9059, 0.6471, 0.0471);
    float shininess = 32.0;
    vec3 lighting = diffuse * intensity + specular * pow(intensity, shininess);
    float toonLevels = 4.0;
    float toonIntensity = floor(intensity * toonLevels) / toonLevels;
    vec3 toonColor = vec3(0.8275, 0.2706, 0.0314); 
    vec3 finalColor = mix(toonColor, lighting, toonIntensity);
    vec3 shadowColor = vec3(0.0196, 0.0431, 0.2275);
    float shadowIntensity = 0.74; 
    finalColor = mix(finalColor, shadowColor, shadowIntensity);

    gl_FragColor = vec4(finalColor, 1.0);
}


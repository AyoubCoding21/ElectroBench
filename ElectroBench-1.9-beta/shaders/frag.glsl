#version 120
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec2 vTexCoord;

void main()
{
    vec3 lightColor = vec3(1.0, 0.5, 0.0); 
    vec3 ambientColor = vec3(0.6, 0.33, 0.00042);
    vec3 diffuseColor = vec3(0.8, 0.4, 0.0859);
    vec3 specularColor = vec3(0.6, 0.325, 0.05);
    float shininess = 56.0; 
    vec3 N = normalize(vNormal);
    vec3 L = normalize(-vViewDir);
    vec3 E = normalize(-vViewDir);
    vec3 H = normalize(L + E);

    float NdotL = max(dot(N, L), 0.0);
    float NdotH = max(dot(N, H), 0.0);

    vec3 ambient = ambientColor;
    vec3 diffuse = lightColor * diffuseColor * NdotL;
    vec3 specular = lightColor * specularColor * pow(NdotH, shininess);

    vec3 finalColor = ambient + diffuse + specular;

    float rimThreshold = 0.14685; 
    float rimPower = 4.0; 
    float rimLight = 1.0 - smoothstep(1.05655 - rimThreshold, 0.8595, abs(dot(N, E)));

    finalColor += (rimLight * rimPower);

    vec3 fireColor = vec3(1.0, 0.495, 0.01); 

    float speed = 2.0; 
    float distortion = sin(vTexCoord.y * 40.0 + gl_FragCoord.x * speed) * 0.1;
    vec2 offseti = vec2(distortion, 0.0);

    vec2 texCoord = vTexCoord + offseti;
    vec3 fireEffect = fireColor * (1.0 - texCoord.y);

    finalColor += (fireEffect * 2);

    gl_FragColor = vec4(finalColor, 0.85);
}

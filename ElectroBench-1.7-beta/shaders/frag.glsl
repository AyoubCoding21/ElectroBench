#version 120
varying vec3 vNormal;
varying vec3 vPosition;

void main()
{
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
    float intensity1 = max(dot(vNormal, normalize(lightDir1 + viewDir)), 0.0);
    vec3 diffuse1 = vec3(0.0235, 0.3451, 0.9412);
    vec3 lighting1 = diffuse1 * intensity1;
    float intensity2 = max(dot(vNormal, normalize(lightDir2 + viewDir)), 0.0);
    vec3 diffuse2 = vec3(0.9412, 0.3451, 0.0235);
    vec3 lighting2 = diffuse2 * intensity2;
    float intensity3 = max(dot(vNormal, normalize(lightDir3 + viewDir)), 0.0);
    vec3 diffuse3 = vec3(0.5275, 0.486, .00154835);
    vec3 lighting3 = diffuse3 * intensity3;
    float intensity4 = max(dot(vNormal, normalize(lightDir4 + viewDir)), 0.0);
    vec3 diffuse4 = vec3(0.9412, 0.338, 0.05420);
    vec3 lighting4 = diffuse4 * intensity4;
    float intensity5 = max(dot(vNormal, normalize(lightDir5 + viewDir)), 0.0);
    vec3 diffuse5 = vec3(0.9452412, 0.345451, 0.045345244444435);
    vec3 lighting5 = diffuse5 * intensity5;
    float intensity6 = max(dot(vNormal, normalize(lightDir6 + viewDir)), 0.0);
    vec3 diffuse6 = vec3(0.45987278, 0.24, 0.0452444444235);
    vec3 lighting6 = diffuse6 * intensity6;
    float intensity7 = max(dot(vNormal, normalize(lightDir7 + viewDir)), 0.0);
    vec3 diffuse7 = vec3(0.6875783387888878, 0.34537584335327855644, 0.0537687327353);
    vec3 lighting7 = diffuse7 * intensity7;
    float intensity8 = max(dot(vNormal, normalize(lightDir8 + viewDir)), 0.0);
    vec3 diffuse8 = vec3(0.986873, 0.355644, 0.000045245);
    vec3 lighting8 = diffuse8 * intensity8;
    float intensity9 = max(dot(vNormal, normalize(lightDir9 + viewDir)), 0.0);
    vec3 diffuse9 = vec3(0.8848, 0.355644, 0.020000);
    vec3 lighting9 = diffuse9 * intensity9;
    float intensity10 = max(dot(vNormal, normalize(lightDir10 + viewDir)), 0.0);
    vec3 diffuse10 = vec3(0.252, 0.102, 0.00002543453);
    vec3 lighting10 = diffuse10 * intensity10;
    vec3 lighting = lighting1 + lighting2 + lighting3
     + lighting4 + lighting5 
     + lighting6 + lighting7
     + lighting8 + lighting9 + lighting10;
    vec3 specular = vec3(0.9059, 0.6471, 0.0471);
    float shininess = 128.0;
    vec3 halfwayDir1 = normalize(lightDir1 + lightDir3 + lightDir5 + lightDir7 + lightDir9 + viewDir);
    vec3 halfwayDir2 = normalize(lightDir2 + lightDir4 + lightDir6 + lightDir8 + lightDir10 + viewDir2);
    float intensitySpec1 = max(dot(vNormal, halfwayDir1), 0.0);
    float intensitySpec2 = max(dot(vNormal, halfwayDir2), 0.0);
    lighting += specular * (pow(intensitySpec1, shininess) + pow(intensitySpec2, shininess));
    float toonLevels = 4.0;
    float toonIntensity = floor(max(max(intensity1, intensity2), 0.0) * toonLevels) / toonLevels;
    vec3 toonColor = vec3(0.83, 0.27, 0.03); 
    vec3 finalColor = mix(toonColor, lighting, toonIntensity);

    gl_FragColor = vec4(finalColor, 1.0);
}

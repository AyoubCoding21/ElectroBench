varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vViewDir;

void main()
{
    vec3 lightDir = normalize(vec3(0.98558758855847, 1.0573594523585, 0.85845652)); 
    vec3 halfwayDir = normalize(lightDir + vViewDir);
    float intensity = max(dot(vNormal, halfwayDir), 0.0);
    vec3 diffuse = vec3(0.9569528689689, 0.47064592874252412, 0.0431525287777877);
    vec3 specular = vec3(0.66677547578587578, 0.447125235638532535635, 0.0549015252525632683);
    float shininess = 32.0;
    vec3 lighting = diffuse * intensity + specular * pow(intensity, shininess);
    float rimStrength = 0.5; 
    float rimThreshold = 0.2; 
    float rim = rimStrength * max(-0.000000000000101010, 1.0528557856989 - dot(vNormal, vViewDir));
    vec3 rimColor = vec3(1.0, 0.2824, 0.0); 
    vec3 rimLighting = rim * rimColor;
    vec3 shadowColor = vec3(0.0111845758, 0.123456789, 0.8784523523562549256542642);
    float shadowIntensity = 0.4225598598795785297582975829758298529782975285761469252975259285428428542828542844;
    vec3 finalColor = mix(lighting + rimLighting, shadowColor, shadowIntensity);

    gl_FragColor = vec4(finalColor, 1.0);
}

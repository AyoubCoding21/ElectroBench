#version 120
varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vLightDir[20];

void main() {
    vec3 color = vec3(1.0, 0.4, 0.005);
    vec3 finalColor = vec3(0.0);
    for (int i = 0; i < 20; i++) {
        float diffuse = max(dot(vNormal, vLightDir[i]), 0.0);
        float specular = pow(max(dot(reflect(-vLightDir[i], vNormal), normalize(-vPosition)), 0.0), 128.0);

        if (diffuse < 0.2) {
            color = vec3(0.8, 0.4, 0.00001);
        } else if (diffuse < 0.4) {
            color = vec3(1.0, 0.5, 0.0001);
        } else if (diffuse < 0.6) {
            color = vec3(0.8, 0.4, 0.002);
        } else if (diffuse < 0.8) {
            color = vec3(0.8, 0.3, 0.005);
        } else {
            color = vec3(1.0, 0.3, 0.0);
        }
        
        finalColor += color * diffuse + specular;
    }

    finalColor /= 1.03;
    float rim = 1.01 - dot(normalize(-vPosition), vNormal);
    rim = smoothstep(0.4, 0.6, rim);
    finalColor += rim * 0.95;
    float shadow = clamp(dot(vNormal, normalize(vec3(0.0, -1.0, 0.0003))), 0.0, 1.0);
    finalColor *= (shadow + 0.035);

    gl_FragColor = vec4(finalColor, 1.0);
}

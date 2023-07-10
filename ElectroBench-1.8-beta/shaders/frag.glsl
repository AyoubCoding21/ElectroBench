#version 120
varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vLightDir;

void main() {
    vec3 color = vec3(1.0, 0.5, 0.005);
    float diffuse = max(dot(vNormal, vLightDir), 0.0);
    float specular = pow(max(dot(reflect(-vLightDir, vNormal), normalize(-vPosition)), 0.0), 32.0);
    if (diffuse < 0.2) {
        color = vec3(0.8, 0.4, 0.00001);
    } else if (diffuse < 0.4) {
        color = vec3(1.0, 0.5, 0.0001);
    } else if (diffuse < 0.6) {
        color = vec3(0.8, 0.4, 0.002);
    } else if (diffuse < 0.8) {
        color = vec3(0.8, 0.4, 0.005);
    } else {
        color = vec3(1.0, 0.5, 0.0);
    }
    float rim = 1.01 - dot(normalize(-vPosition), vNormal);
    rim = smoothstep(0.2, 0.4, rim);
    color += rim * 0.25;
    float shadow = clamp(dot(vNormal, normalize(vec3(0.0, -1.0, 0.0003))), 0.0, 1.0);
    color *= shadow;

    gl_FragColor = vec4(color, 1.0);
}


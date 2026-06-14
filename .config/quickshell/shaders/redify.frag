#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float redStrength;
};

layout(binding = 1) uniform sampler2D source;

void main() {
  vec4 c = texture(source, qt_TexCoord0);

  float grayscale = dot(c.xyz, vec3(0.344, 0.5, 0.156));

  c.rgb = mix(c.rgb, vec3(1.0, 0.0, 0.0), grayscale * redStrength);
  fragColor = vec4(c.rgb * c.a, c.a);
}

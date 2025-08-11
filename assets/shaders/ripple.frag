precision highp float;

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_touch;

void main() {
  vec2 uv = gl_FragCoord.xy / u_resolution.xy;
  vec2 p = uv - u_touch;
  float dist = length(p);

  float wave = 0.0;
  wave += 0.6 * sin(10.0 * dist - 6.0 * u_time) / (1.0 + 10.0*dist);
  wave += 0.25 * sin(25.0 * dist - 8.0 * u_time) / (1.0 + 20.0*dist);

  vec3 base = vec3(0.03, 0.18, 0.32);
  vec3 light = vec3(0.6, 0.8, 1.0);

  float eps = 0.001;
  float h = wave;
  float hx = ( (sin(10.0 * length((uv + vec2(eps,0.0)) - u_touch) - 6.0 * u_time) / (1.0 + 10.0*length((uv + vec2(eps,0.0)) - u_touch))) - h ) / eps;
  float hy = ( (sin(10.0 * length((uv + vec2(0.0,eps)) - u_touch) - 6.0 * u_time) / (1.0 + 10.0*length((uv + vec2(0.0,eps)) - u_touch))) - h ) / eps;
  vec3 n = normalize(vec3(-hx, -hy, 1.0));

  float diff = clamp(dot(n, normalize(light)), 0.0, 1.0);
  vec3 color = base + wave * 0.3 + diff * 0.35;

  gl_FragColor = vec4(color, 1.0);
}

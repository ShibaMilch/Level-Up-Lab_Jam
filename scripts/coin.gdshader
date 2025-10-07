shader_type canvas_item;

uniform vec4 glow_color : source_color = vec4(1.0, 0.9, 0.4, 1.0);
uniform float glow_strength = 0.6;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    // Base texture
    COLOR = tex;

    // Add a glow tint on bright pixels
    float brightness = dot(tex.rgb, vec3(0.299, 0.587, 0.114));
    COLOR.rgb += glow_color.rgb * glow_strength * brightness;
}

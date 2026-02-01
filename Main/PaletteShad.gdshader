shader_type canvas_item;

uniform sampler2D oldP: filter_nearest;
uniform sampler2D newP: filter_nearest;

const int numC = 4;
const vec4 alphaCol = vec4(1.0,0.0,1.0,1.0);
const vec4 coinCol = vec4(0.0,1.0,1.0,1.0);
uniform float precision : hint_range(0.0, 1.0, 0.1) = 0.1;

vec4 swap_color(vec4 color) {
	float inc = 1.0 / float(numC);
	for (float i = 0.0; i < 1.0; i += inc) {
		vec2 uv = vec2(i,0.0);
		vec4 color_in = texture(oldP,uv);
		if (distance(color,color_in) <= precision) {
			return texture(newP, uv);
		}
	}
	return color;
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec4 new_color = swap_color(color);
	if (new_color==alphaCol) {
		new_color.a = 0.0;
	}
	COLOR = new_color;
}

shader_type spatial;
// render_mode unshaded;

uniform sampler2D noise_tex;
uniform float height_multiplier = 0.5;
uniform float noise_sample_size = 0.1;
uniform vec4 asteroid_color:source_color;

void vertex() {
	// Called for every vertex the material is visible on.
	float height = texture(noise_tex, VERTEX.xz * noise_sample_size).r;
	VERTEX += NORMAL * height * height_multiplier;
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = asteroid_color.rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}

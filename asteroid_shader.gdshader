shader_type spatial;
// render_mode unshaded;

// Noise
uniform sampler2D noise_tex;
uniform float height_multiplier = 0.5;
uniform float noise_sample_size = 0.1;

// Lighting
uniform vec4 asteroid_color:source_color;

uniform int cuts:hint_range(1, 8) = 3;
uniform float wrap:hint_range(-2.0f, 2.0f) = 0.0f;
uniform float steepness:hint_range(1.0f, 8.0f) = 1.0f;

uniform bool use_attenuation = true;

uniform bool use_specular = true;
uniform float specular_strength:hint_range(0.0f, 1.0f) = 1.0f;
uniform float specular_shininess:hint_range(0.0f, 32.0f) = 16.0f;
uniform vec4 specular_map:source_color = vec4(1.0f, 1.0f, 1.0f, 1.0f);

uniform bool use_rim = true;
uniform float rim_width:hint_range(0.0f, 16.0f) = 8.0f;
uniform vec4 rim_color:source_color = vec4(1.0f);


void vertex() {
	// Called for every vertex the material is visible on.
	float height = texture(noise_tex, VERTEX.xy * noise_sample_size).r;
	VERTEX += NORMAL * height * height_multiplier;
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = asteroid_color.rgb;
}

void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
	float attenuation = 1.0f;
	if(use_attenuation) {
		attenuation = ATTENUATION;
	}
	
	// Diffuse
	float NdotL = dot(NORMAL, LIGHT);
	float diffuse_amount = NdotL + (attenuation - 1.0) + wrap;
	diffuse_amount *= steepness;
	float cuts_inv = 1.0f / float(cuts);
	float diffuse_stepped = clamp(diffuse_amount + mod(1.0f - diffuse_amount, cuts_inv), 0.0f, 1.0f);
	
	if (use_specular) {
		vec3 H = normalize(LIGHT + VIEW);
		float NdotH = dot(NORMAL, H);
		float specular_amount = max(pow(NdotH, specular_shininess * specular_shininess), 0.0f)
								* specular_map.r
								* attenuation;
		specular_amount = step(0.5f, specular_amount);
		SPECULAR_LIGHT += specular_strength * specular_amount * LIGHT_COLOR;
	}
	
	if (use_rim) {
		float NdotV = dot(NORMAL, VIEW);
		float rim_light = pow(1.0 - NdotV, rim_width);
		DIFFUSE_LIGHT += rim_light * rim_color.rgb * rim_color.a * LIGHT_COLOR / PI;
	}
	
	vec3 diffuse = ALBEDO.rgb * LIGHT_COLOR / PI;
	diffuse *= diffuse_stepped * (1.0f);
	DIFFUSE_LIGHT += diffuse;
}

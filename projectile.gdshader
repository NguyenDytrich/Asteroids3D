shader_type spatial;

uniform vec3 projectile_color:source_color = vec3(1.0, 1.0, 1.0);

float fresnel(vec3 normal, mat4 camera_matrix) {
	vec3 view_direction_world = (camera_matrix * vec4(0.0, 0.0, 1.0, 0.0)).xyz;
	vec3 normal_world = (camera_matrix * vec4(normal, 0.0)).xyz;
	
	float d = dot(view_direction_world, normal_world);
	d = abs(d);
	d = clamp(d, 0.0, 1.0);
	
	return 1.0 - d;
}

void fragment() {
	// Called for every pixel the material is visible on.;
	// ALBEDO = mix(projectile_color, vec3(1.0, 1.0, 1.0), fresnel(NORMAL, INV_VIEW_MATRIX) * 4.0);
	ALBEDO = projectile_color;
	float alpha = 1.0 - (fresnel(NORMAL, INV_VIEW_MATRIX) * 2.0);
	ALPHA = clamp(alpha, 0.0, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}

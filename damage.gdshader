shader_type canvas_item;

uniform float colourswitch = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {	
	COLOR = mix(vec4(0.0),vec4(1.0,0.0,0.0,1.0),colourswitch);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}

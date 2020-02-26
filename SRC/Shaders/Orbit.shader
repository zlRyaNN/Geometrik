shader_type canvas_item;

uniform float time_factor = 25;
uniform float amplitude = 1.5;

void vertex()
{
	VERTEX.y += cos(TIME * time_factor + VERTEX.x + VERTEX.y) * amplitude;
}
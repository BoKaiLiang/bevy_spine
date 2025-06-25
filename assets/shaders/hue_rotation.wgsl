#import bevy_sprite::mesh2d_vertex_output::VertexOutput

@group(2) @binding(0) var<uniform> material_time: f32;
@group(2) @binding(1) var base_color_texture: texture_2d<f32>;
@group(2) @binding(2) var base_color_sampler: sampler;

@fragment
fn fragment(mesh: VertexOutput) -> @location(0) vec4<f32> {
    let c = -cos(material_time * 5.0);
    let s = -sin(material_time * 5.0);

    let hueRotation = mat4x4<f32>(
        vec4<f32>(0.299,  0.587,  0.114, 0.0),
        vec4<f32>(0.299,  0.587,  0.114, 0.0),
        vec4<f32>(0.299,  0.587,  0.114, 0.0),
        vec4<f32>(0.000,  0.000,  0.000, 1.0)
    ) + mat4x4<f32>(
        vec4<f32>( 0.701, -0.587, -0.114, 0.0),
        vec4<f32>(-0.299,  0.413, -0.114, 0.0),
        vec4<f32>(-0.300, -0.588,  0.886, 0.0),
        vec4<f32>( 0.000,  0.000,  0.000, 0.0)
    ) * c + mat4x4<f32>(
        vec4<f32>( 0.168,  0.330, -0.497, 0.0),
        vec4<f32>(-0.328,  0.035,  0.292, 0.0),
        vec4<f32>( 1.250, -1.050, -0.203, 0.0),
        vec4<f32>( 0.000,  0.000,  0.000, 0.0)
    ) * s;

    let pixel = textureSample(base_color_texture, base_color_sampler, mesh.uv);
    return pixel * hueRotation;
}
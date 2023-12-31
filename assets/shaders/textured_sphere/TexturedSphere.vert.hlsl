struct VSIn{
    float3 position : POSITION0;
    float2 baseColorUV : TEXCOORD0;
    float2 metallicUV : TEXCOORD1;
    float2 roughnessUV : TEXCOORD2;
    float2 normalUV : TEXCOORD3;
    float3 normal: NORMAL0;
    float4 tangent: TEXCOORD4;
};

struct VSOut{
    float4 position : SV_POSITION;
    float2 baseColorUV : TEXCOORD0;
    float2 metallicUV : TEXCOORD1;
    float2 roughnessUV : TEXCOORD2;
    float2 normalUV : TEXCOORD2;
	float3 worldNormal : NORMAL0;
    float3 worldTangent: TEXCOORD3;
    float3 worldBiTangent : TEXCOORD4;
    float3 worldPos: POSITION0;
};

struct Transformation {
    float4x4 rotation;
    float4x4 transformation;
    float4x4 projection;
};

ConstantBuffer <Transformation> tBuffer: register(b0, space0);

VSOut main(VSIn input) {
    VSOut output;

    float4 rotationResult = mul(tBuffer.rotation, float4(input.position, 1.0f));
    float4 worldPos = mul(tBuffer.transformation, rotationResult);

    output.position = mul(tBuffer.projection, worldPos);
    output.baseColorUV = input.baseColorUV;
    output.metallicUV = input.metallicUV;
    output.roughnessUV = input.roughnessUV;
    output.normalUV = input.normalUV;
    output.worldPos = worldPos.xyz;

	float4 rotationTangent = mul(tBuffer.rotation, input.tangent);
    float3 worldTangent = normalize(mul(tBuffer.transformation, rotationTangent).xyz);

	float4 rotationNormal = mul(tBuffer.rotation, float4(input.normal, 0.0));
    float3 worldNormal = normalize(mul(tBuffer.transformation, rotationNormal).xyz);
	// float3 worldBiTangent = normalize(mul(tBuffer.rotation, float4((input.normal.xyz, input.tangent.xyz), 0.0)).xyz);
    // float3 worldBiTangent = normalize(cross(worldNormal.xyz, worldTangent.xyz));
    float3 worldBiTangent = normalize(cross(worldNormal.xyz, worldTangent.xyz));
    
    output.worldTangent = worldTangent;
    output.worldNormal = worldNormal;
    output.worldBiTangent = worldBiTangent;

    return output;
}
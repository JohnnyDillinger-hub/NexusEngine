struct PSIn {
    float4 position : SV_POSITION;
    float2 uv : TEXCOORD0;
};

struct PSOut {
    float4 color : SV_Target0;
};

sampler mSampler : register(s1, space0);
Texture2D mTexture : register(t1, space0);

struct ImageOptions {
    float mipLevel;
    // int sliceIndex; // TODO: Consider adding sliceIndex in future
};

ConstantBuffer <ImageOptions> imageOptionsBuff : register(b2, space0);

PSOut main(PSIn input) {
    PSOut output;
    output.color = mTexture.SampleLevel(
        mSampler, 
        input.uv, 
        imageOptionsBuff.mipLevel
    );
    // output.color = float4(imageOptionsBuff.mipLevel / 10.0f, 0.0f, 0.0f, 1.0f);
    return output;
}
// Extracted HLSL code for Custom/URPUnlitTest
// This file is intended for HLSL Tools IntelliSense.

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

struct Attributes
{
    float4 positionOS : POSITION;
    float2 uv : TEXCOORD0;
};
struct Varyings
{
    float4 positionHCS : SV_POSITION;
    float2 uv : TEXCOORD0;
};

TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
CBUFFER_START(UnityPerMaterial)
float4 _BaseColor;
CBUFFER_END

Varyings vert(Attributes v)
{
    Varyings o;
    float4 posWS = mul(GetObjectToWorldMatrix(), v.positionOS);
    o.positionHCS = TransformWorldToHClip(posWS.xyz);
    o.uv = v.uv;
    return o;
}

half4 frag(Varyings i) : SV_Target
{
    half4 baseCol = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.uv);
    return baseCol * _BaseColor;
}

// Extracted HLSL code for Custom/URPUnlitTest
// This file is intended for HLSL Tools IntelliSense.

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

struct appdata
{
    float4 positionOS : POSITION;
    float2 uv : TEXCOORD0;
};
struct v2f
{
    float4 positionHCS : SV_POSITION;
    float2 uv : TEXCOORD0;
};

TEXTURE2D(_OtherMap);
SAMPLER(sampler_BaseMap);
TEXTURE2D(_BaseMap);
SAMPLER(sampler_OtherMap);
CBUFFER_START(UnityPerMaterial)
float4 _BaseColor;
CBUFFER_END

v2f vert(appdata v)
{
    v2f o;
    float4 posWS = mul(GetObjectToWorldMatrix(), v.positionOS);
    o.positionHCS = TransformWorldToHClip(posWS.xyz);
    o.uv = v.uv;
    return o;
}

half4 frag(v2f i) : SV_Target
{
    half4 baseCol = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.uv);
    half4 otherCol = SAMPLE_TEXTURE2D(_OtherMap, sampler_OtherMap, i.uv);
    // Time-based blend factor using sine, remapped to [0,1]
    half blend = 0.5 + 0.5 * sin(_TimeParameters.y);
    half4 finaCol = lerp(baseCol, otherCol, blend);
    return finaCol * _BaseColor;
}

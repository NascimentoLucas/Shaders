// URP Core and Lighting helpers
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

// Per‑material properties (SRP Batcher compatible)
TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
CBUFFER_START(UnityPerMaterial)
float4 _BaseColor;
CBUFFER_END

struct Attributes
{
    float3 positionOS : POSITION;
    float3 normalOS : NORMAL;
    float2 uv : TEXCOORD0;
};

struct Varyings
{
    float4 positionHCS : SV_POSITION;
    float3 positionWS : TEXCOORD0;
    float3 normalWS : TEXCOORD1;
    float2 uv : TEXCOORD2;
};

Varyings vert(Attributes v)
{
    Varyings o;
    float3 posWS = TransformObjectToWorld(v.positionOS);
    o.positionWS = posWS;
    o.positionHCS = TransformWorldToHClip(posWS);
    o.normalWS = TransformObjectToWorldNormal(v.normalOS);
    o.uv = v.uv;
    return o;
}

half4 frag(Varyings i) : SV_Target
{
    float3 n = normalize(i.normalWS);

    // Main directional light
    Light mainLight = GetMainLight(TransformWorldToShadowCoord(i.positionWS));
    float NdotL = saturate(dot(n, mainLight.direction));

    // Ambient from spherical harmonics
    float3 ambient = SampleSH(n);

    half4 baseCol = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.uv);
    float3 litColor = baseCol.rgb * (ambient + mainLight.color * NdotL);
    return half4(litColor, baseCol.a);
}

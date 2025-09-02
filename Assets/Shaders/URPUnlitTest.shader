Shader "Custom/URPUnlitTest"
{
    Properties {
        _BaseMap("Base Map", 2D) = "white" {}
        _BaseColor ("Base Color", Color) = (1,1,1,1)

    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0
            // Include extracted HLSL for IntelliSense and reuse
            #include "URPUnlitTest.hlsl"
            ENDHLSL
        }
    }
}

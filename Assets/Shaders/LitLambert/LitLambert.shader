Shader "Custom/LitLamber"
{
    Properties{
        _BaseColor("Base Color", Color) = (1,1,1,1)
    }

    SubShader{
        Tags{ "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
        Pass{
            Tags{"LightMode"="UniversalForward"}

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.5
            #include "LitLamber.hlsl"
            ENDHLSL
        }
    }
}

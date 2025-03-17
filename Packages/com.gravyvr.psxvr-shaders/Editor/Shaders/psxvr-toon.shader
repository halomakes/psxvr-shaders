Shader "psxvr/toon" {
	Properties{
		_MainTex("Albedo", 2D) = "white" {}
		[IntRange]_Lights("Realtime Lights", range(0,4)) = 1
		[FloatRange]_Crunchiness("Vertex Crunchiness", range(0.001, 1)) = 0.8
		[FloatRange]_EvCompensation("Exposure Compensation", range(-1, 1)) = 0
		[FloatRange]_ShadeMix("Shading Mix", range(0,1)) = 0.5
	}
	CustomEditor "PsxvrToonUi"
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		Pass {
			Lighting On
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "psxvr-library.cginc"

			struct v2f
			{
				fixed4 pos : SV_POSITION;
				half4 color : COLOR0;
				half4 colorFog : COLOR1;
				float2 uv_MainTex : TEXCOORD0;
				half3 normal : TEXCOORD1;
			};

			float4 _MainTex_ST;
			uniform half4 unity_FogStart;
			uniform half4 unity_FogEnd;
			int _Lights;
			float _Crunchiness;
			float _EvCompensation;
			float _ShadeMix;

			v2f vert(appdata_full v)
			{
				v2f o;

				// snap
				o.pos = vertexSnap(v.vertex, _Crunchiness);

				// lighting
				float4 unlit = float4(1.0, 1.0, 1.0, 1.0);
				o.color = float4(shadeAmbient(v.vertex, _Lights), 1.0);
				o.color = clamp((o.color * _ShadeMix) + (unlit * (1 - _ShadeMix)) + _EvCompensation, 0.0, 1.0);

				//Affine Texture Mapping
				float distance = length(mul(UNITY_MATRIX_MV,v.vertex));
				float4 vertex = UnityObjectToClipPos(v.vertex);
				float4 affinePos = vertex; //vertex;				
				o.uv_MainTex = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.uv_MainTex *= distance + (vertex.w*(UNITY_LIGHTMODEL_AMBIENT.a * 8)) / distance / 2;
				o.normal = distance + (vertex.w*(UNITY_LIGHTMODEL_AMBIENT.a * 8)) / distance / 2;

				return o;
			}

			sampler2D _MainTex;

			float4 frag(v2f IN) : COLOR
			{
				return tex2D(_MainTex, IN.uv_MainTex / IN.normal.r)*IN.color;
			}
			
			ENDCG
		}
	}
}
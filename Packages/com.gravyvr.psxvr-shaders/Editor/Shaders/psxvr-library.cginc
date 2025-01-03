float3 shadeAmbient(float4 vertex, int lightCount) {
    float3 viewpos = UnityObjectToViewPos (vertex.xyz);

    half3 ambientLight = ShadeSH9(float4(1,1,1, 1.0));
    float3 lightColor = UNITY_LIGHTMODEL_AMBIENT.xyz + ambientLight;
    for (int i = 0; i < lightCount; i++) {
        float3 toLight = unity_LightPosition[i].xyz - viewpos.xyz * unity_LightPosition[i].w;
        float lengthSq = dot(toLight, toLight);

        // don't produce NaNs if some vertex position overlaps with the light
        lengthSq = max(lengthSq, 0.000001);

        toLight *= rsqrt(lengthSq);

        float atten = 1.0 / (1.0 + lengthSq * unity_LightAtten[i].z);

        lightColor += unity_LightColor[i].rgb * atten;
    }

    return lightColor;
}

float4 vertexSnap(float3 vertex, float crunchiness){
    //Vertex snapping
    float4 snapToPixel = UnityObjectToClipPos(vertex);
    float4 result = snapToPixel;
    result.xyz = snapToPixel.xyz / snapToPixel.w;
    int factor = floor(20 / crunchiness);
    result.x = floor(factor * result.x) / factor;
    result.y = floor(factor * result.y) / factor;
    result.xyz *= snapToPixel.w;
    return result;
}
#if UNITY_EDITOR
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class PsxvrShadedUi : PsxvrUi
{
    protected override string ShaderName => "PSXVR Shaded";
}
#endif

#if UNITY_EDITOR
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class PsxvrToonUi : PsxvrUi
{
    protected override string ShaderName => "PSXVR Toon";
}
#endif

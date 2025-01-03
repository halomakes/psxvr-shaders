#if UNITY_EDITOR
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public abstract class PsxvrUi : ShaderGUI
{
    private Font FontVrchat;

    private MaterialEditor editor = null;
    protected abstract string ShaderName { get; }

    private static class PsxColors
    {
        private const int dividend = 255;
        public static Color Light = new(193f / dividend, 193f / dividend, 193f / dividend);
        public static Color Blue = new(0 / dividend, 172 / dividend, 159 / dividend);
        public static Color Dark = new(30 / dividend, 30 / dividend, 30 / dividend);
    }

    protected Dictionary<string, string> Tooltips = new()
    {
        { "_Lights", "How many realtime lights to include in ambient lighting calculation" },
        { "_Crunchiness", "Strength of the low-precision vertex snapping effect" },
        { "_ShadeMix", "How much environment lighting should affect material's appearance" },
        { "_EvCompensation", "Offsets final exposure amount to make material brighter or darker" },
    };

    public override void OnGUI(MaterialEditor editor, MaterialProperty[] properties)
    {
        this.editor = editor;
        DrawBanner();
        EditorGUILayout.BeginVertical(GUI.skin.box);
        foreach (var property in properties)
        {
            DrawProperty(property);
        }
        EditorGUILayout.EndVertical();
    }

    private void DrawBanner()
    {
        var smallPadding = new RectOffset(1, 1, 1, 1);
        GUIStyle OtherStyle = new()
        {
            font = FontVrchat,
            alignment = TextAnchor.LowerRight,
            fontSize = 10,
            padding = smallPadding,
        };
        OtherStyle.normal.textColor = PsxColors.Blue;

        GUIStyle MainStyle = new()
        {
            font = FontVrchat,
            alignment = TextAnchor.MiddleCenter,
            fontSize = 26,
            padding = new RectOffset(0, 1, 0, 1),
        };
        MainStyle.normal.textColor = PsxColors.Light;

        EditorGUILayout.BeginVertical("GroupBox");
        Rect BannerRect = GUILayoutUtility.GetRect(0, int.MaxValue, 35, 80);
        EditorGUI.LabelField(BannerRect, "GitHub", OtherStyle);
        EditorGUI.LabelField(BannerRect, ShaderName, MainStyle);
        EditorGUI.LabelField(
            BannerRect,
            "Based on dsoft20/psx_retroshader",
            new GUIStyle
            {
                font = FontVrchat,
                alignment = TextAnchor.LowerLeft,
                fontSize = 10,
                padding = smallPadding,
            }
        );

        if (GUI.Button(BannerRect, string.Empty, new GUIStyle()))
        {
            Application.OpenURL("https://github.com/halomakes/psxvr-shaders");
        }

        EditorGUILayout.EndVertical();
    }

    private void DrawProperty(MaterialProperty property, string tooltip = null)
    {
        if (property == null)
            return;
        editor.ShaderProperty(property, MakeLabel(property));
    }

    private GUIContent MakeLabel(MaterialProperty property)
    {
        Tooltips.TryGetValue(property.name, out var tooltip);
        GUIContent staticLabel = new()
        {
            text = property?.displayName ?? property?.name ?? "Unknown",
            tooltip = tooltip,
        };
        return staticLabel;
    }
}
#endif

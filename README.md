# psxvr-shaders ![VPM Package Version](https://img.shields.io/vpm/v/com.gravyvr.psxvr-shaders?repository_url=https%3A%2F%2Fpsx.gravyvr.social%2Findex.json)
Retro shaders for use in VRChat.  Built on the shader work by [dsoft20/psx_retroshader](https://github.com/dsoft20/psx_retroshader).

![Example Image](demo/main.gif?raw=true)

### ⬇️ [Download Latest Version](https://github.com/halomakes/psxvr-shaders/releases/latest)
### 📦 [Add to VRChat Creator Companion](https://psx.gravyvr.social)

## Common Properties
* **Vertex Crunchiness**: Controls how strong the low-precision vertex snapping effect is.
  
  ![Example of Vertex Crunchiness](demo/vert.gif?raw=true)
* **EV Offset**: Compensates material final brightness.
  
  ![Example of EV Offset](demo/ev.gif?raw=true)
* **Shade Mix**: Mixes between scene lighting and unlit values.  Use this to tone back lighting if it's too strong for your application.
  
  ![Example of Shading Mix](demo/mix.gif?raw=true)

*There is an included [VRCFury](https://github.com/VRCFury/VRCFury) prefab to add controls for these values to your expressions wheel.  Change the animator rewrite path in the main component if your avatar mesh is named something other than "Body".  

## Variants
### psxvr/toon
Mostly flat-shaded but inherits lighting from the environment at the anchor point.  Produces a softer look that's useful for characters and models with higher polygon counts.

### psxvr/shaded
Vertex-shaded variant.  Harsher look that's good for for super-low-poly objects or where you really want to show off the individual polygons. 

## Potential Features to Investigate
* AudioLink support
* Terrain variant with auto subdivision for nearby geometry

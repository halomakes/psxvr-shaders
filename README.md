# psxvr-shaders
Retro shaders for use in VRChat.  Built on the shader work by [dsoft20/psx_retroshader](https://github.com/dsoft20/psx_retroshader).

## Common Properties
* **Vertex Crunchiness**: Controls how strong the low-precision vertex snapping effect is.
* **EV Offset**: Compensates material final brightness.
* **Shade Mix**: Mixes between scene lighting and unlit values.  Use this to tone back lighting if it's too strong for your liking.

*There is an included [VRCFury](https://github.com/VRCFury/VRCFury) prefab to add controls for these values to your expressions wheel.  Change the animator rewrite path in the main component if your avatar mesh is named something other than "Body".  

## Variants
### psxvr/toon
Mostly flat-shaded but inherits lighting from the environment at the anchor point.  Useful for characters and models with higher polygon counts.

### psxvr/shaded
Vertex-shaded variant, useful for super-low-poly objects and environments. 

## Potential Features to Investigate
* AudioLink support
* Landscape variant with auto subdivision for nearby geometry

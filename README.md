# as3-RSLLoader

Little helper class to load swf files as a realtime shared library (for debug builds) or an embedded library (for release builds) respectively. Or at least that was the initial thought.

_note: Project was made in [flashdevelop](http://www.flashdevelop.org)._

***

### how to

to load external files _(must be relative to ouput swf location, unless you have your domain policies checked)_
```actionscript
RSLLoader.loadExternal( optionalCallback, "rsl/visualAssets.swf" );
```

to load embedded files
```actionscript
[Embed(source="../bin/rsl/visualAssets.swf", mimeType="application/octet-stream")]
public var VisualAssetsClass:Class;
```
```actionscript
RSLLoader.loadEmbedded( optionalCallback, new VisualAssetsClass );
```


This, plus conditional compilation constants (like in FD), switching from using RSL during debug while embedding during release compiles would require almost zero effort.
```actionscript
CONFIG::debug {
	RSLLoader.loadExternal( start, "rsl/visualAssets.swf" );
}
CONFIG::release {
	RSLLoader.loadEmbedded( start, new VisualAssets() );
}
```
One tip is to add the swc as an external library yet excluded from compile to get class definitions. This way the auto-complete and syntax checks would still work correctly.
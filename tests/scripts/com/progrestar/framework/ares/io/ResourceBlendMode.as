package com.progrestar.framework.ares.io
{
   public class ResourceBlendMode
   {
      
      public static const fastMarkeToValue:Vector.<String> = new <String>["normal","subtract","shader","screen","overlay","multiply","lighten","layer","invert","hardlight","erase","difference","darken","alpha","add"];
      
      public static const markerToValue:Object = {
         "14":"add",
         "13":"alpha",
         "12":"darken",
         "11":"difference",
         "10":"erase",
         "9":"hardlight",
         "8":"invert",
         "7":"layer",
         "6":"lighten",
         "5":"multiply",
         "4":"overlay",
         "3":"screen",
         "2":"shader",
         "1":"subtract",
         "0":"normal"
      };
      
      public static const valueToMarker:Object = {
         "add":14,
         "alpha":13,
         "darken":12,
         "difference":11,
         "erase":10,
         "hardlight":9,
         "invert":8,
         "layer":7,
         "lighten":6,
         "multiply":5,
         "overlay":4,
         "screen":3,
         "shader":2,
         "subtract":1,
         "normal":0
      };
       
      
      public function ResourceBlendMode()
      {
         super();
      }
   }
}

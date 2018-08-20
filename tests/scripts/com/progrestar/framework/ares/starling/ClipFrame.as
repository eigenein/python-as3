package com.progrestar.framework.ares.starling
{
   import starling.textures.Texture;
   
   public class ClipFrame
   {
       
      
      public var texture:Texture;
      
      public var x:Number;
      
      public var y:Number;
      
      public function ClipFrame(param1:Texture, param2:Number, param3:Number)
      {
         super();
         this.texture = param1;
         this.x = param2;
         this.y = param3;
      }
   }
}

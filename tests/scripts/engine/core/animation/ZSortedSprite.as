package engine.core.animation
{
   import avmplus.getQualifiedClassName;
   import feathers.layout.ILayoutableDisplayObject;
   import starling.display.Sprite;
   
   public class ZSortedSprite extends Sprite implements ILayoutableDisplayObject
   {
      
      public static const BACK_Z:Number = -1000000;
      
      public static const FRONT_Z:Number = 1000000;
      
      public static const SCENE_FX_FRONT_Z:Number = 10;
      
      public static const NORMAL:Number = 0;
      
      public static const CONTAINER_Z:Number = 5;
      
      public static const UI_LAYER_Z:Number = 1200000.0;
       
      
      public var z:Number = 0;
      
      private var description:String;
      
      public function ZSortedSprite()
      {
         super();
      }
      
      public static function sortMethod(param1:ZSortedSprite, param2:ZSortedSprite) : Number
      {
         return param1.z - param2.z;
      }
      
      public static function sortMethodAny(param1:Sprite, param2:Sprite) : Number
      {
         if(param1 is ZSortedSprite && param2 is ZSortedSprite)
         {
            return (param1 as ZSortedSprite).z - (param2 as ZSortedSprite).z;
         }
         return 0;
      }
      
      override public function dispose() : void
      {
         if(hasEventListener("disposed"))
         {
            broadcastEventWith("disposed");
         }
         super.dispose();
      }
      
      public function resortChildren() : void
      {
         sortChildren(ZSortedSprite.sortMethod);
      }
      
      public function toString() : String
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         return "ZSortedSprite";
      }
      
      public function setDescription(param1:String) : void
      {
         this.description = param1;
         if(blendMode != "normal")
         {
            param1 = param1 + (" " + blendMode);
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(super.visible != param1)
         {
            .super.visible = param1;
            this.dispatchEventWith("layoutDataChange");
         }
      }
      
      public function get includeInLayout() : Boolean
      {
         return super.visible;
      }
      
      public function set includeInLayout(param1:Boolean) : void
      {
      }
   }
}

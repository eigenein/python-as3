package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Frame;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.starling.ClipImageCache;
   import flash.geom.Point;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class HitTestImage extends Image
   {
       
      
      private var node:Node;
      
      private var frame:Frame;
      
      public function HitTestImage(param1:Texture, param2:Node)
      {
         super(param1);
         this.node = param2;
         this.frame = param2.clip.timeLine[0] as Frame;
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(frame.image == null || frame.image.resource == null)
         {
            ClipImageCache.disposedClipError("HitTestImage",node.clip.className);
            return null;
         }
         var _loc4_:Number = param1.x;
         var _loc5_:Number = param1.y;
         if(param2 && (!visible || !touchable))
         {
            return null;
         }
         if(_loc4_ < 0 || _loc5_ < 0 || _loc4_ > frame.area.width || _loc5_ > frame.area.height)
         {
            return null;
         }
         _loc4_ = _loc4_ * frame.image.resource.invertedResolution;
         _loc5_ = _loc5_ * frame.image.resource.invertedResolution;
         var _loc3_:uint = frame.image.bitmapData.getPixel32(frame.area.x + _loc4_,frame.area.y + _loc5_);
         if(_loc3_ >>> 24 > 0)
         {
            return this;
         }
         return null;
      }
   }
}

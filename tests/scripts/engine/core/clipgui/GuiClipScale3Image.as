package engine.core.clipgui
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.starling.ClipImageTextureFactory;
   import feathers.display.Scale3Image;
   import feathers.textures.Scale3Textures;
   import flash.geom.Rectangle;
   
   public class GuiClipScale3Image extends GuiClipScale3ImageBase
   {
       
      
      private var firstRegionsSize:Number;
      
      private var secondRegionSize:Number;
      
      private var direction:String;
      
      public function GuiClipScale3Image(param1:Number = NaN, param2:Number = NaN, param3:String = "horizontal")
      {
         super();
         this.firstRegionsSize = param1;
         this.secondRegionSize = param2;
         this.direction = param3;
      }
      
      public function get image() : Scale3Image
      {
         return graphics as Scale3Image;
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc2_:* = null;
         if(firstRegionsSize != firstRegionsSize)
         {
            _loc2_ = GuiClipFactoryBase.getScale9Grid(param1.clip);
            if(_loc2_.x != 0 && _loc2_.width != 0)
            {
               firstRegionsSize = _loc2_.x;
               secondRegionSize = _loc2_.width;
               direction = "horizontal";
            }
            else
            {
               firstRegionsSize = _loc2_.y;
               secondRegionSize = _loc2_.height;
               direction = "vertical";
            }
         }
         super.setNode(param1);
      }
      
      override protected function createTextures(param1:Clip) : Scale3Textures
      {
         return ClipImageTextureFactory.getScale3Texture(param1,firstRegionsSize / param1.invertedResolution,secondRegionSize / param1.invertedResolution,direction);
      }
   }
}

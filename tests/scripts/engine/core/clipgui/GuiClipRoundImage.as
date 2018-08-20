package engine.core.clipgui
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Frame;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.starling.ClipImageCache;
   import com.progrestar.framework.ares.starling.StarlingClipNode;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.view.popup.clan.editicon.RoundImage;
   import starling.display.DisplayObject;
   import starling.textures.Texture;
   
   public class GuiClipRoundImage extends GuiClipImageBase
   {
       
      
      protected var _image:RoundImage;
      
      public function GuiClipRoundImage()
      {
         super();
      }
      
      public function get image() : RoundImage
      {
         return _image;
      }
      
      override public function get graphics() : DisplayObject
      {
         return _image;
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc5_:* = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         _image = createImage(param1);
         if(param1.clip.timeLine.length > 0)
         {
            _loc5_ = (param1.clip.timeLine[0] as Frame).frame;
         }
         if(_loc5_)
         {
            _loc2_ = param1.clip.bounds.x + _loc5_.x;
            _loc3_ = param1.clip.bounds.y + _loc5_.y;
         }
         else
         {
            _loc2_ = param1.clip.bounds.x;
            _loc3_ = param1.clip.bounds.y;
         }
         var _loc4_:Matrix = param1.state.matrix;
         _image.x = _image.x + (_loc4_.a * _loc2_ + _loc4_.c * _loc3_);
         _image.y = _image.y + (_loc4_.b * _loc2_ + _loc4_.d * _loc3_);
      }
      
      protected function createImage(param1:Node) : RoundImage
      {
         var _loc2_:* = null;
         var _loc3_:Texture = createTexture(param1.clip);
         if(_loc3_)
         {
            _loc2_ = new RoundImage(_loc3_);
            StarlingClipNode.applyState(_loc2_,param1.state);
         }
         else
         {
            _loc2_ = new RoundImage(AssetStorage.rsx.missing);
            StarlingClipNode.applyState(_loc2_,param1.state);
            _loc2_.width = param1.clip.bounds.width;
            _loc2_.height = param1.clip.bounds.height;
         }
         return _loc2_;
      }
      
      protected function createTexture(param1:Clip) : Texture
      {
         return ClipImageCache.getClipTexture(param1);
      }
   }
}

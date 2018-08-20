package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.extension.Scale9DataExtension;
   import com.progrestar.framework.ares.starling.ClipImageCache;
   import com.progrestar.framework.ares.starling.ClipImageTextureFactory;
   import engine.core.clipgui.IGuiClip;
   import engine.core.clipgui.INeedNestedParsing;
   import feathers.controls.Button;
   import feathers.controls.ScrollBar;
   import feathers.display.Scale3Image;
   import feathers.display.Scale9Image;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Image;
   
   public class GameScrollBar extends ScrollBar implements IGuiClip, INeedNestedParsing
   {
       
      
      public var slider:ClipDataProvider;
      
      public var bg:ClipDataProvider;
      
      public function GameScrollBar()
      {
         super();
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      public function get container() : DisplayObjectContainer
      {
         return this;
      }
      
      public function setNode(param1:Node) : void
      {
         x = param1.state.matrix.tx;
         y = param1.state.matrix.ty;
         width = param1.clip.bounds.width * param1.state.matrix.a;
         height = param1.clip.bounds.height * param1.state.matrix.d;
      }
      
      override protected function initialize() : void
      {
         thumbFactory = __thumbFactory;
         minimumTrackFactory = __trackFactory;
         super.initialize();
         direction = "vertical";
      }
      
      private function __thumbFactory() : Button
      {
         var _loc1_:GameButton = new GameButton();
         if(slider)
         {
            _loc1_.defaultSkin = createImage(slider.clip);
         }
         else
         {
            _loc1_.defaultSkin = new Scale3Image(AssetStorage.rsx.popup_theme.getScale3TexturesVertical("slider_but_10_10_1",10,1));
         }
         return _loc1_;
      }
      
      private function __trackFactory() : Button
      {
         var _loc1_:GameButton = new GameButton();
         if(bg)
         {
            _loc1_.defaultSkin = createImage(bg.clip);
         }
         else
         {
            _loc1_.defaultSkin = new Scale3Image(AssetStorage.rsx.popup_theme.getScale3TexturesVertical("slider_bg_10_10_1",10,1));
         }
         return _loc1_;
      }
      
      private function createImage(param1:Clip) : DisplayObject
      {
         var _loc2_:Rectangle = Scale9DataExtension.fromAsset(param1.resource).getGridByClip(param1);
         if(_loc2_)
         {
            if(_loc2_.height == 0)
            {
               return new Scale3Image(ClipImageTextureFactory.getScale3Texture(param1,_loc2_.x / slider.clip.invertedResolution,_loc2_.width / param1.invertedResolution));
            }
            if(_loc2_.width == 0)
            {
               return new Scale3Image(ClipImageTextureFactory.getScale3Texture(param1,_loc2_.y / param1.invertedResolution,_loc2_.height / param1.invertedResolution,"vertical"));
            }
            return new Scale9Image(ClipImageTextureFactory.getScale9Texture(param1,_loc2_));
         }
         return new Image(ClipImageCache.getClipTexture(param1));
      }
   }
}

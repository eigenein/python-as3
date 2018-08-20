package game.view.popup.mission
{
   import com.progrestar.framework.ares.core.Node;
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.GuiClipLayoutContainer;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class MissionStarDisplay extends GuiClipLayoutContainer
   {
       
      
      private var starImages:Vector.<Image>;
      
      public function MissionStarDisplay()
      {
         starImages = new Vector.<Image>();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc3_:LayoutGroup = _container as LayoutGroup;
         var _loc2_:HorizontalLayout = new HorizontalLayout();
         _loc3_.layout = _loc2_;
         _loc2_.horizontalAlign = "center";
         _loc2_.verticalAlign = "middle";
      }
      
      public function setValue(param1:int, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = starImages.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _container.removeChild(starImages[_loc5_]);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            _loc3_ = new Image(param1 > _loc5_?AssetStorage.rsx.popup_theme.getTexture("bigstarIcon"):AssetStorage.rsx.popup_theme.getTexture("bigstaremptyIcon"));
            starImages[_loc5_] = _loc3_;
            _container.addChild(_loc3_);
            _loc5_++;
         }
      }
   }
}

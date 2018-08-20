package game.view.popup.hero.rune
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.rune.PlayerHeroRuneValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.DataClipButton;
   import starling.filters.ColorMatrixFilter;
   
   public class RuneItemClip extends DataClipButton
   {
       
      
      protected var _data:PlayerHeroRuneValueObject;
      
      private var disabledFilter:ColorMatrixFilter;
      
      public var image_container:ClipLayout;
      
      public var tf_level:ClipLabel;
      
      public var lock_icon:ClipSprite;
      
      public function RuneItemClip()
      {
         image_container = createIconContainer();
         super(PlayerHeroRuneValueObject);
      }
      
      public function dispose() : void
      {
         if(disabledFilter)
         {
            disabledFilter.dispose();
         }
      }
      
      public function get data() : PlayerHeroRuneValueObject
      {
         return _data;
      }
      
      public function setData(param1:PlayerHeroRuneValueObject) : void
      {
         var _loc3_:Boolean = param1 == null || param1.locked;
         var _loc2_:Boolean = param1 && param1.level > 0;
         if(!_loc3_)
         {
            tf_level.text = param1.level + "/" + param1.levelCap;
         }
         updateFilter(_loc3_,_loc2_);
         tf_level.visible = !_loc3_;
         lock_icon.graphics.visible = _loc3_;
         if(param1)
         {
            image_container.removeChildren(0,-1,true);
            setupIcon(param1);
         }
         this._data = param1;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         disabledFilter = AssetStorage.rsx.popup_theme.filter_disabled;
         image_container.graphics.filter = null;
      }
      
      override protected function getClickData() : *
      {
         return _data;
      }
      
      protected function createIconContainer() : ClipLayout
      {
         return ClipLayout.none();
      }
      
      protected function setupIcon(param1:PlayerHeroRuneValueObject) : void
      {
         image_container.addChild(param1.createIconSprite().graphics);
      }
      
      protected function updateFilter(param1:Boolean, param2:Boolean) : void
      {
         if(param2)
         {
            image_container.graphics.alpha = 1;
            image_container.graphics.filter = null;
         }
         else if(param1)
         {
            image_container.graphics.alpha = 1;
            image_container.graphics.filter = disabledFilter;
         }
         else
         {
            image_container.graphics.alpha = 1;
            image_container.graphics.filter = null;
         }
      }
   }
}

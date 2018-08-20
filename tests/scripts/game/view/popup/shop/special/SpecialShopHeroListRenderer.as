package game.view.popup.shop.special
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.model.user.shop.SpecialShopHeroListValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   import idv.cjcat.signals.Signal;
   
   public class SpecialShopHeroListRenderer extends ListItemRenderer
   {
       
      
      protected var clip:SpecialShopMiniHeroListItemClip;
      
      private var _signal_select:Signal;
      
      public function SpecialShopHeroListRenderer()
      {
         super();
         _signal_select = new Signal(SpecialShopHeroListRenderer);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         clip.data = null;
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      override public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      override public function set isSelected(param1:Boolean) : void
      {
         if(_isSelected == param1)
         {
            return;
         }
         _isSelected = param1;
         setSelected();
      }
      
      protected function setSelected() : void
      {
         if(!clip)
         {
            return;
         }
         clip.glow_select.graphics.visible = _isSelected;
         AssetStorage.rsx.popup_theme.setDisabledFilter(clip.image_item.graphics,!_isSelected);
         AssetStorage.rsx.popup_theme.setDisabledFilter(clip.image_bg.graphics,!_isSelected);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = createClip();
         clip.signal_click.add(handler_click);
         addChild(clip.graphics);
         width = clip.image_frame.graphics.width;
         height = clip.image_frame.graphics.height;
         setSelected();
      }
      
      protected function createClip() : SpecialShopMiniHeroListItemClip
      {
         return AssetStorage.rsx.popup_theme.create_special_shop_hero_mini_item();
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:SpecialShopHeroListValueObject = data as SpecialShopHeroListValueObject;
         if(_loc1_)
         {
            clip.data = _loc1_.playerHeroListVO;
         }
      }
      
      private function handler_click(param1:UnitEntryValueObject) : void
      {
         if(!_isSelected)
         {
            isSelected = true;
            _signal_select.dispatch(this);
         }
      }
   }
}

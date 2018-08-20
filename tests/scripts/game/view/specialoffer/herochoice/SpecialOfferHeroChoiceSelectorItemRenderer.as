package game.view.specialoffer.herochoice
{
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class SpecialOfferHeroChoiceSelectorItemRenderer extends ListItemRenderer
   {
       
      
      private var clip:SpecialOfferHeroChoiceSelectorItemRendererClip;
      
      public function SpecialOfferHeroChoiceSelectorItemRenderer()
      {
         super();
      }
      
      override public function get height() : Number
      {
         if(clip)
         {
            return clip.bg.graphics.height;
         }
         return NaN;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(SpecialOfferHeroChoiceSelectorItemRendererClip,"specialOfferHeroChoice_item_renderer");
         addChild(clip.graphics);
         clip.bg.signal_click.add(handler_onClick);
         clip.bg_selected.graphics.touchable = false;
      }
      
      override protected function commitData() : void
      {
         var _loc1_:SpecialOfferHeroChoiceHeroValueObject = _data as SpecialOfferHeroChoiceHeroValueObject;
         if(_loc1_)
         {
            clip.setUnit(_loc1_.unit);
            clip.setPlayerHas(_loc1_.isPlayerUnit);
         }
      }
      
      override protected function draw() : void
      {
         if(isInvalid("selected"))
         {
            clip.bg_selected.graphics.visible = isSelected;
         }
         super.draw();
      }
      
      private function handler_onClick() : void
      {
         isSelected = true;
      }
   }
}

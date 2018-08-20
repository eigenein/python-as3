package game.view.popup.hero.consumable
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class HeroUseXPConsumableNotEnoughPopupClip extends PopupClipBase
   {
       
      
      public var tf_header:ClipLabel;
      
      public var tf_message:ClipLabel;
      
      public var tf_shop:ClipLabel;
      
      public var tf_missions:ClipLabel;
      
      public var button_shop:ClipButtonLabeled;
      
      public var button_missions:ClipButtonLabeled;
      
      public function HeroUseXPConsumableNotEnoughPopupClip()
      {
         tf_header = new ClipLabel();
         tf_message = new ClipLabel();
         tf_shop = new ClipLabel(true);
         tf_missions = new ClipLabel(true);
         super();
      }
   }
}

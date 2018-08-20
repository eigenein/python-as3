package game.view.specialoffer.energyspent
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.ClipLabel;
   
   public class SpecialOfferEnergySpentTimerClip extends GuiClipNestedContainer
   {
      
      private static const CLIP:String = "special_offer_energyspent_timer_panel";
       
      
      public var tf_header:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var tf_till_over:ClipLabel;
      
      public var tf_timer:ClipLabel;
      
      public function SpecialOfferEnergySpentTimerClip()
      {
         super();
         AssetStorage.rsx.popup_theme.initGuiClip(this,"special_offer_energyspent_timer_panel");
      }
   }
}

package game.view.specialoffer.energyspent
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.ClipLabel;
   
   public class SpecialOfferEnergySpentLimitClip extends GuiClipNestedContainer
   {
      
      private static const CLIP:String = "special_offer_energyspent_limit_panel";
       
      
      public var tf_header:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var tf_progress:ClipLabel;
      
      public function SpecialOfferEnergySpentLimitClip()
      {
         super();
         AssetStorage.rsx.popup_theme.initGuiClip(this,"special_offer_energyspent_limit_panel");
      }
   }
}

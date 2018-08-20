package game.view.specialoffer.energyspent
{
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   
   public class SpecialOfferEnergySpentRewardBackground extends ClipSprite
   {
       
      
      public function SpecialOfferEnergySpentRewardBackground()
      {
         super();
         AssetStorage.rsx.popup_theme.initGuiClip(this,"special_offer_energyspent_reward_background");
      }
   }
}

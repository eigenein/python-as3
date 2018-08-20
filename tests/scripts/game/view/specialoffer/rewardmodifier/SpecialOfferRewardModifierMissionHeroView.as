package game.view.specialoffer.rewardmodifier
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.model.user.specialoffer.PlayerSpecialOfferRewardModifier;
   import game.view.gui.components.ClipLabel;
   
   public class SpecialOfferRewardModifierMissionHeroView extends GuiClipNestedContainer
   {
       
      
      private var data:PlayerSpecialOfferRewardModifier;
      
      public var tf_multiplier:ClipLabel;
      
      public var tf_event:ClipLabel;
      
      public function SpecialOfferRewardModifierMissionHeroView(param1:PlayerSpecialOfferRewardModifier)
      {
         super();
         AssetStorage.rsx.popup_theme.initGuiClip(this,"special_offer_rewardmodifier_mission_fragmenthero");
         setData(param1);
      }
      
      public function dispose() : void
      {
         setData(null);
         if(graphics.parent)
         {
            graphics.parent.removeChild(graphics);
         }
         graphics.dispose();
      }
      
      public function setData(param1:PlayerSpecialOfferRewardModifier) : void
      {
         if(param1)
         {
            param1.signal_removed.remove(handler_removed);
         }
         this.data = param1;
         tf_event.text = Translate.translate("UI_SPECIALOFFER_EVENT");
         if(param1)
         {
            param1.signal_removed.add(handler_removed);
            tf_multiplier.text = "x" + param1.maxMultiplier;
         }
      }
      
      private function handler_removed() : void
      {
         dispose();
      }
   }
}

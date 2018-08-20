package game.view.popup.fightresult.pve
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.component.RewardHeroExpDisplayValueObject;
   import game.view.popup.fightresult.RewardDialogHeroItemRendererBase;
   import idv.cjcat.signals.Signal;
   
   public class MissionRewardPopupHeroExpListItemRenderer extends RewardDialogHeroItemRendererBase
   {
       
      
      private var _signal_levelUp:Signal;
      
      public function MissionRewardPopupHeroExpListItemRenderer()
      {
         _signal_levelUp = new Signal(MissionRewardPopupHeroExpListItemRenderer);
         super();
      }
      
      public function get signal_levelUp() : Signal
      {
         return _signal_levelUp;
      }
      
      override protected function createPanelClip() : void
      {
         panel_clip = AssetStorage.rsx.popup_theme.create_hero_list_panel();
         addChild(panel_clip.graphics);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:RewardHeroExpDisplayValueObject = data as RewardHeroExpDisplayValueObject;
         if(_loc1_)
         {
            portrait.data = _loc1_;
            _loc1_.signal_xpUpdate.add(handler_xpUpdate);
            _loc1_.signal_levelUp.add(handler_levelUp);
            handler_xpUpdate();
         }
      }
      
      private function handler_xpUpdate() : void
      {
         var _loc1_:RewardHeroExpDisplayValueObject = data as RewardHeroExpDisplayValueObject;
         (panel_clip as MissionRewardDialogHeroPanel).hero_panel_progressbar_inst0.value = _loc1_.currentXPPercent;
         if(_loc1_.rewardExp)
         {
            panel_clip.tf_hero_name.text = Translate.translate("UI_DIALOG_MISSION_REWARD_EXP") + " +" + _loc1_.rewardExp;
         }
         else
         {
            panel_clip.tf_hero_name.text = "";
         }
         portrait.update_level();
      }
      
      private function handler_levelUp() : void
      {
         _signal_levelUp.dispatch(this);
      }
   }
}

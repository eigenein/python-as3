package game.view.popup.reward.multi
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.mission.RaidRewardValueObject;
   
   public class RaidRewardRenderer extends MultiRewardRenderer
   {
       
      
      public function RaidRewardRenderer()
      {
         super();
      }
      
      override protected function createClip() : void
      {
         clip = AssetStorage.rsx.popup_theme.create_renderer_multi_reward();
         addChild(clip.graphics);
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:* = null;
         .super.data = param1;
         if(param1)
         {
            _loc2_ = param1 as RaidRewardValueObject;
            if(_loc2_.index == -1)
            {
               clip.tf_caption.text = Translate.translateArgs("UI_POPUP_RAID_REWARD_BONUS");
            }
            else
            {
               clip.tf_caption.text = Translate.translateArgs("UI_POPUP_RAID_REWARD_BATTLE",_loc2_.index);
            }
         }
      }
   }
}

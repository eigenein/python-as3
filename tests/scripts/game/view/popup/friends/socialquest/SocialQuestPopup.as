package game.view.popup.friends.socialquest
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.friends.socialquest.SocialQuestPopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.ClipBasedPopup;
   
   public class SocialQuestPopup extends ClipBasedPopup
   {
       
      
      private var mediator:SocialQuestPopupMediator;
      
      private var clip:SocialQuestPopupClip;
      
      public function SocialQuestPopup(param1:SocialQuestPopupMediator)
      {
         super(param1);
         stashParams.windowName = "social_quest";
         this.mediator = param1;
      }
      
      override public function close() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = 3;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = clip.reward_block["quest_reward_" + (_loc3_ + 1)] as RewardItemClip;
            _loc1_.dispose();
            _loc3_++;
         }
         super.close();
      }
      
      override public function dispose() : void
      {
         mediator.signal_updateFarmAvailable.remove(handler_updateFarmButton);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(SocialQuestPopupClip,"dialog_social_quest");
         addChild(clip.graphics);
         clip.title = Translate.translate("LIB_QUEST_TRANSLATE_SOCIALQUEST");
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.button_close.signal_click.add(close);
         var _loc4_:int = 4;
         _loc5_ = 1;
         while(_loc5_ <= _loc4_)
         {
            _loc2_ = clip["task_" + _loc5_] as SocialQuestPopupTaskPanel;
            if(_loc2_)
            {
               if(mediator.data.length > _loc5_ - 1)
               {
                  _loc2_.setData(mediator.data[_loc5_ - 1]);
               }
               else
               {
                  _loc2_.graphics.visible = false;
               }
            }
            _loc5_++;
         }
         var _loc1_:Vector.<InventoryItem> = mediator.questReward;
         _loc4_ = 3;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = clip.reward_block["quest_reward_" + (_loc5_ + 1)] as RewardItemClip;
            if(_loc1_.length > _loc5_)
            {
               _loc3_.data = _loc1_[_loc5_];
            }
            else
            {
               _loc3_.graphics.visible = false;
            }
            _loc5_++;
         }
         clip.tf_gem_amount.text = Translate.translate("UI_DIALOG_SOCIAL_QUEST_REWARD");
         clip.button_farm.label = Translate.translate("UI_DIALOG_SOCIAL_QUEST_FARM");
         clip.button_farm.signal_click.add(handler_farmClick);
         mediator.signal_updateFarmAvailable.add(handler_updateFarmButton);
         handler_updateFarmButton();
      }
      
      private function handler_farmClick() : void
      {
         mediator.action_farm();
      }
      
      private function handler_updateFarmButton() : void
      {
         var _loc1_:* = mediator.canFarm;
         clip.button_farm.isEnabled = _loc1_;
         clip.button_farm.glow = _loc1_;
         clip.button_farm.graphics.alpha = !!mediator.canFarm?1:0;
         clip.resize();
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
      }
   }
}

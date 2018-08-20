package game.mechanics.dungeon.popup.reward
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.dungeon.mediator.DungeonRewardPopupMediator;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class DungeonRewardPopup extends ClipBasedPopup
   {
       
      
      private var clip:DungeonRewardPopupClip;
      
      private var mediator:DungeonRewardPopupMediator;
      
      public function DungeonRewardPopup(param1:DungeonRewardPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.dungeon_floors.create(DungeonRewardPopupClip,"popup_reward") as DungeonRewardPopupClip;
         addChild(clip.graphics);
         clip.tf_header.text = Translate.translate("UI_DIALOG_DUNGEON_SAVE_POINT_ACTIVATED");
         clip.floor_number.text = String(mediator.floorNumber);
         clip.floor_number.adjustSizeToFitWidth();
         clip.tf_description.text = Translate.translateArgs("UI_DIALOG_DUNGEON_SAVE_POINT_DESCRIPTION",mediator.floorNumber);
         clip.tf_label_reward.text = Translate.translate("UI_POPUP_QUEST_REWARD_LABEL");
         clip.button_ok.label = Translate.translate("UI_POPUP_QUEST_REWARD_BUTTON_LABEL");
         clip.button_ok.signal_click.add(close);
         var _loc2_:int = 3;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = clip["list_item_" + (_loc3_ + 1)];
            if(_loc1_)
            {
               if(mediator.reward.length > _loc3_)
               {
                  _loc1_.setData(mediator.reward[_loc3_]);
               }
               else
               {
                  _loc1_.graphics.visible = false;
               }
            }
            _loc3_++;
         }
         AssetStorage.sound.dailyBonus.play();
      }
   }
}

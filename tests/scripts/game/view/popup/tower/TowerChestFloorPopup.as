package game.view.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import game.data.reward.RewardData;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.mediator.gui.popup.tower.TowerChestFloorPopupMediator;
   import game.mediator.gui.popup.tower.TowerChestValueObject;
   import game.view.popup.ClipBasedPopup;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class TowerChestFloorPopup extends ClipBasedPopup
   {
       
      
      private const clip:TowerChestFloorPopupClip = AssetStorage.rsx.tower_floors.create(TowerChestFloorPopupClip,"dialog_tower_chest_floor");
      
      private var mediator:TowerChestFloorPopupMediator;
      
      public function TowerChestFloorPopup(param1:TowerChestFloorPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = clip.chest;
         for each(var _loc1_ in clip.chest)
         {
            _loc1_.dispose();
         }
         mediator = null;
         super.dispose();
      }
      
      override public function close() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = true;
         _loc1_ = 0;
         while(_loc1_ < mediator.chests.length)
         {
            if(clip.chest[_loc1_].opening_timer_item.running)
            {
               _loc2_ = false;
               break;
            }
            _loc1_++;
         }
         if(_loc2_)
         {
            super.close();
         }
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         super.initialize();
         addChild(clip.graphics);
         width = 1000;
         height = 640;
         clip.tf_header.text = Translate.translate("UI_POPUP_TOWER_CHESTS_TITLE");
         clip.button_close.signal_click.add(close);
         clip.button_proceed.signal_click.add(mediator.action_nextFloor);
         clip.button_proceed_chestsLeft.signal_click.add(mediator.action_nextFloor);
         var _loc3_:Vector.<TowerChestValueObject> = mediator.chests;
         var _loc1_:int = _loc3_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            clip.chest[_loc2_].opening_timer_item.addEventListener("timer",handler_updateVisibleReward);
            clip.chest[_loc2_].setData(_loc3_[_loc2_]);
            _loc2_++;
         }
         handler_updateVisibleReward();
         var _loc4_:Vector.<RewardData> = mediator.rewards;
         clip.chest_content.item_reward_1.data = _loc4_[0].outputDisplay[0];
         clip.chest_content.item_reward_2.data = _loc4_[1].outputDisplay[0];
         clip.chest_content.item_reward_3.data = _loc4_[2].outputDisplay[0];
         clip.chest_content.item_reward_3.item_counter.graphics.visible = false;
         clip.chest_content.tf_reward_desc.text = Translate.translate("UI_POPUP_TOWER_REWARDS_DESC");
         clip.chest_content.tf_label_reward_1.text = Translate.translate("LIB_PSEUDO_COIN");
         clip.chest_content.tf_label_reward_2.text = Translate.translate("LIB_COIN_NAME_3");
         clip.chest_content.tf_label_reward_3.text = Translate.translate("UI_POPUP_TOWER_CHESTS_RANDOM_ITEM");
         if(mediator.isMaxFloor)
         {
            clip.tf_footer.text = Translate.translate("UI_POPUP_TOWER_CHEST_FOOTER_LAST");
         }
         else
         {
            clip.tf_footer.text = Translate.translate("UI_POPUP_TOWER_CHEST_FOOTER");
         }
         if(mediator.playerVipLevel < mediator.goldBonus_vipLevel)
         {
            clip.chest_content.tf_label_vip_status.text = ColorUtils.hexToRGBFormat(11220276) + Translate.translate("UI_POPUP_TOWER_VIP_NOT_ACTIVE");
         }
         else
         {
            clip.chest_content.tf_label_vip_status.text = ColorUtils.hexToRGBFormat(15919178) + Translate.translate("UI_POPUP_TOWER_VIP_ACTIVE");
         }
         clip.chest_content.tf_label_vip6_text.text = Translate.translateArgs("UI_POPUP_TOWER_VIP6_TEXT","^{sprite:vip_6}^");
         clip.chest_content.tf_label_vip_reward_gold.text = "+" + mediator.goldBonus_value;
         clip.chest_content.tf_label_vip_reward_gold.validate();
         clip.button_proceed.label = Translate.translate("UI_TOWER_PROCEED");
         clip.button_proceed_chestsLeft.label = Translate.translate("UI_TOWER_PROCEED");
      }
      
      private function setupCheckAnimation(param1:GuiAnimation, param2:Boolean) : void
      {
         if(param2)
         {
            if(!param1.graphics.visible)
            {
               param1.playOnce();
               param1.graphics.visible = true;
            }
            else
            {
               param1.gotoAndStop(param1.lastFrame);
            }
         }
         else
         {
            param1.gotoAndStop(0);
            param1.graphics.visible = false;
         }
      }
      
      private function handler_updateVisibleReward(param1:* = null) : void
      {
         var _loc7_:int = 0;
         var _loc2_:* = null;
         if(!mediator)
         {
            return;
         }
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc8_:Vector.<TowerChestValueObject> = mediator.chests;
         var _loc3_:int = _loc8_.length;
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc2_ = _loc8_[_loc7_];
            if(_loc2_.opened)
            {
               if(_loc2_.reward.gold > 0)
               {
                  _loc4_ = true;
               }
               else if(!_loc2_.reward.inventoryCollection.getCollectionByType(InventoryItemType.COIN).isEmpty())
               {
                  _loc5_ = true;
               }
               else
               {
                  _loc6_ = true;
               }
            }
            _loc7_++;
         }
         if((!_loc4_ || !_loc6_ || !_loc5_) && mediator.canProceed)
         {
            clip.button_proceed_chestsLeft.graphics.visible = true;
         }
         else
         {
            clip.button_proceed_chestsLeft.graphics.visible = false;
         }
         if(_loc4_ && _loc5_ && _loc6_ && mediator.canProceed)
         {
            clip.chest_content.graphics.visible = false;
            clip.button_proceed.graphics.visible = true;
            clip.button_close.graphics.visible = false;
         }
         else
         {
            clip.button_close.graphics.visible = true;
            clip.button_proceed.graphics.visible = false;
            setupCheckAnimation(clip.chest_content.icon_check_coin,_loc5_);
            setupCheckAnimation(clip.chest_content.icon_check_gold,_loc4_);
            setupCheckAnimation(clip.chest_content.icon_check_item,_loc6_);
         }
      }
   }
}

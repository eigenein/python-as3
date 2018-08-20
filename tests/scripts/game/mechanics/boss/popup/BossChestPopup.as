package game.mechanics.boss.popup
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiMarker;
   import flash.geom.Point;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.hero.UnitDescription;
   import game.mechanics.boss.mediator.BossChestPopupMediator;
   import game.mechanics.boss.mediator.BossChestPopupValueObject;
   import game.mechanics.boss.model.BossPossibleRewardValueObject;
   import game.mechanics.boss.model.CommandBossOpenChest;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.tooltip.InventoryItemInfoTooltip;
   import game.view.popup.AsyncClipBasedPopup;
   import game.view.popup.inventory.PlayerInventoryItemTile;
   import starling.core.Starling;
   
   public class BossChestPopup extends AsyncClipBasedPopup
   {
       
      
      private var mediator:BossChestPopupMediator;
      
      private var clip:BossChestPopupClip;
      
      private var chestController:BossChestPopupChestController;
      
      private var dropLayer:BossFlyingDropLayer;
      
      private var heroTooltipVO:TooltipVO;
      
      private var newPossibleDrop:BossPossibleRewardValueObject = null;
      
      private var newCost:CostData = null;
      
      public function BossChestPopup(param1:BossChestPopupMediator)
      {
         heroTooltipVO = new TooltipVO(InventoryItemInfoTooltip,null);
         this.mediator = param1;
         super(param1,AssetStorage.rsx.dialog_boss);
      }
      
      override public function dispose() : void
      {
         mediator.chestCost.unsubscribe(handler_chestCost);
         mediator.possibleReward.unsubscribe(handler_chestRewardUpdated);
         mediator.signal_chestOpened.remove(handler_chestOpened);
         mediator = null;
         chestController.dispose();
         TooltipHelper.removeTooltip(clip.chest_content.item_reward_1.graphics);
         TooltipHelper.removeTooltip(clip.chest_content.item_reward_2.graphics);
         TooltipHelper.removeTooltip(clip.chest_content.item_reward_3.graphics);
         if(dropLayer)
         {
            dropLayer.dispose();
         }
         super.dispose();
      }
      
      public function get animationAlpha() : Number
      {
         return clip.button_text.graphics.alpha;
      }
      
      public function set animationAlpha(param1:Number) : void
      {
         var _loc2_:* = param1;
         clip.buttons_layout_group.alpha = _loc2_;
         _loc2_ = _loc2_;
         clip.labels_layout_group.alpha = _loc2_;
         clip.button_text.graphics.alpha = _loc2_;
         clip.chest_content.graphics.alpha = param1;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = param1.create(BossChestPopupClip,"dialog_boss_chest");
         addChild(clip.graphics);
         dropLayer = new BossFlyingDropLayer(1.4);
         addChild(dropLayer.graphics);
         width = Starling.current.stage.stageWidth;
         height = Starling.current.stage.stageHeight;
         clip.tf_header.text = Translate.translate("UI_POPUP_TOWER_CHESTS_TITLE");
         clip.chest_content.tf_reward_desc.text = Translate.translate("UI_POPUP_TOWER_REWARDS_DESC");
         clip.tf_footer.text = Translate.translate("UI_DIALOG_BOSS_CHESTS_DESCRIPTION");
         clip.tf_open_single.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACT_CHEST_OPEN_SINGLE");
         clip.tf_open_pack.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACT_CHEST_OPEN_PACK");
         clip.button_cost_pack.cost = mediator.chestPackCost.outputDisplayFirst;
         clip.bonus_clip.tf_text.text = "+5 " + Translate.translate("UI_SOCIAL_QUEST_FREE").toLowerCase();
         clip.button_close.signal_click.add(mediator.close);
         clip.button_cost.signal_click.add(handler_click);
         clip.button_cost_pack.signal_click.add(handler_click_pack);
         clip.button_text.initialize(Translate.translate("UI_DIALOG_BOSS_CHEST_OPEN"),handler_click);
         initChests();
         mediator.chestCost.onValue(handler_chestCost);
         mediator.possibleReward.onValue(handler_chestRewardUpdated);
         mediator.signal_chestOpened.add(handler_chestOpened);
         updatePossibleDrop();
         updateCost();
      }
      
      private function setPossibleDrop(param1:PlayerInventoryItemTile, param2:ClipLabel, param3:InventoryItem) : void
      {
         if(param3 == null)
         {
            param1.graphics.visible = false;
            param2.visible = false;
            return;
         }
         param1.graphics.visible = true;
         param2.visible = true;
         param1.signal_click.clear();
         if(param3.item is UnitDescription)
         {
            param1.signal_click.add(mediator.action_hero);
            heroTooltipVO.hintData = new InventoryItem(param3.item as UnitDescription);
            TooltipHelper.addTooltip(param1.graphics,heroTooltipVO);
            param1.graphics.touchable = true;
         }
         else
         {
            param1.graphics.touchable = false;
         }
         param1.data = param3;
         param2.text = param3.name;
      }
      
      override public function close() : void
      {
         if(!chestController.inMotion.value)
         {
            super.close();
         }
      }
      
      private function initChests() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc3_:Vector.<GuiMarker> = clip.chest_left.reverse().concat(clip.chest);
         chestController = new BossChestPopupChestController(_loc3_,clip.cloud);
         clip.container.addChildAt(chestController.container,4);
         chestController.inMotion.onValue(handler_chestsIsLocked);
         _loc2_ = -2;
         while(_loc2_ <= 4)
         {
            _loc1_ = mediator.getNextChestValueObject(_loc2_);
            if(_loc1_ != null)
            {
               chestController.addChest(_loc1_,_loc2_ == 1);
            }
            _loc2_++;
         }
         chestController.setCurrent(mediator.chestNum,false);
      }
      
      private function updatePossibleDrop() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         if(newPossibleDrop.oneItem)
         {
            clip.button_text.guiClipLabel.text = Translate.translate("UI_DIALOG_BOSS_CHEST_GET");
            clip.chest_content.tf_reward_desc.text = Translate.translate("UI_DIALOG_BOSS_REWARDS_DESC");
            _loc3_ = null;
            _loc2_ = null;
            _loc1_ = newPossibleDrop.possibleRewardItem1;
         }
         else
         {
            clip.button_text.guiClipLabel.text = Translate.translate("UI_DIALOG_BOSS_CHEST_OPEN");
            clip.chest_content.tf_reward_desc.text = Translate.translate("UI_POPUP_TOWER_REWARDS_DESC");
            _loc2_ = newPossibleDrop.possibleRewardItem1;
            _loc3_ = newPossibleDrop.possibleRewardItem2;
            _loc1_ = null;
         }
         setPossibleDrop(clip.chest_content.item_reward_1,clip.chest_content.tf_label_reward_1,_loc2_);
         setPossibleDrop(clip.chest_content.item_reward_2,clip.chest_content.tf_label_reward_2,_loc3_);
         setPossibleDrop(clip.chest_content.item_reward_3,clip.chest_content.tf_label_reward_3,_loc1_);
         newPossibleDrop = null;
      }
      
      private function updateCost() : void
      {
         if(newCost.isEmpty)
         {
            newCost = null;
         }
         var _loc1_:Boolean = false;
         var _loc2_:* = newCost && !_loc1_;
         clip.labels_layout_group.visible = _loc2_;
         clip.buttons_layout_group.visible = _loc2_;
         clip.button_text.graphics.visible = !newCost && !_loc1_;
         _loc2_ = mediator.chestId.value >= mediator.chestRepeatFromId;
         clip.tf_open_pack.visible = _loc2_;
         clip.button_cost_pack.graphics.visible = _loc2_;
         clip.bonus_clip.graphics.visible = clip.buttons_layout_group.visible && clip.button_cost_pack.graphics.visible;
         if(newCost)
         {
            clip.button_cost.cost = newCost.outputDisplay[0];
         }
         newCost = null;
      }
      
      private function handler_click() : void
      {
         mediator.action_open();
      }
      
      private function handler_click_pack() : void
      {
         mediator.action_open(mediator.chestPackAmount);
      }
      
      private function handler_chestsIsLocked(param1:Boolean) : void
      {
         var _loc2_:* = !param1;
         clip.button_text.graphics.touchable = _loc2_;
         clip.buttons_layout_group.touchable = _loc2_;
         if(param1)
         {
            animationAlpha = 1;
            Starling.juggler.tween(this,0.4,{"animationAlpha":0.5});
         }
         else
         {
            animationAlpha = 0.5;
            Starling.juggler.tween(this,0.4,{"animationAlpha":1});
            if(newCost)
            {
               updateCost();
            }
            if(newPossibleDrop)
            {
               updatePossibleDrop();
               clip.chest_content.tintIntensity = 1;
               Starling.juggler.tween(clip.chest_content,0.5,{
                  "tintIntensity":0,
                  "delay":0.2
               });
            }
         }
      }
      
      private function handler_chestOpened(param1:CommandBossOpenChest) : void
      {
         var _loc2_:BossChestPopupValueObject = mediator.getNextChestValueObject(4);
         param1.signal_rewardTaken.add(handler_rewardSpawned);
         chestController.addChest(_loc2_,false);
         chestController.setChestOpened(param1);
         if(param1.rewardList.length == 1)
         {
            chestController.setCurrent(param1.chestNum + 1,true);
         }
      }
      
      private function handler_chestCost(param1:CostData) : void
      {
         newCost = param1;
      }
      
      private function handler_chestRewardUpdated(param1:BossPossibleRewardValueObject) : void
      {
         newPossibleDrop = param1;
      }
      
      private function handler_rewardSpawned(param1:RewardData) : void
      {
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc11_:* = NaN;
         var _loc2_:* = NaN;
         var _loc20_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc17_:* = NaN;
         var _loc18_:* = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:* = NaN;
         var _loc6_:Number = NaN;
         var _loc3_:* = NaN;
         var _loc7_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc9_:* = NaN;
         var _loc16_:* = NaN;
         var _loc15_:Number = NaN;
         var _loc10_:Point = new Point(500,230);
         _loc8_ = 0;
         while(_loc8_ < param1.outputDisplay.length)
         {
            _loc4_ = param1.outputDisplay[_loc8_];
            if(_loc4_.item is UnitDescription)
            {
               _loc5_ = _loc4_.amount;
            }
            else
            {
               _loc5_ = Math.log(_loc4_.amount) * 5.5;
            }
            _loc11_ = -2.67035375555132;
            _loc2_ = -0.471238898038469;
            _loc20_ = (_loc2_ - _loc11_) / (_loc5_ + 1.0001);
            _loc11_ = Number(_loc11_ + _loc20_);
            _loc2_ = Number(_loc2_ - _loc20_);
            _loc12_ = _loc20_ * 2;
            _loc17_ = _loc11_;
            _loc18_ = 0;
            _loc13_ = 1 - _loc18_ * _loc5_;
            _loc14_ = 0;
            _loc6_ = 0.25 / (_loc5_ + 1.0001);
            _loc3_ = _loc11_;
            while(_loc3_ <= _loc2_)
            {
               _loc7_ = Math.cos(_loc17_);
               _loc19_ = Math.sin(_loc17_);
               _loc17_ = Number(_loc17_ + Math.random() * _loc12_);
               _loc9_ = 20;
               _loc14_ = Number(_loc14_ + _loc6_);
               _loc16_ = Number(_loc14_ + Math.random() * 0.3 - 0.15);
               if(_loc16_ < 0)
               {
                  _loc16_ = 0;
               }
               _loc15_ = 120 * (0.3 + Math.random() * 0.8);
               dropLayer.addChestItem(_loc10_.x + _loc9_ * _loc7_,_loc10_.y + _loc9_ * _loc19_,_loc4_,_loc15_ * _loc7_,_loc15_ * _loc19_ * 1.2,_loc16_,_loc13_);
               _loc13_ = _loc13_ + _loc18_;
               _loc3_ = Number(_loc3_ + _loc20_);
            }
            _loc8_++;
         }
      }
   }
}

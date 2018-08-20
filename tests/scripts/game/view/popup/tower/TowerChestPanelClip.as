package game.view.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.tower.TowerChestValueObject;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.chest.SoundGuiAnimation;
   import game.view.popup.refillable.CostButton;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class TowerChestPanelClip extends GuiClipNestedContainer
   {
       
      
      private var data:TowerChestValueObject;
      
      private var opening_timer:Timer;
      
      public const opening_timer_item:Timer = new Timer(800,1);
      
      public var tf_vip_required:SpecialClipLabel;
      
      public var vip_required_line_top:ClipSprite;
      
      public var vip_required_line_bottom:ClipSprite;
      
      public var button_text:ClipButtonLabeled;
      
      public var button_cost:CostButton;
      
      public var chest_opened:GuiAnimation;
      
      public var chest_closed:GuiAnimation;
      
      public var chest_opening:SoundGuiAnimation;
      
      public var marker_chest:GuiClipContainer;
      
      public var marker_chest_opened:GuiClipContainer;
      
      public var marker_chest_opening:GuiClipContainer;
      
      public var item_reward:InventoryItemRenderer;
      
      public var crit_mod:TowerChestPanelCritModClip;
      
      public function TowerChestPanelClip()
      {
         opening_timer = new Timer(2800,1);
         tf_vip_required = new SpecialClipLabel();
         vip_required_line_top = new ClipSprite();
         vip_required_line_bottom = new ClipSprite();
         marker_chest = new GuiClipContainer();
         marker_chest_opened = new GuiClipContainer();
         marker_chest_opening = new GuiClipContainer();
         item_reward = new InventoryItemRenderer();
         crit_mod = new TowerChestPanelCritModClip();
         super();
         opening_timer.addEventListener("timer",handler_openingTimer);
         opening_timer_item.addEventListener("timer",handler_itemTimer);
      }
      
      public function dispose() : void
      {
         if(button_text)
         {
            button_text.signal_click.clear();
         }
         if(button_cost)
         {
            button_cost.signal_click.clear();
         }
         if(data)
         {
            unsubscribe();
         }
         opening_timer.stop();
         opening_timer_item.stop();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button_cost.signal_click.add(handler_click);
         button_text.initialize(Translate.translate("UI_POPUP_TOWER_CHEST_OPEN"),handler_click);
         chest_opened = AssetStorage.rsx.tower_floors.create(GuiAnimation,"chest_tower_opened");
         marker_chest_opened.container.addChild(chest_opened.graphics);
         marker_chest_opened.container.touchable = false;
         chest_closed = AssetStorage.rsx.tower_floors.create(GuiAnimation,"chest_tower_idle");
         marker_chest.container.addChild(chest_closed.graphics);
         marker_chest.container.touchable = false;
         chest_opening = AssetStorage.rsx.tower_floors.create(SoundGuiAnimation,"chest_tower_opening");
         marker_chest_opening.container.addChild(chest_opening.graphics);
         marker_chest_opening.container.touchable = false;
      }
      
      public function setData(param1:TowerChestValueObject) : void
      {
         if(this.data)
         {
            unsubscribe();
         }
         this.data = param1;
         subscribe();
         setOpened(param1.opened);
         setCost(param1.costItem);
         tf_vip_required.text = Translate.translateArgs("UI_TOWER_CHEST_THIRD_VIP","^{sprite:vip_" + param1.vipLevel + "}^");
      }
      
      private function setCost(param1:InventoryItem) : void
      {
         var _loc3_:Boolean = data.opened;
         var _loc2_:Boolean = param1;
         button_cost.graphics.visible = _loc2_ && !_loc3_ && !data.vipLocked;
         button_text.graphics.visible = !_loc2_ && !_loc3_ && !data.vipLocked;
         tf_vip_required.visible = data.vipLocked && !_loc3_;
         vip_required_line_top.graphics.visible = data.vipLocked && !_loc3_;
         vip_required_line_bottom.graphics.visible = data.vipLocked && !_loc3_;
         if(_loc2_ && !_loc3_)
         {
            button_cost.cost = param1;
         }
      }
      
      private function setOpened(param1:Boolean) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = !param1;
         button_text.isEnabled = _loc3_;
         button_cost.isEnabled = _loc3_;
         chest_opened.graphics.visible = param1;
         chest_closed.graphics.visible = !param1;
         chest_opening.graphics.visible = false;
         crit_mod.graphics.visible = param1 && data.crit;
         crit_mod.tf_crit_value.text = "x" + data.critValue;
         if(!param1)
         {
            chest_closed.play();
            chest_opened.stop();
            chest_opening.stop();
         }
         else
         {
            chest_closed.stop();
            chest_opened.play();
            chest_opening.stop();
         }
         item_reward.graphics.visible = param1;
         if(param1)
         {
            _loc2_ = data.reward.outputDisplay[0];
            item_reward.setData(_loc2_);
         }
      }
      
      private function subscribe() : void
      {
         data.signal_rewardUpdated.add(handler_updateReward);
         data.signal_costUpdated.add(handler_updateCost);
      }
      
      private function unsubscribe() : void
      {
         data.signal_rewardUpdated.remove(handler_updateReward);
         data.signal_costUpdated.remove(handler_updateCost);
      }
      
      private function handler_click() : void
      {
         if(data)
         {
            data.select();
         }
      }
      
      private function handler_updateReward() : void
      {
         chest_closed.graphics.visible = false;
         chest_closed.stop();
         chest_opening.graphics.visible = true;
         chest_opening.playOnce();
         opening_timer.start();
         opening_timer_item.start();
      }
      
      private function handler_updateCost() : void
      {
         setCost(data.costItem);
      }
      
      protected function handler_itemTimer(param1:TimerEvent) : void
      {
         var _loc2_:* = null;
         if(data)
         {
            item_reward.graphics.visible = data.opened;
            _loc2_ = data.reward.outputDisplay[0];
            item_reward.setData(_loc2_);
            crit_mod.graphics.visible = data && data.crit;
            crit_mod.tf_crit_value.text = "x" + data.critValue;
         }
      }
      
      protected function handler_openingTimer(param1:TimerEvent) : void
      {
         if(data)
         {
            setOpened(data.opened);
         }
      }
   }
}

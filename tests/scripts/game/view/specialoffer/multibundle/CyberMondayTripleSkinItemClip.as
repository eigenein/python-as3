package game.view.specialoffer.multibundle
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.mediator.gui.popup.billing.specialoffer.MultiBundleOfferValueObject;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipButtonLabeledAnimated;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class CyberMondayTripleSkinItemClip extends GuiClipNestedContainer
   {
       
      
      private var mediator:CyberMondayTripleSkinCoinPopupMediator;
      
      private var vo:MultiBundleOfferValueObject;
      
      private var hover:TouchHoverContoller;
      
      private var animation_hover:GuiAnimation;
      
      private var animation_idle:GuiAnimation;
      
      public const tf_label_header:ClipLabel = new ClipLabel(true);
      
      public const layout_header:ClipLayout = ClipLayout.horizontalMiddleCentered(4,tf_label_header);
      
      public const reward_item:Vector.<InventoryItemRenderer> = new Vector.<InventoryItemRenderer>();
      
      public const tf_label_reward:ClipLabel = new ClipLabel();
      
      public const tf_old_price:ClipLabel = new ClipLabel();
      
      public const tf_discount:ClipLabel = new ClipLabel();
      
      public const sprite_cross:ClipSprite = new ClipSprite();
      
      public const container_chest:GuiClipContainer = new GuiClipContainer();
      
      public const tf_bought:ClipLabel = new ClipLabel(true);
      
      public const layout_bought:ClipLayout = ClipLayout.horizontalMiddleCentered(0,tf_bought);
      
      public const button_to_store:ClipButtonLabeledAnimated = new ClipButtonLabeledAnimated();
      
      public function CyberMondayTripleSkinItemClip()
      {
         animation_hover = new GuiAnimation();
         animation_idle = new GuiAnimation();
         super();
         hover = new TouchHoverContoller(container);
         hover.signal_hoverChanger.add(handler_hoverChange);
         animation_hover.signal_completed.add(handler_animationHoverCompleted);
      }
      
      public function dispose() : void
      {
         if(vo)
         {
            unsubscribe(vo,mediator);
         }
      }
      
      public function setIndex(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:CyberMondayTripleSkinCoinMatrixFall = new CyberMondayTripleSkinCoinMatrixFall(container);
         var _loc4_:CyberMondayTripleSkinCoinMatrixFall = new CyberMondayTripleSkinCoinMatrixFall(container);
         var _loc5_:String = "";
         switch(int(param1))
         {
            case 0:
               _loc5_ = "Cybermonday";
               break;
            case 1:
               _loc5_ = "press letters";
               break;
            case 2:
               _loc5_ = "КНПБ";
               break;
            case 3:
               _loc5_ = "CRBD";
         }
         _loc3_ = 0;
         while(_loc3_ < 20)
         {
            _loc2_.setWord(_loc5_,Math.random() * 10,Math.random() * 20);
            _loc3_++;
         }
         var _loc6_:int = 4;
         _loc2_.container.y = _loc6_;
         _loc2_.container.x = _loc6_;
         container.addChildAt(_loc2_.container,0);
         _loc2_.container.alpha = 0.8;
         _loc4_.container.alpha = 0.8;
         _loc4_.container.blendMode = "add";
         container.addChild(_loc4_.container);
      }
      
      public function setData(param1:MultiBundleOfferValueObject, param2:CyberMondayTripleSkinCoinPopupMediator) : void
      {
         var _loc3_:* = 0;
         if(this.vo)
         {
            unsubscribe(this.vo,this.mediator);
         }
         this.vo = param1;
         this.mediator = param2;
         var _loc4_:int = Math.min(param1.reward.length,reward_item.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            reward_item[_loc3_].setData(param1.reward[_loc3_]);
            reward_item[_loc3_].graphics.visible = true;
            _loc3_++;
         }
         _loc3_ = _loc4_;
         while(_loc3_ < reward_item.length)
         {
            reward_item[_loc3_].graphics.visible = false;
            _loc3_++;
         }
         setupCustomGraphics();
         button_to_store.signal_click.add(handler_buy);
         tf_old_price.text = param1.oldPrice;
         button_to_store.label = param1.costStrng;
         param1.isBought.onValue(handler_bought);
         tf_discount.text = Translate.translateArgs("UI_POPUP_BUNDLE_DISCOUNT",param1.discountValue);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_label_reward.text = Translate.translate("UI_POPUP_BUNDLE_REWARD");
         tf_bought.text = Translate.translate("UI_DIALOG_CLAN_REWARDS_TF_LABEL_POINTS_PURCHASED");
      }
      
      protected function setupCustomGraphics() : void
      {
         var _loc1_:int = 0;
         var _loc3_:InventoryItem = null;
         _loc1_ = 0;
         while(_loc1_ < vo.reward.length)
         {
            if(vo.reward[_loc1_].item.type == InventoryItemType.COIN)
            {
               _loc3_ = vo.reward[_loc1_];
               break;
            }
            _loc1_++;
         }
         container_chest.container.removeChildren(0,-1,true);
         if(_loc3_ == null)
         {
            return;
         }
         tf_label_header.text = Translate.translate("UI_SPECIALOFFER_CYBER_MONDAY_COINS_" + _loc3_.id);
         var _loc2_:String = "chest_red";
         switch(int(_loc3_.id) - 8)
         {
            case 0:
               _loc2_ = "chest_pink";
               break;
            case 1:
               _loc2_ = "chest_red";
               break;
            case 2:
               _loc2_ = "chest_blue";
         }
         (mediator.asset.asset as RsxGuiAsset).initGuiClip(animation_idle,_loc2_ + "_idle");
         (mediator.asset.asset as RsxGuiAsset).initGuiClip(animation_hover,_loc2_ + "_hover");
         container_chest.container.addChild(animation_idle.graphics);
         container_chest.container.addChild(animation_hover.graphics);
         animation_idle.show(container_chest.container);
         animation_idle.gotoAndPlay(Math.random() * (animation_idle.lastFrame + 1));
         animation_hover.hide();
         animation_hover.stop();
      }
      
      protected function unsubscribe(param1:MultiBundleOfferValueObject, param2:CyberMondayTripleSkinCoinPopupMediator) : void
      {
         param1.isBought.unsubscribe(handler_bought);
      }
      
      private function handler_bought(param1:Boolean) : void
      {
         var _loc2_:* = !param1;
         button_to_store.graphics.visible = _loc2_;
         _loc2_ = _loc2_;
         tf_old_price.graphics.visible = _loc2_;
         _loc2_ = _loc2_;
         sprite_cross.graphics.visible = _loc2_;
         tf_discount.graphics.visible = _loc2_;
         layout_bought.graphics.visible = param1;
      }
      
      private function handler_buy() : void
      {
         mediator.action_buy(vo);
      }
      
      protected function handler_hoverChange() : void
      {
         if(hover.hover)
         {
            if(!animation_hover.graphics.parent)
            {
               animation_hover.show(container_chest.container);
               animation_hover.playOnce();
               animation_idle.stop();
               animation_idle.hide();
            }
         }
      }
      
      protected function handler_animationHoverCompleted() : void
      {
         if(!animation_idle.graphics.parent)
         {
            animation_idle.show(container_chest.container);
            animation_idle.gotoAndPlay(60);
            animation_hover.hide();
            animation_hover.stop();
         }
      }
   }
}

package game.view.popup.shop.special
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import feathers.layout.VerticalLayout;
   import feathers.textures.Scale3Textures;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.command.timer.GameTimer;
   import game.data.storage.enum.lib.HeroColor;
   import game.mediator.gui.popup.hero.slot.HeroInventorySlotValueObject;
   import game.model.user.shop.SpecialShopHeroListValueObject;
   import game.model.user.shop.SpecialShopSlotValueObject;
   import game.util.TimeFormatter;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.HeroPreview;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.hero.HeroColorNumberClip;
   import starling.core.Starling;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class SpecialShopPopup extends ClipBasedPopup
   {
       
      
      private var mediator:SpecialShopPopupMediator;
      
      private var clip:SpecialShopPopupClip;
      
      private var heroPreview:HeroPreview;
      
      private var inventoryList:Vector.<SpecialShopInventoryItemRenderer>;
      
      private var miniHeroList:SpecialShopMiniHeroList;
      
      private var _swapGroup:SwapGroup;
      
      public function SpecialShopPopup(param1:SpecialShopPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         param1.signal_heroChanged.add(handler_heroChange);
      }
      
      override public function dispose() : void
      {
         GameTimer.instance.oneSecTimer.remove(handler_onGameTimer);
         Starling.juggler.removeTweens(clip.button_promote.graphics);
         mediator.signal_heroChanged.remove(handler_heroChange);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(SpecialShopPopupClip,"dialog_special_shop");
         addChild(clip.graphics);
         var _loc2_:Rectangle = clip.bg_container.graphics.getBounds(clip.bg_container.graphics);
         var _loc3_:ClipSprite = AssetStorage.rsx.asset_bundle.create(ClipSprite,"bundle_bg");
         var _loc1_:Sprite = new Sprite();
         _loc1_.addChild(_loc3_.graphics);
         _loc1_.clipRect = _loc2_;
         clip.bg_container.container.addChild(_loc1_);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height - 50;
         clip.button_close.signal_click.add(close);
         clip.button_promote.signal_click.add(mediator.action_promote);
         miniHeroList = new SpecialShopMiniHeroList(clip.minilist_layout_container,clip.miniList_leftArrow,clip.miniList_rightArrow);
         miniHeroList.dataProvider = mediator.miniHeroListDataProvider;
         miniHeroList.selectedItem = mediator.hero;
         miniHeroList.addEventListener("change",handler_miniListSelectionChange);
         var _loc4_:* = mediator.miniHeroListDataProvider.length > 1;
         clip.tf_label_desc.text = !!_loc4_?Translate.translate("UI_POPUP_SPECIAL_SHOP_DESC2"):Translate.translate("UI_POPUP_SPECIAL_SHOP_DESC");
         clip.minilist_layout_container.visible = _loc4_;
         clip.layout_stats.y = !!_loc4_?185:Number(145);
         clip.tf_label_desc.y = !!_loc4_?35:50;
         clip.tf_label_you_get.y = clip.layout_stats.y - 30;
         clip.tf_header.text = Translate.translate("UI_POPUP_SPECIAL_SHOP_HEADER");
         clip.tf_label_timer.text = Translate.translate("UI_POPUP_SPECIAL_SHOP_TIMER");
         clip.power_block.tf_label.text = Translate.translate("UI_POPUP_SPECIAL_SHOP_POWER_INCREASE");
         clip.skill_block.tf_skill_label.text = Translate.translate("UI_POPUP_SPECIAL_SHOP_NEW_SKILL");
         clip.tf_label_you_get.text = Translate.translate("UI_DIALOG_SPECIAL_SHOP_TF_LABEL_YOU_GET");
         updateHero();
         GameTimer.instance.oneSecTimer.add(handler_onGameTimer);
         handler_onGameTimer();
      }
      
      private function updateHero() : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         if(!mediator.hero)
         {
            return;
         }
         clip.rank_block.portrait.data = mediator.after;
         var _loc1_:ClipLabel = HeroColorNumberClip.createAutoSize(mediator.after.heroEntry.color.color,true);
         clip.rank_block.layout_name.removeChildren();
         clip.rank_block.layout_name.addChild(_loc1_);
         inventoryList = clip.inventory;
         _swapGroup = new SwapGroup();
         var _loc2_:int = inventoryList.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _swapGroup.addChild(inventoryList[_loc5_].graphics);
            _loc3_ = mediator.inventoryList[_loc5_];
            inventoryList[_loc5_].data = _loc3_;
            inventoryList[_loc5_].tf_discount.text = mediator.discountAmount.toString() + "%";
            _loc5_++;
         }
         clip.tf_discount.text = "-" + mediator.discountAmount.toString() + "%";
         clip.stats_block.data = mediator.battleStatSummary;
         clip.power_block.graphics.visible = false;
         clip.rank_block.graphics.visible = mediator.rankIncrease && !mediator.skill;
         clip.skill_block.graphics.visible = mediator.skill;
         if(mediator.skill != null)
         {
            clip.skill_block.tf_skill_name.text = mediator.skill.name;
            clip.skill_block.data = mediator.skill;
         }
         if(!heroPreview)
         {
            heroPreview = new HeroPreview();
            clip.hero_panel.hero_position.container.addChild(heroPreview.graphics);
            heroPreview.graphics.touchable = false;
         }
         heroPreview.loadHero(mediator.hero.playerHero.hero);
         var _loc4_:VerticalLayout = new VerticalLayout();
         _loc4_.gap = 5;
         _loc4_.paddingTop = 25;
         _loc4_.paddingLeft = 28;
         _loc4_.useVirtualLayout = false;
         _loc4_.verticalAlign = "top";
         slotsUpdate();
         if(mediator.rankIncrease)
         {
            clip.button_promote.label = Translate.translate("UI_DIALOG_HERO_BUTTON_PROMOTE");
         }
         else
         {
            clip.button_promote.label = Translate.translate("UI_DIALOG_ARENA_GET");
         }
         clip.button_promote.graphics.alpha = 0;
         clip.button_promote.isEnabled = false;
         Starling.juggler.tween(clip.button_promote.graphics,1.5,{
            "alpha":1,
            "transition":"easeOut",
            "onComplete":handler_buttonPromoteUnlock
         });
      }
      
      private function handler_onGameTimer() : void
      {
         clip.tf_timer.text = TimeFormatter.toMS2(mediator.merchant.timeLeft).toString();
      }
      
      private function slotsUpdate() : void
      {
         var _loc3_:* = null;
         var _loc4_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = mediator.hero.shopHero.slots;
         for each(var _loc2_ in mediator.hero.shopHero.slots)
         {
            if(_loc2_.canBuy())
            {
               _loc4_.push(_loc2_);
               _loc3_ = inventoryList[_loc2_.heroSlotId];
               _loc3_.setSelected();
               _swapGroup.swapChildToTop(_loc3_.graphics);
            }
         }
         clip.power_block.tf_value.text = "+" + mediator.powerIncrease.toString();
         clip.cost_panel.costData = mediator.totalCost;
         clip.tf_old_price.text = String(Math.ceil(mediator.totalCost.amount * (100 / (100 - mediator.discountAmount))));
         clip.tf_old_price.adjustSizeToFitWidth();
         clip.hero_panel.layout_name.removeChildren();
         clip.hero_panel.label_name.text = mediator.hero.playerHero.name;
         clip.hero_panel.layout_name.addChild(clip.hero_panel.label_name);
         var _loc1_:HeroColorNumberClip = HeroColorNumberClip.create(mediator.hero.playerHero.color.color,false);
         if(_loc1_)
         {
            clip.hero_panel.layout_name.addChild(_loc1_.graphics);
         }
         clip.hero_panel.ribbon_image.image.textures = getRibbonTexture(mediator.hero.playerHero.color.color);
      }
      
      private function playSound() : void
      {
         AssetStorage.sound.heroUp.play();
      }
      
      private function getRibbonTexture(param1:HeroColor) : Scale3Textures
      {
         var _loc2_:* = param1.backgroundAssetTexture;
         if("bg_hero_green" !== _loc2_)
         {
            if("bg_hero_blue" !== _loc2_)
            {
               if("bg_hero_purple" !== _loc2_)
               {
                  if("bg_hero_orange" !== _loc2_)
                  {
                     return AssetStorage.rsx.popup_theme.getScale3Textures("RibbonWhiteHeader_76_76_1",76,1);
                  }
                  return AssetStorage.rsx.popup_theme.getScale3Textures("RibbonGoldHeader_76_76_1",76,1);
               }
               return AssetStorage.rsx.popup_theme.getScale3Textures("RibbonPurpleHeader_76_76_1",76,1);
            }
            return AssetStorage.rsx.popup_theme.getScale3Textures("RibbonBlueHeader_76_76_1",76,1);
         }
         return AssetStorage.rsx.popup_theme.getScale3Textures("RibbonGreenHeader_76_76_1",76,1);
      }
      
      private function handler_buttonPromoteUnlock() : void
      {
         clip.button_promote.isEnabled = true;
      }
      
      private function handler_miniListSelectionChange(param1:Event) : void
      {
         mediator.action_miniListSelectionUpdate(miniHeroList.selectedItem as SpecialShopHeroListValueObject);
      }
      
      private function handler_heroChange() : void
      {
         updateHero();
      }
   }
}

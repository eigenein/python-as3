package game.view.popup.hero.consumable
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.popup.hero.HeroUseConsumableWithSelectorPopupMediator;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.mediator.gui.popup.inventory.ToggleableInventoryItemValueObject;
   import game.view.gui.components.GuiSubscriber;
   import game.view.gui.floatingtext.FloatingTextContainer;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.popup.ClipBasedPopup;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.core.Starling;
   
   public class HeroUseConsumableWithSelectorPopup extends ClipBasedPopup implements ITutorialNodePresenter
   {
       
      
      private const guiSubscriber:GuiSubscriber = new GuiSubscriber();
      
      private var mediator:HeroUseConsumableWithSelectorPopupMediator;
      
      private var clip:HeroUseConsumableWithSelectorPopupClip;
      
      private var preselectedHeroWasHighlighted:Boolean = false;
      
      private var _xSelectorTarget:Number;
      
      public function HeroUseConsumableWithSelectorPopup(param1:HeroUseConsumableWithSelectorPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         guiSubscriber.dispose();
         mediator.property_hasConsumable.unsubscribe(handler_hasConsumable);
      }
      
      public function get xSelectorTarget() : Number
      {
         return _xSelectorTarget;
      }
      
      public function set xSelectorTarget(param1:Number) : void
      {
         clip.spot_left_top.graphics.width = param1 - clip.spot_left_top.graphics.x;
         clip.spot_left_bottom.graphics.width = param1 - clip.spot_left_top.graphics.x;
         clip.spot_right_top.graphics.width = param1 - clip.spot_right_top.graphics.x;
         clip.spot_right_bottom.graphics.width = param1 - clip.spot_right_bottom.graphics.x;
         clip.selector_arrow_top.graphics.x = param1 - 2;
         clip.selector_arrow_bottom.graphics.x = param1 - 2;
         _xSelectorTarget = param1;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.HERO_USE_CONSUMABLE;
      }
      
      override protected function initialize() : void
      {
         var _loc5_:int = 0;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(HeroUseConsumableWithSelectorPopupClip,"dialog_hero_list_consumable_with_selector");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         var _loc3_:TiledRowsLayout = new TiledRowsLayout();
         _loc3_.useSquareTiles = false;
         _loc3_.gap = 6;
         var _loc7_:int = 12;
         _loc3_.paddingBottom = _loc7_;
         _loc3_.paddingTop = _loc7_;
         clip.list_hero.list.layout = _loc3_;
         clip.list_hero.list.useFloatCoordinates = false;
         clip.list_hero.list.dataProvider = new ListCollection(mediator.heroes);
         guiSubscriber.add(clip.list_hero_signals.click,handler_click);
         guiSubscriber.add(clip.list_hero_signals.oneLevelClick,handler_oneLevelClick);
         guiSubscriber.add(clip.list_hero_signals.levelUp,handler_levelUp);
         guiSubscriber.add(clip.list_hero_signals.onScreen,handler_onScreen);
         clip.button_close.signal_click.add(close);
         clip.tf_amount_label.text = Translate.translateArgs("UI_DIALOG_HERO_INVENTORY_SLOT_AMOUNT");
         var _loc2_:String = ColorUtils.hexToRGBFormat(16711677) + mediator.maxLevel + ColorUtils.hexToRGBFormat(16442802);
         clip.tf_max_level.text = Translate.translateArgs("UI_DIALOG_HERO_USE_XP_POTION_LVL",_loc2_) + "\n" + Translate.translate("UI_DIALOG_HERO_USE_XP_POTION_DESC");
         var _loc6_:Vector.<ToggleableInventoryItemValueObject> = mediator.consumables;
         var _loc4_:int = Math.min(_loc6_.length,clip.items.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            clip.items[_loc5_].setData(_loc6_[_loc5_],_loc6_[_loc5_].toggle);
            _loc5_++;
         }
         clip.tf_no_potions_title.text = Translate.translate("UI_HERO_DIALOG_NO_XP_CONSUMABLES");
         clip.tf_no_potions_text.text = Translate.translate("UI_HERO_DIALOG_NO_XP_CONSUMABLES_WHERE_TO_GO");
         clip.button_missions.initialize(Translate.translate("UI_DIALOG_CLAN_REWARDS_LABEL_CAMPAIGN_GO"),mediator.action_toMissions);
         clip.button_shop.initialize(Translate.translate("UI_DIALOG_ARENA_SHOP"),mediator.action_toShop);
         var _loc1_:HeroDescription = mediator.preselectedHero;
         if(_loc1_ != null)
         {
            scrollToHero(_loc1_);
         }
         handler_consumableChanged();
         guiSubscriber.add(mediator.signal_consumeableChanged,handler_consumableChanged);
         mediator.property_hasConsumable.onValue(handler_hasConsumable);
         xSelectorTarget = getXSelectorTarget();
         guiSubscriber.add(mediator.signal_itemAmountUpdate,handler_updateAmount);
      }
      
      private function handler_consumableChanged() : void
      {
         Starling.juggler.removeTweens(this);
         Starling.juggler.tween(this,0.3,{
            "xSelectorTarget":getXSelectorTarget(),
            "transition":"easeOut"
         });
         var _loc1_:uint = clip.font_color[mediator.nameFontColorIndex].fontColor;
         clip.tf_use_label.text = Translate.translate("UI_DIALOG_INVENTORY_USE") + " " + ColorUtils.hexToRGBFormat(_loc1_) + mediator.name;
         handler_updateAmount();
      }
      
      private function handler_hasConsumable(param1:Boolean) : void
      {
         clip.block_has_consumable.visible = param1;
         clip.block_no_consumable.visible = !param1;
         var _loc4_:int = 0;
         var _loc3_:* = clip.items;
         for each(var _loc2_ in clip.items)
         {
            _loc2_.graphics.visible = param1;
         }
         if(param1)
         {
            clip.list_hero.graphics.alpha = 1;
            if(clip.list_hero.graphics.filter)
            {
               clip.list_hero.graphics.filter.dispose();
               clip.list_hero.graphics.filter = null;
            }
         }
         else
         {
            clip.list_hero.graphics.alpha = 0.8;
            if(!clip.list_hero.graphics.filter)
            {
               clip.list_hero.graphics.filter = AssetStorage.rsx.popup_theme.filter_disabled;
            }
         }
         clip.list_hero.graphics.touchable = param1;
      }
      
      private function getXSelectorTarget() : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = clip.items.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(clip.items[_loc2_].isSelected)
            {
               _loc3_ = clip.items[_loc2_].graphics.x + clip.items[_loc2_].graphics.width * 0.5;
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      private function scrollToHero(param1:HeroDescription) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Vector.<PlayerHeroListValueObject> = mediator.heroes;
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].hero == param1)
            {
               clip.list_hero.list.scrollToDisplayIndex(_loc4_,0.5);
               return;
            }
            _loc4_++;
         }
      }
      
      private function handler_updateAmount() : void
      {
         clip.tf_amount.text = String(mediator.amount);
      }
      
      private function handler_click(param1:PlayerHeroListValueObject) : void
      {
         mediator.action_useItem(param1);
      }
      
      private function handler_oneLevelClick(param1:PlayerHeroListValueObject) : void
      {
         mediator.action_oneLevel(param1);
      }
      
      private function handler_levelUp(param1:HeroUseConsumableWithSelectorHeroBaseClipListItem) : void
      {
         FloatingTextContainer.showInDisplayObjectCenter(param1.graphics,0,20,Translate.translate("UI_COMMON_HERO_LEVEL_UP"),mediator);
      }
      
      private function handler_onScreen(param1:HeroUseConsumableWithSelectorHeroBaseClipListItem) : void
      {
         if(!preselectedHeroWasHighlighted && param1.heroDescription == mediator.preselectedHero)
         {
            param1.animateSelection();
            preselectedHeroWasHighlighted = true;
         }
      }
   }
}

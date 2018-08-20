package game.view.popup.hero.rune
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.HeroColor;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.hero.PlayerHeroEntryValueObject;
   import game.mediator.gui.popup.rune.HeroRuneEnchantProgress;
   import game.mediator.gui.popup.rune.HeroRunePopupMediator;
   import game.mediator.gui.popup.rune.PlayerHeroRuneValueObject;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.HeroPreview;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.gui.floatingtext.FloatingTextContainer;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.common.PopupSideTab;
   import game.view.popup.hero.HeroPopupPowerAnimation;
   import game.view.popup.hero.TimerQueueDispenser;
   import game.view.popup.hero.minilist.HeroPopupMiniHeroList;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import starling.filters.ColorMatrixFilter;
   
   public class HeroRunePopup extends ClipBasedPopup implements IAnimatable
   {
      
      private static const HERO_SCALE:Number = 0.5;
       
      
      private var mediator:HeroRunePopupMediator;
      
      private const clip:HeroRunePopupClip = AssetStorage.rsx.popup_theme.create_dialog_hero_runes();
      
      private var miniList:HeroPopupMiniHeroList;
      
      private var heroPreview:HeroPreview;
      
      private var powerAnimation:HeroPopupPowerAnimation;
      
      private var toggle:ToggleGroup;
      
      private var enchantGemHover:TouchHoverContoller;
      
      private var updatedStatsQueue:TimerQueueDispenser;
      
      private var _value:Number = 0;
      
      private var _newValue:Number = 0;
      
      private var _smoothValue:Number = 0;
      
      private var _smoothNewValue:Number = 0;
      
      public function HeroRunePopup(param1:HeroRunePopupMediator)
      {
         powerAnimation = new HeroPopupPowerAnimation(clip.tf_power_value);
         super(param1);
         this.mediator = param1;
         heroPreview = new HeroPreview();
         var _loc2_:* = 0.5;
         heroPreview.graphics.scaleY = _loc2_;
         heroPreview.graphics.scaleX = _loc2_;
      }
      
      override public function dispose() : void
      {
         if(heroPreview)
         {
            heroPreview.dispose();
         }
         Starling.juggler.remove(this);
         enchantGemHover.dispose();
         clip.dispose();
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function advanceTime(param1:Number) : void
      {
         _smoothNewValue = _smoothNewValue * 0.5 + _newValue * 0.5;
         if(_smoothNewValue < _newValue + 0.01 && _smoothNewValue > _newValue - 0.01)
         {
            _smoothNewValue = _newValue;
         }
         clip.progress.setupProgress(_value);
         clip.progress.setupGreenProgress(_smoothNewValue);
         updateRuneSelector(param1);
      }
      
      protected function createMiniList() : void
      {
         miniList = new HeroPopupMiniHeroList(clip.minilist_layout_container,clip.miniList_leftArrow,clip.miniList_rightArrow);
         miniList.dataProvider = mediator.miniHeroListDataProvider;
         miniList.selectedItem = mediator.miniHeroListSelectedItem;
         miniList.addEventListener("change",handler_miniListSelectionChange);
      }
      
      private function updateCosts() : void
      {
         clip.block_items.cost_enchant.costData = new InventoryItem(DataStorage.pseudo.COIN,mediator.enchantProgress.goldCost);
         clip.block_items.layout_cost.invalidate();
         clip.block_items.cost_gem.costData = new InventoryItem(DataStorage.pseudo.STARMONEY,mediator.enchantProgress.gemCost);
         clip.block_items.layout_gem_cost.invalidate();
      }
      
      private function updateRuneSelector(param1:Number) : void
      {
         var _loc6_:Number = 9 * param1;
         var _loc4_:Number = 5 * param1;
         var _loc2_:DisplayObject = clip.selector.graphics;
         var _loc5_:Number = 1.25663706143592 * mediator.rune.tier;
         var _loc3_:* = (_loc2_.rotation - _loc5_) % (3.14159265358979 * 2) != 0;
         if(_loc3_)
         {
            if(_loc2_.alpha > _loc6_)
            {
               _loc2_.alpha = _loc2_.alpha - _loc6_;
            }
            else
            {
               _loc2_.rotation = _loc5_;
            }
         }
         else if(_loc2_.alpha < 1)
         {
            if(_loc2_.alpha < 1 - _loc4_)
            {
               _loc2_.alpha = _loc2_.alpha + _loc4_;
            }
            else
            {
               _loc2_.alpha = 1;
            }
         }
      }
      
      private function updateActionBlock() : void
      {
         var _loc5_:Boolean = mediator.rune.locked;
         var _loc1_:* = mediator.rune.levelCap == mediator.rune.level;
         var _loc3_:* = mediator.rune.maxLevel == mediator.rune.level;
         var _loc6_:* = mediator.rune.level > 0;
         var _loc2_:HeroRuneUpgradeBlockClip = clip.block_items;
         clip.block_items.tf_items_label.alpha = !!_loc5_?0.5:1;
         if(_loc3_ || _loc1_ || _loc5_ || enchantGemHover.hover)
         {
            _loc2_.inventory_item_list.graphics.touchable = false;
            _loc2_.inventory_item_list.graphics.alpha = 0.3;
         }
         else
         {
            _loc2_.inventory_item_list.graphics.touchable = true;
            _loc2_.inventory_item_list.graphics.alpha = 1;
         }
         if(mediator.noItems)
         {
            _loc2_.tf_label_no_runes.visible = true;
            _loc2_.button_go.graphics.visible = true;
            _loc2_.inventory_item_list.graphics.visible = false;
         }
         else
         {
            _loc2_.tf_label_no_runes.visible = false;
            _loc2_.button_go.graphics.visible = false;
            _loc2_.inventory_item_list.graphics.visible = true;
         }
         var _loc4_:Boolean = false;
         if(_loc3_)
         {
            clip.block_max_level.tf_label_max_level.text = Translate.translate("UI_DIALOG_RUNES_LEVEL_MAX_ITEMS");
            clip.block_max_level.tf_label_next_level.visible = false;
            _loc4_ = true;
         }
         else if(_loc1_ && !_loc5_)
         {
            if(_loc6_)
            {
               clip.block_max_level.tf_label_max_level.text = Translate.translate("UI_DIALOG_RUNES_LEVEL_MAX_ITEMS");
               clip.block_max_level.tf_label_next_level.text = Translate.translateArgs("UI_DIALOG_RUNES_LEVEL_CAPED_ITEMS",mediator.rune.nextHeroLevel);
               clip.block_max_level.tf_label_next_level.visible = true;
               _loc4_ = true;
            }
            else
            {
               _loc2_.tf_items_label.text = Translate.translateArgs("UI_DIALOG_RUNES_LEVEL_CAPED_ITEMS",mediator.rune.nextHeroLevel);
               _loc4_ = false;
            }
         }
         else
         {
            _loc2_.tf_items_label.text = Translate.translate("UI_DIALOG_RUNES_ITEMS");
            _loc4_ = false;
         }
         _loc2_.graphics.visible = !_loc4_;
         clip.block_max_level.graphics.visible = _loc4_;
      }
      
      private function setStatText(param1:String) : void
      {
         clip.tf_stat.text = param1;
         clip.tf_stat.adjustSizeToFitWidth();
      }
      
      private function setFilterAlpha(param1:DisplayObject, param2:Number) : void
      {
         if(!param1.filter)
         {
            param1.filter = new ColorMatrixFilter();
         }
         var _loc3_:ColorMatrixFilter = param1.filter as ColorMatrixFilter;
         if(_loc3_)
         {
            _loc3_.matrix[18] = param2;
            _loc3_.matrix = _loc3_.matrix;
         }
      }
      
      private function handler_heroUpdate() : void
      {
         heroPreview.loadHero(mediator.hero.hero);
         clip.hero_position.container.addChild(heroPreview.graphics);
         powerAnimation.setValueWithoutAnimation(mediator.hero.playerEntry.getPower());
      }
      
      private function handler_runeUpdate() : void
      {
         clip.setRune(mediator.rune);
         clip.tf_level_label.text = String(mediator.enchantProgress.level);
         setStatText(mediator.enchantProgress.statString);
         var _loc1_:* = clip.tf_stat.width;
         clip.stat_glow_line.graphics.width = _loc1_;
         clip.stat_glow.graphics.width = _loc1_;
         updateActionBlock();
      }
      
      private function handler_runeSelected(param1:PlayerHeroRuneValueObject) : void
      {
         handler_runesUpdated();
      }
      
      private function handler_runesUpdated() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function handler_miniListSelectionChange(param1:Event) : void
      {
         mediator.action_miniListSelectionUpdate(miniList.selectedItem as PlayerHeroEntryValueObject);
      }
      
      private function handler_selectionUpdated() : void
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc5_:* = null;
         updateCosts();
         if(enchantGemHover.hover)
         {
            _loc3_ = mediator.getGemProgress();
         }
         else
         {
            _loc3_ = mediator.enchantProgress;
         }
         setStatText(_loc3_.statString);
         var _loc4_:Boolean = mediator.rune.locked;
         var _loc7_:* = !_loc4_;
         clip.tf_progress.visible = _loc7_;
         clip.tf_level_label.visible = _loc7_;
         clip.tf_locked.visible = _loc4_;
         if(_loc4_)
         {
            _loc1_ = mediator.rune.color;
            _loc5_ = _loc1_.name;
            if(_loc1_.hasMinorIdentFraction)
            {
               _loc5_ = _loc5_ + (" +" + _loc1_.minorIdentFraction);
            }
            clip.tf_locked.text = Translate.translateArgs("UI_DIALOG_HERO_RUNE_UNLOCK_TIER",_loc5_);
         }
         else
         {
            clip.tf_level_label.text = _loc3_.levelString;
            clip.tf_progress.text = _loc3_.enchantPointsString;
         }
         _value = _loc3_.currentLevelProgressValue;
         _newValue = _loc3_.nextLevelProgressValue;
         var _loc2_:Boolean = mediator.enchantProgress.selectedValue > 0 && !enchantGemHover.hover;
         clip.block_items.button_enchant.isEnabled = _loc2_;
         clip.block_items.button_enchant.graphics.alpha = !!_loc2_?1:0.35;
         setFilterAlpha(clip.block_items.cost_enchant.graphics,!!_loc2_?1:0.35);
         var _loc6_:Boolean = mediator.enchantProgress.canIncreaseLevel && !mediator.rune.locked;
         clip.block_items.button_enchant_gem.isEnabled = _loc6_;
         clip.block_items.button_enchant_gem.graphics.alpha = !!_loc6_?1:0.35;
         setFilterAlpha(clip.block_items.cost_gem.graphics,!!_loc6_?1:0.35);
      }
      
      private function handler_runeEnchanted() : void
      {
         heroPreview.win();
         var _loc2_:int = powerAnimation.tweenableValue;
         var _loc1_:int = mediator.hero.playerEntry.getPower();
         powerAnimation.setValue(_loc1_);
         clip.animation_enchant.show(clip.container);
         clip.animation_enchant.playOnceAndHide();
         Starling.juggler.removeTweens(clip.rune_icon.graphics);
         Starling.juggler.tween(clip.rune_icon.graphics,0.15,{
            "scaleX":1.2,
            "scaleY":1.2,
            "transition":"easeOut"
         });
         Starling.juggler.tween(clip.rune_icon.graphics,0.4,{
            "scaleX":1,
            "scaleY":1,
            "delay":0.15,
            "transition":"easeIn"
         });
      }
      
      private function handler_statsUpdated(param1:Vector.<BattleStatValueObject>) : void
      {
         updatedStatsQueue.add(param1);
      }
      
      private function handler_statDispensered(param1:BattleStatValueObject) : void
      {
         var _loc3_:* = null;
         var _loc2_:DisplayObject = heroPreview.graphics;
         if(_loc2_)
         {
            _loc3_ = param1.name + " +" + param1.value;
            FloatingTextContainer.showInDisplayObjectCenter(clip.icon_power.graphics,0,-30,_loc3_,mediator,300);
         }
      }
      
      private function handler_enchantGemHoverChanged() : void
      {
         handler_selectionUpdated();
         updateActionBlock();
      }
      
      private function handler_tabSelected() : void
      {
         mediator.action_tabSelect(toggle.selectedIndex);
      }
   }
}

package game.view.popup.hero.rune
{
   import battle.BattleStats;
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.RequestableAsset;
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   import game.data.cost.CostData;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.hero.HeroElementPopupMediator;
   import game.mediator.gui.popup.hero.PlayerHeroEntryValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.HeroPreview;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.gui.floatingtext.FloatingTextContainer;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.common.PopupSideTab;
   import game.view.popup.hero.TimerQueueDispenser;
   import game.view.popup.hero.minilist.HeroPopupMiniHeroList;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import starling.filters.BlurFilter;
   
   public class HeroElementPopup extends ClipBasedPopup
   {
      
      private static const HERO_SCALE:Number = 0.7;
       
      
      private var mediator:HeroElementPopupMediator;
      
      private var clip:HeroElementPopupClip;
      
      private var circleClip:HeroElementPopupCircleClip;
      
      private var miniList:HeroPopupMiniHeroList;
      
      private var heroPreview:HeroPreview;
      
      private var actionHover:TouchHoverContoller;
      
      private var toggle:ToggleGroup;
      
      private var updatedStatsQueue:TimerQueueDispenser;
      
      private var _statGlowFilterAlpha:Number;
      
      public function HeroElementPopup(param1:HeroElementPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         param1.signal_heroUpdated.add(handler_heroUpdate);
         param1.signal_heroChangeTitanGiftLevel.add(handler_heroChangeTitanGiftLevel);
         param1.signal_statsUpdate.add(handler_statsUpdate);
         heroPreview = new HeroPreview();
         heroPreview.graphics.filter = BlurFilter.createGlow(0,1,2,0.5);
         var _loc2_:* = 0.7;
         heroPreview.graphics.scaleY = _loc2_;
         heroPreview.graphics.scaleX = _loc2_;
      }
      
      override public function dispose() : void
      {
         actionHover && actionHover.dispose();
         circleClip && circleClip.dispose();
         updatedStatsQueue.dispose();
         if(heroPreview)
         {
            heroPreview.dispose();
         }
         mediator.signal_heroUpdated.remove(handler_heroUpdate);
         mediator.signal_heroChangeTitanGiftLevel.remove(handler_heroChangeTitanGiftLevel);
         mediator.signal_statsUpdate.remove(handler_statsUpdate);
         Starling.juggler.removeTweens(this);
         super.dispose();
      }
      
      public function get statGlowFilterAlpha() : Number
      {
         return _statGlowFilterAlpha;
      }
      
      public function set statGlowFilterAlpha(param1:Number) : void
      {
         if(_statGlowFilterAlpha != param1)
         {
            _statGlowFilterAlpha = param1;
            updateStatGlowFilterAlpha(clip.tf_skill1_value,param1);
            updateStatGlowFilterAlpha(clip.tf_skill2_value,param1);
            updateStatGlowFilterAlpha(clip.tf_skill3_value,param1);
         }
      }
      
      override protected function initialize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_hero_elements();
         addChild(clip.graphics);
         AssetStorage.instance.globalLoader.requestAssetWithCallback(AssetStorage.rsx.asset_clan_circle,handler_assetClanCircle);
         width = clip.bound_layout_container.graphics.width - 120;
         height = clip.bound_layout_container.graphics.height;
         updatedStatsQueue = new TimerQueueDispenser(BattleStatValueObject,400);
         updatedStatsQueue.signal_onElement.add(onUpdatedStatDelivered);
         clip.dialog_frame.graphics.touchable = false;
         clip.hero_position.graphics.touchable = false;
         clip.title = Translate.translate("UI_DIALOG_ELEMENTS_NAME");
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_desc.text = Translate.translateArgs("UI_DIALOG_ELEMENTS_DESC",ColorUtils.hexToRGBFormat(16645626));
         clip.btn_reset.label = Translate.translate("UI_DIALOG_ELEMENTS_ACTION_RESET");
         clip.btn_action.signal_click.add(handler_buttonUpdrageClick);
         clip.btn_reset.signal_click.add(handler_buttonResetClick);
         actionHover = new TouchHoverContoller(clip.btn_action.container);
         actionHover.signal_hoverChanger.add(handler_actionHoverChanged);
         createMiniList();
         handler_heroUpdate();
         toggle = new ToggleGroup();
         _loc1_ = 0;
         while(_loc1_ < mediator.tabs.length)
         {
            _loc2_ = AssetStorage.rsx.popup_theme.create_side_dialog_tab_hero();
            _loc2_.NewIcon_inst0.graphics.visible = false;
            _loc2_.label = Translate.translate("UI_DIALOG_FORGE_" + mediator.tabs[_loc1_].toUpperCase());
            toggle.addItem(_loc2_);
            clip.layout_tabs.addChild(_loc2_.graphics);
            _loc1_++;
         }
         toggle.selectedIndex = 1;
         toggle.signal_updateSelectedItem.add(handler_tabSelected);
      }
      
      protected function createMiniList() : void
      {
         miniList = new HeroPopupMiniHeroList(clip.minilist_layout_container,clip.miniList_leftArrow,clip.miniList_rightArrow);
         miniList.dataProvider = mediator.miniHeroListDataProvider;
         miniList.selectedItem = mediator.miniHeroListSelectedItem;
         miniList.addEventListener("change",handler_miniListSelectionChange);
      }
      
      private function handler_assetClanCircle(param1:RequestableAsset) : void
      {
         circleClip = AssetStorage.rsx.asset_clan_circle.create(HeroElementPopupCircleClip,"circle_with_pyramids");
         clip.circle_container.addChild(circleClip.graphics);
         circleClip.setLevel(mediator.heroTitanGiftLevel);
      }
      
      private function updateContent() : void
      {
         var _loc1_:* = null;
         updateParams();
         clip.btn_reset.graphics.visible = mediator.heroTitanGiftLevel != mediator.heroGiftLevelMin;
         clip.layout_price_action.visible = mediator.heroTitanGiftLevel != mediator.heroGiftLevelMax;
         if(clip.layout_price_action.visible)
         {
            _loc1_ = mediator.titanGiftNext.cost;
            if(_loc1_.outputDisplay.length > 0)
            {
               clip.price_1.data = _loc1_.outputDisplay[0];
            }
            if(_loc1_.outputDisplay.length > 1)
            {
               clip.price_2.data = _loc1_.outputDisplay[1];
            }
         }
         if(circleClip)
         {
            circleClip.setLevel(mediator.heroTitanGiftLevel);
         }
      }
      
      private function updateParams(param1:Boolean = false) : void
      {
         var _loc7_:* = null;
         var _loc4_:* = null;
         if(param1)
         {
            param1 = mediator.heroTitanGiftLevel != mediator.heroGiftLevelMin;
         }
         var _loc2_:int = mediator.heroGiftLevelMax;
         var _loc5_:BattleStats = null;
         var _loc3_:BattleStats = null;
         if(mediator.heroTitanGiftLevel == mediator.heroGiftLevelMin)
         {
            _loc3_ = mediator.battleStatsNext;
            clip.tf_activate.text = Translate.translate("UI_DIALOG_ELEMENTS_ACTIVATE");
            clip.btn_action.label = Translate.translate("UI_DIALOG_ELEMENTS_ACTION_ACTIVATE");
         }
         else if(mediator.heroTitanGiftLevel == _loc2_)
         {
            _loc5_ = mediator.battleStatsCurrent;
            clip.tf_activate.text = Translate.translate("UI_COMMON_LEVEL_MAX");
         }
         else
         {
            _loc5_ = mediator.battleStatsCurrent;
            _loc3_ = mediator.battleStatsNext;
            if(param1)
            {
               clip.tf_activate.text = ColorUtils.hexToRGBFormat(16381667) + Translate.translateArgs("UI_COMMON_LEVEL",ColorUtils.hexToRGBFormat(8841550) + (mediator.heroTitanGiftLevel + 1) + ColorUtils.hexToRGBFormat(16381667) + "/" + _loc2_);
            }
            else
            {
               clip.tf_activate.text = ColorUtils.hexToRGBFormat(16381667) + Translate.translateArgs("UI_COMMON_LEVEL",mediator.heroTitanGiftLevel + "/" + _loc2_);
            }
            clip.btn_action.label = Translate.translate("UI_DIALOG_ELEMENTS_ACTION_UPGRADE");
         }
         var _loc6_:Object = !!_loc5_?_loc5_.serialize():_loc3_.serialize();
         if(_loc6_)
         {
            _loc7_ = [];
            _loc4_ = null;
            var _loc9_:int = 0;
            var _loc8_:* = _loc6_;
            for(_loc4_ in _loc6_)
            {
               _loc7_.push(_loc4_);
            }
            if(!param1 && _loc5_ != null)
            {
               _loc3_ = null;
            }
            _loc4_ = _loc7_[0];
            setStat(_loc4_,_loc5_,_loc3_,clip.tf_skill1,clip.tf_skill1_value,clip.skill1_container);
            _loc4_ = _loc7_[1];
            setStat(_loc4_,_loc5_,_loc3_,clip.tf_skill2,clip.tf_skill2_value,clip.skill2_container);
            _loc4_ = _loc7_[2];
            setStat(_loc4_,_loc5_,_loc3_,clip.tf_skill3,clip.tf_skill3_value,clip.skill3_container);
         }
      }
      
      private function setHeroHappy() : void
      {
         if(heroPreview != null && !heroPreview.isBusy)
         {
            heroPreview.win();
         }
      }
      
      private function setStat(param1:String, param2:BattleStats, param3:BattleStats, param4:ClipLabel, param5:ClipLabel, param6:ClipLayout) : void
      {
         if(param2 == null)
         {
            param2 = param3;
            param3 = null;
         }
         var _loc7_:ClipSprite = AssetStorage.rsx.rune_icons.create(ClipSprite,param1.toLowerCase());
         param6.removeChildren(0,-1,true);
         param6.addChild(_loc7_.graphics);
         param4.text = Translate.translate("LIB_BATTLESTATDATA_" + param1.toUpperCase());
         Starling.juggler.removeTweens(this);
         if(param3 == null)
         {
            param5.text = ColorUtils.hexToRGBFormat(16645626) + "+" + param2[param1];
            statGlowFilterAlpha = 0;
         }
         else
         {
            param5.text = ColorUtils.hexToRGBFormat(8841550) + "+" + param3[param1];
            statGlowFilterAlpha = 1.3;
            Starling.juggler.tween(this,1.2,{
               "statGlowFilterAlpha":0,
               "transition":"easeOut"
            });
         }
      }
      
      private function updateStatGlowFilterAlpha(param1:ClipLabel, param2:Number) : void
      {
         if(param2 == 0)
         {
            if(param1.filter)
            {
               param1.filter.dispose();
               param1.filter = null;
            }
         }
         else if(param1.filter == null)
         {
            param1.filter = BlurFilter.createGlow(8841550,_statGlowFilterAlpha,2,1);
         }
         else
         {
            (param1.filter as BlurFilter).setUniformColor(true,8841550,_statGlowFilterAlpha);
         }
      }
      
      private function handler_heroUpdate() : void
      {
         updatedStatsQueue.reset();
         heroPreview.loadHero(mediator.hero.hero);
         clip.hero_position.container.addChild(heroPreview.graphics);
         updateContent();
      }
      
      private function handler_miniListSelectionChange(param1:Event) : void
      {
         mediator.action_miniListSelectionUpdate(miniList.selectedItem as PlayerHeroEntryValueObject);
      }
      
      private function handler_buttonUpdrageClick() : void
      {
         mediator.action_heroGiftLevelUpgrade();
      }
      
      private function handler_buttonResetClick() : void
      {
         mediator.action_heroTitanGiftDrop();
      }
      
      private function handler_heroChangeTitanGiftLevel() : void
      {
         updateContent();
         if(circleClip)
         {
            circleClip.showInsertAnimation();
         }
         if(heroPreview)
         {
            Starling.juggler.delayCall(setHeroHappy,2.91666666666667);
         }
      }
      
      private function handler_actionHoverChanged() : void
      {
         updateParams(actionHover.hover);
      }
      
      private function handler_tabSelected() : void
      {
         mediator.action_tabSelect(toggle.selectedIndex);
      }
      
      private function handler_statsUpdate(param1:Vector.<BattleStatValueObject>) : void
      {
         updatedStatsQueue.add(param1);
      }
      
      private function onUpdatedStatDelivered(param1:BattleStatValueObject) : void
      {
         var _loc3_:* = null;
         var _loc2_:DisplayObject = heroPreview.graphics;
         if(_loc2_)
         {
            _loc3_ = param1.name + " +" + param1.value;
            FloatingTextContainer.showInDisplayObjectCenter(_loc2_,0,30,_loc3_,mediator,300);
         }
      }
   }
}

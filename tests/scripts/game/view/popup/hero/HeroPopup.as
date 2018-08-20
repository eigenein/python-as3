package game.view.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.HorizontalLayout;
   import feathers.textures.Scale3Textures;
   import flash.utils.Dictionary;
   import game.assets.storage.AssetStorage;
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skin.SkinDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.hero.HeroPopupMediator;
   import game.mediator.gui.popup.hero.PlayerHeroEntryValueObject;
   import game.mediator.gui.popup.hero.skill.HeroPopupSkillValueObject;
   import game.mediator.gui.popup.hero.slot.HeroInventorySlotValueObject;
   import game.stat.Stash;
   import game.view.gui.components.HeroPreview;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.gui.floatingtext.FloatingTextContainer;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupSideTab;
   import game.view.popup.hero.minilist.HeroPopupMiniHeroList;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class HeroPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter, IEscClosable
   {
      
      public static const INVALIDATION_FLAG_FRAGMENT_COUNT:String = "INVALIDATION_FLAG_FRAGMENT_COUNT";
      
      public static const INVALIDATION_FLAG_TABS:String = "INVALIDATION_FLAG_TABS";
       
      
      private var clip:HeroPopupClip;
      
      private var mediator:HeroPopupMediator;
      
      private var inventoryList:Vector.<HeroPopupInventoryItemRenderer>;
      
      private var miniList:HeroPopupMiniHeroList;
      
      private var heroPreview:HeroPreview;
      
      private var updatedStatsQueue:TimerQueueDispenser;
      
      private var color_label:HeroColorNumberClip;
      
      private var powerAnimation:HeroPopupPowerAnimation;
      
      private var toggle:ToggleGroup;
      
      private var tabContent:Dictionary;
      
      private var tabButtons:Dictionary;
      
      public function HeroPopup(param1:HeroPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "hero";
         param1.signal_heroPromote.add(onHeroPromote);
         param1.signal_heroEvolve.add(onHeroEvolve);
         param1.signal_skillWatchUpdate.add(onHeroSkillWatchUpdate);
         param1.signal_skinWatchUpdate.add(onHeroSkinWatchUpdate);
         param1.signal_tabUpdate.add(onTabUpdate);
         param1.signal_promotableStatusUpdate.add(onHeroPromotableUpdate);
         param1.signal_evolvableStatusUpdate.add(onHeroEvolveWatchUpdate);
         param1.signal_expIncreaseUpdate.add(onHeroExpIncreaseWatchUpdate);
         param1.signal_inventorySlotActionAvailableUpdate.add(onHeroInventorySlotsUpdate);
         param1.signl_fragmentCountUpdate.add(onFragmentCountUpdate);
         param1.signal_heroChanged.add(handler_heroChanged);
         param1.signal_experienceUpdate.add(handler_updateExp);
         param1.signal_levelUp.add(handler_levelUp);
         param1.signal_skillUpgrade.add(handler_skillUpgrade);
         param1.signal_statsUpdate.add(handler_statsUpdate);
         param1.signal_powerUpdate.add(handler_powerUpdate);
         param1.signal_skinUpgrade.add(handler_skinUpgrade);
         param1.signal_skinBrowse.add(handler_skinBrowse);
         param1.signal_updateTitanGiftLevelUpAvaliable.add(handler_updateTitanGiftLevelUpAvaliable);
         param1.signal_runeUpgrade.add(handler_runeUpgrade);
         param1.signal_heroArtifactUpgrade.add(handler_heroArtifactUpgrade);
      }
      
      override public function dispose() : void
      {
         Tutorial.removeActionsFrom(this);
         updatedStatsQueue.dispose();
         heroPreview.dispose();
         if(clip && clip.elementTab)
         {
            clip.elementTab.dispose();
         }
         var _loc3_:int = 0;
         var _loc2_:* = tabContent;
         for each(var _loc1_ in tabContent)
         {
            if(_loc1_.parent == null)
            {
               _loc1_.dispose();
            }
         }
         super.dispose();
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.HERO;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override protected function initialize() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_hero();
         addChild(clip.graphics);
         updatedStatsQueue = new TimerQueueDispenser(BattleStatValueObject,400);
         updatedStatsQueue.signal_onElement.add(onUpdatedStatDelivered);
         width = clip.bound_layout_container.graphics.width;
         height = clip.bound_layout_container.graphics.height;
         clip.button_close.signal_click.add(mediator.close);
         inventoryList = new Vector.<HeroPopupInventoryItemRenderer>();
         var _loc2_:int = mediator.inventoryList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = clip.getInventorySlot(_loc3_ + 1);
            inventoryList[_loc3_] = _loc1_;
            _loc1_.signal_click.add(handler_inventoryPanelClick);
            _loc3_++;
         }
         heroPreview = new HeroPreview();
         clip.hero_position.container.addChild(heroPreview.graphics);
         heroPreview.graphics.touchable = false;
         clip.button_promote.label = Translate.translate("UI_DIALOG_HERO_BUTTON_PROMOTE");
         clip.button_promote.signal_click.add(mediator.action_promoteHero);
         clip.button_evolve.label = Translate.translate("UI_DIALOG_HERO_BUTTON_EVOLVE");
         clip.button_evolve.signal_click.add(mediator.action_evolveHero);
         clip.button_fragments_plus.signal_click.add(mediator.action_evolveGetDropList);
         clip.button_xp_plus.signal_click.add(mediator.action_addExp);
         clip.tf_label_level.text = Translate.translate("UI_DIALOG_HERO_LEVEL_LABEL");
         clip.tf_power_label.text = Translate.translate("UI_DIALOG_HERO_POWER_LABEL");
         clip.tf_label_fragments.text = Translate.translate("UI_DIALOG_HERO_FRAGMENTS");
         createMiniList();
         clip.skillList.mediator = mediator;
         clip.statList.mediator = mediator;
         clip.skinList.mediator = mediator;
         tabContent = new Dictionary();
         tabContent["TAB_SKILLS"] = clip.skillList.graphics;
         tabContent["TAB_SKINS"] = clip.skinList.graphics;
         tabContent["TAB_STATS"] = clip.statList.graphics;
         tabContent["TAB_GEAR"] = clip.gearList.graphics;
         tabContent["TAB_PORTRAIT"] = clip.epic_art_frame.graphics;
         tabContent["TAB_ELEMENT"] = clip.elementTab.graphics;
         tabContent["TAB_ARTIFACTS"] = clip.artifactsTab.graphics;
         if(clip.runeTab)
         {
            if(mediator.runeMediator.runesEnabled)
            {
               clip.runeTab.mediator = mediator.runeMediator;
               clip.runeTab.signal_go.add(mediator.action_goForRunes);
            }
            tabContent["TAB_RUNE"] = clip.runeTab.graphics;
         }
         else
         {
            _loc4_ = mediator.tabs.indexOf("TAB_RUNE");
            if(_loc4_ != -1)
            {
               mediator.tabs.splice(_loc4_,1);
            }
         }
         if(clip.elementTab)
         {
            clip.elementTab.mediator = mediator.elementMediator;
         }
         if(clip.artifactsTab)
         {
            clip.artifactsTab.mediator = mediator;
         }
         clip.gearList.signal_itemSelect.add(handler_gearListItemSelect);
         powerAnimation = new HeroPopupPowerAnimation(clip.tf_power);
         tabButtons = new Dictionary();
         toggle = new ToggleGroup();
         _loc2_ = mediator.tabs.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = createButton(mediator.tabs[_loc3_]);
            toggle.addItem(_loc5_);
            clip.layout_tabs.addChild(_loc5_.graphics);
            tabButtons[mediator.tabs[_loc3_]] = _loc5_;
            _loc3_++;
         }
         toggle.selectedIndex = mediator.selectedTabIndex;
         toggle.signal_updateSelectedItem.add(handler_tabSelected);
         commitTabContentVisibility();
         updatePower(false);
         commitData();
      }
      
      protected function createMiniList() : void
      {
         miniList = new HeroPopupMiniHeroList(clip.minilist_layout_container,clip.miniList_leftArrow,clip.miniList_rightArrow);
         miniList.dataProvider = mediator.miniHeroListDataProvider;
         miniList.selectedItem = mediator.miniHeroListSelectedItem;
         miniList.addEventListener("change",handler_miniListSelectionChange);
      }
      
      override protected function draw() : void
      {
         if(isInvalid("INVALIDATION_FLAG_FRAGMENT_COUNT"))
         {
            updateFragmentCount();
         }
         if(isInvalid("INVALIDATION_FLAG_TABS"))
         {
            updateTabs();
         }
         super.draw();
      }
      
      private function _horizontalLayout() : HorizontalLayout
      {
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.horizontalAlign = "center";
         _loc1_.gap = 3;
         return _loc1_;
      }
      
      private function commitData() : void
      {
         commitTabData();
         heroPreview.loadHero(mediator.heroEntry.hero,mediator.currentSkin);
         miniList.selectedItem = mediator.miniHeroListSelectedItem;
         updateInventory();
         updateFragmentCount();
         updateExp();
         onHeroPromotableUpdate();
         onHeroEvolveWatchUpdate();
         onHeroExpIncreaseWatchUpdate();
         updatePower(false);
         if(color_label)
         {
            color_label.dispose();
         }
         color_label = HeroColorNumberClip.create(mediator.heroColor,false);
         if(color_label)
         {
            clip.layout_name.addChild(color_label.graphics);
         }
         clip.label_name.text = mediator.title;
         clip.ribbon_image.image.textures = getRibbonTexture(mediator.heroColor);
         updateTabs();
      }
      
      private function commitTabData() : void
      {
         var _loc1_:* = mediator.tabSelected;
         if("TAB_SKINS" !== _loc1_)
         {
            if("TAB_GEAR" !== _loc1_)
            {
               if("TAB_PORTRAIT" !== _loc1_)
               {
                  if("TAB_SKILLS" !== _loc1_)
                  {
                     if("TAB_STATS" !== _loc1_)
                     {
                        if("TAB_RUNE" !== _loc1_)
                        {
                           if("TAB_ELEMENT" !== _loc1_)
                           {
                              if("TAB_ARTIFACTS" === _loc1_)
                              {
                                 clip.artifactsTab.update();
                              }
                           }
                           else
                           {
                              clip.elementTab.update();
                           }
                        }
                        else
                        {
                           clip.runeTab.update();
                        }
                     }
                     else
                     {
                        clip.statList.updateStats();
                     }
                  }
                  else
                  {
                     clip.skillList.updateSkills();
                  }
               }
               else
               {
                  clip.epic_art_frame.commitData(mediator.hero);
               }
            }
            else
            {
               clip.gearList.updateGear(mediator.gearList,mediator.heroEntry);
            }
         }
         else
         {
            clip.skinList.update();
         }
      }
      
      private function commitTabContentVisibility() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc3_:int = 0;
         var _loc2_:* = tabContent;
         for each(_loc1_ in tabContent)
         {
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
         _loc1_ = tabContent[mediator.tabSelected];
         if(_loc1_)
         {
            _loc3_ = 0;
            _loc1_.y = _loc3_;
            _loc1_.x = _loc3_;
            clip.layout_tab_content.addChild(_loc1_);
         }
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
      
      private function updateTabs() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = tabButtons;
         for(var _loc1_ in tabButtons)
         {
            (tabButtons[_loc1_] as PopupSideTab).NewIcon_inst0.graphics.visible = mediator.getTabVisibleByID(_loc1_);
         }
      }
      
      private function updateInventory() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = inventoryList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            inventoryList[_loc2_].data = mediator.inventoryList[_loc2_];
            _loc2_++;
         }
         updatePromoteButton();
      }
      
      private function updatePromoteButton() : void
      {
         if(mediator.slotsToFill.length)
         {
            clip.button_promote.label = Translate.translate("UI_DIALOG_HERO_BUTTON_EQUIP_ALL");
         }
         else
         {
            clip.button_promote.label = Translate.translate("UI_DIALOG_HERO_BUTTON_PROMOTE");
         }
         Tutorial.updateActionsFrom(this);
      }
      
      private function updateFragmentCount() : void
      {
         clip.setStarCount(mediator.starCount);
         if(mediator.soulstoneMax)
         {
            var _loc1_:int = 1;
            clip.progressbar_fragments.value = _loc1_;
            clip.progressbar_fragments.maxValue = _loc1_;
            clip.tf_fragments.text = String(mediator.soulstoneCount);
         }
         else
         {
            clip.progressbar_fragments.maxValue = mediator.soulstoneMaxCount;
            clip.progressbar_fragments.value = mediator.soulstoneCount;
            clip.tf_fragments.text = mediator.soulstoneCount + "/" + mediator.soulstoneMaxCount;
         }
      }
      
      private function updateExp() : void
      {
         clip.progressbar_xp.maxValue = mediator.xpNextLevel;
         clip.progressbar_xp.minValue = mediator.xpCurrentLevel;
         clip.progressbar_xp.value = mediator.xpCurrent;
         clip.tf_label_xp.text = mediator.xpCurrent + "/" + mediator.xpNextLevel;
         clip.tf_level.text = mediator.level.toString();
      }
      
      private function updatePower(param1:Boolean = true) : void
      {
         var _loc2_:int = mediator.power;
         if(param1)
         {
            powerAnimation.setValue(_loc2_);
         }
         else
         {
            powerAnimation.setValueWithoutAnimation(_loc2_);
         }
      }
      
      private function createButton(param1:String) : PopupSideTab
      {
         var _loc2_:PopupSideTab = AssetStorage.rsx.popup_theme.create_side_dialog_tab_hero();
         _loc2_.label = Translate.translate("UI_DIALOG_HERO_" + param1.toUpperCase());
         return _loc2_;
      }
      
      private function onHeroEvolve() : void
      {
         commitData();
      }
      
      private function onHeroPromote() : void
      {
         commitData();
      }
      
      private function handler_skillUpgrade(param1:HeroPopupSkillValueObject) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(mediator.tabSelected == "TAB_SKILLS")
         {
            _loc2_ = clip.skillList.getSkillRenderer(param1.skill.skill).graphics;
            if(_loc2_)
            {
               _loc3_ = param1.tooltipValueObject.getUpgradeMessage();
               FloatingTextContainer.showInDisplayObjectCenter(_loc2_,0,20,_loc3_,mediator);
            }
         }
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
      
      private function onHeroSkillWatchUpdate() : void
      {
         invalidate("INVALIDATION_FLAG_TABS");
      }
      
      private function onHeroSkinWatchUpdate() : void
      {
         invalidate("INVALIDATION_FLAG_TABS");
      }
      
      private function onTabUpdate() : void
      {
         commitTabContentVisibility();
         commitTabData();
      }
      
      private function onHeroPromotableUpdate() : void
      {
         clip.button_promote.glow = mediator.actionAvailable_promote;
      }
      
      private function onHeroEvolveWatchUpdate() : void
      {
         var _loc1_:Boolean = mediator.actionAvailable_evolve;
         var _loc2_:* = !_loc1_;
         clip.progressbar_fragments.graphics.visible = _loc2_;
         clip.layout_fragments.graphics.visible = _loc2_;
         _loc2_ = _loc1_;
         clip.button_evolve.glow = _loc2_;
         clip.button_evolve.graphics.visible = _loc2_;
      }
      
      private function onHeroExpIncreaseWatchUpdate() : void
      {
         var _loc1_:Boolean = mediator.actionAvailable_expIncrease;
         clip.icon_can_xp_plus.graphics.visible = _loc1_;
      }
      
      private function onHeroInventorySlotsUpdate() : void
      {
         updatePromoteButton();
      }
      
      private function onFragmentCountUpdate() : void
      {
         invalidate("INVALIDATION_FLAG_FRAGMENT_COUNT");
      }
      
      private function handler_inventoryPanelClick(param1:HeroPopupInventoryItemRenderer) : void
      {
         mediator.action_inventorySlotSelect(param1.data as HeroInventorySlotValueObject);
      }
      
      private function handler_miniListSelectionChange(param1:Event) : void
      {
         mediator.action_miniListSelectionUpdate(miniList.selectedItem as PlayerHeroEntryValueObject);
      }
      
      private function handler_heroChanged() : void
      {
         updatedStatsQueue.reset();
         updatePower(false);
         commitData();
      }
      
      private function handler_tabSelected() : void
      {
         mediator.action_tabSelect(toggle.selectedIndex);
         Tutorial.updateActionsFrom(this);
      }
      
      private function handler_gearListItemSelect(param1:GearItemDescription) : void
      {
         PopupList.instance.popup_item_info(param1,mediator.hero.hero,Stash.click("item_info",stashParams));
      }
      
      private function handler_updateExp() : void
      {
         updateExp();
      }
      
      private function handler_levelUp() : void
      {
      }
      
      private function handler_powerUpdate() : void
      {
         updatePower();
      }
      
      private function handler_skinUpgrade(param1:SkinDescription, param2:uint) : void
      {
      }
      
      private function handler_skinBrowse(param1:SkinDescription) : void
      {
         heroPreview.loadHero(mediator.heroEntry.hero,param1.id);
      }
      
      private function handler_updateTitanGiftLevelUpAvaliable() : void
      {
         invalidate("INVALIDATION_FLAG_TABS");
      }
      
      private function handler_runeUpgrade() : void
      {
         invalidate("INVALIDATION_FLAG_TABS");
      }
      
      private function handler_heroArtifactUpgrade() : void
      {
         invalidate("INVALIDATION_FLAG_TABS");
      }
   }
}

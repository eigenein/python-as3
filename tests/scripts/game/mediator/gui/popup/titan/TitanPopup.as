package game.mediator.gui.popup.titan
{
   import battle.BattleStats;
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetList;
   import engine.core.assets.RequestableAsset;
   import engine.core.clipgui.GuiAnimation;
   import feathers.layout.HorizontalLayoutData;
   import flash.geom.Point;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.artifacts.PlayerTitanArtifactVO;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.titan.minilist.TitanPopupMiniHeroList;
   import game.model.user.hero.PlayerHeroSkill;
   import game.model.user.inventory.InventoryItem;
   import game.util.NumberUtils;
   import game.view.gui.components.HeroPreview;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.gui.floatingtext.FloatingTextContainer;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import game.view.popup.hero.HeroPopupPowerAnimation;
   import game.view.popup.hero.TimerQueueDispenser;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class TitanPopup extends AsyncClipBasedPopupWithPreloader implements ITutorialActionProvider, ITutorialNodePresenter
   {
      
      public static const INVALIDATION_FLAG_FRAGMENT_COUNT:String = "INVALIDATION_FLAG_FRAGMENT_COUNT";
       
      
      private var mediator:TitanPopupMediator;
      
      private var updatedStatsQueue:TimerQueueDispenser;
      
      private var clip:TitanPopupClip;
      
      private var powerAnimation:HeroPopupPowerAnimation;
      
      private var miniList:TitanPopupMiniHeroList;
      
      private var titanPreview:HeroPreview;
      
      private var hoverLevelUpByConsumable:TouchHoverContoller;
      
      private var hoverLevelUpByStarMoney:TouchHoverContoller;
      
      private var hoverEvolve:TouchHoverContoller;
      
      private var _progressAsset:RequestableAsset;
      
      public function TitanPopup(param1:TitanPopupMediator)
      {
         super(param1,AssetStorage.rsx.clan_screen);
         this.mediator = param1;
         param1.signl_fragmentCountUpdate.add(onFragmentCountUpdate);
         param1.signal_experienceUpdate.add(handler_updateExp);
         param1.signal_evolvableStatusUpdate.add(onHeroEvolveWatchUpdate);
         param1.signal_titanEvolve.add(onHeroEvolve);
         param1.signal_titanChanged.add(handler_heroChanged);
         param1.signal_powerUpdate.add(handler_powerUpdate);
         param1.signal_statsUpdate.add(handler_statsUpdate);
         var _loc2_:AssetList = new AssetList();
         _loc2_.addAssets(AssetStorage.rsx.titan_artifact_icons,AssetStorage.rsx.clan_screen);
         _progressAsset = _loc2_;
         AssetStorage.instance.globalLoader.requestAsset(_loc2_);
      }
      
      override public function dispose() : void
      {
         if(miniList)
         {
            miniList.dataProvider = null;
            miniList.selectedItem = null;
         }
         if(!clip.tooltip.graphics.parent)
         {
            clip.tooltip.graphics.dispose();
         }
         updatedStatsQueue.dispose();
         titanPreview.dispose();
         hoverLevelUpByConsumable && hoverLevelUpByConsumable.dispose();
         hoverLevelUpByStarMoney && hoverLevelUpByStarMoney.dispose();
         hoverEvolve && hoverEvolve.dispose();
         super.dispose();
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TITAN;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addButtonWithKey(TutorialNavigator.ACTION_TITAN_LEVEL_UP_POTION,clip.upgrade_level_info.button_level_up_1,mediator.titan.titan);
         _loc2_.addButtonWithKey(TutorialNavigator.ACTION_TITAN_LEVEL_UP_GEM,clip.upgrade_level_info.button_level_up_2,mediator.titan.titan);
         _loc2_.addButtonWithKey(TutorialNavigator.ACTION_EVOLVE_HERO,clip.button_evolve,mediator.titan.titan);
         _loc2_.addCloseButton(clip.button_close);
         return _loc2_;
      }
      
      override protected function get progressAsset() : RequestableAsset
      {
         return _progressAsset;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc2_:int = 0;
         clip = AssetStorage.rsx.popup_theme.create_dialog_titan();
         addChild(clip.graphics);
         updatedStatsQueue = new TimerQueueDispenser(BattleStatValueObject,400);
         updatedStatsQueue.signal_onElement.add(onUpdatedStatDelivered);
         clip.button_close.signal_click.add(mediator.close);
         titanPreview = new HeroPreview();
         clip.titan_position.container.addChild(titanPreview.graphics);
         titanPreview.graphics.touchable = false;
         clip.tf_artifacts.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACTS");
         clip.tf_artifact_spirit.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACT_SPIRIT");
         clip.tf_pyramid.text = Translate.translate("UI_DIALOG_TITAN_PYRAMID");
         clip.tf_pyramid.layoutData = new HorizontalLayoutData();
         (clip.tf_pyramid.layoutData as HorizontalLayoutData).percentWidth = 100;
         clip.tf_power_label.text = Translate.translate("UI_DIALOG_TITAN_POWER");
         powerAnimation = new HeroPopupPowerAnimation(clip.tf_power);
         clip.tf_label_fragments.text = Translate.translate("UI_DIALOG_HERO_FRAGMENTS");
         clip.tf_label_fragments_desc.text = Translate.translate("UI_DIALOG_TITAN_FRAGMENTS_DESC");
         clip.tf_label_summon_circle.text = Translate.translate("UI_DIALOG_TITAN_SUMMON_CIRCLE");
         clip.button_fragment_find.label = Translate.translate("UI_DIALOG_TITAN_FIND");
         clip.button_evolve.label = Translate.translate("UI_DIALOG_HERO_BUTTON_EVOLVE");
         clip.button_evolve.signal_click.add(mediator.action_evolveTitan);
         clip.tf_label_level.text = Translate.translate("UI_DIALOG_TITAN_LEVEL");
         clip.upgrade_level_info.tf_label_level_up_1.text = Translate.translate("UI_DIALOG_TITAN_LEVEL_UP_1");
         clip.upgrade_level_info.tf_label_level_up_2.text = Translate.translate("UI_DIALOG_TITAN_LEVEL_UP_2");
         clip.upgrade_level_info.button_level_up_1.label = Translate.translate("UI_DIALOG_TITAN_LEVEL_UP");
         clip.upgrade_level_info.button_level_up_2.label = Translate.translate("UI_DIALOG_TITAN_LEVEL_UP");
         clip.btn_use.label = Translate.translate("UI_DIALOG_TITAN_USE");
         clip.btn_use.signal_click.add(handler_useButtonClick);
         clip.tooltip.graphics.touchable = false;
         clip.tooltip.tf_pyramid.text = Translate.translate("UI_DIALOG_TITAN_SPARK_BONUS");
         clip.tooltip.tf_pyramid.adjustSizeToFitWidth();
         clip.upgrade_level_info.button_level_up_1.signal_click.add(mediator.action_levelUpByConsumable);
         clip.upgrade_level_info.button_level_up_2.signal_click.add(mediator.action_levelUpByStarMoney);
         clip.button_fragment_find.signal_click.add(mediator.action_navigateToSummoningCircle);
         hoverLevelUpByConsumable = new TouchHoverContoller(clip.upgrade_level_info.button_level_up_1.container);
         hoverLevelUpByConsumable.signal_hoverChanger.add(handler_hoverLevelUpByConsumable);
         hoverLevelUpByStarMoney = new TouchHoverContoller(clip.upgrade_level_info.button_level_up_2.container);
         hoverLevelUpByStarMoney.signal_hoverChanger.add(handler_hoverLevelUpByStarMoney);
         hoverEvolve = new TouchHoverContoller(clip.button_evolve.container);
         hoverEvolve.signal_hoverChanger.add(handler_hoverEvolve);
         createMiniList();
         commitData();
         mediator.signal_titanArtifactUpgrade.add(handler_titanArtifactUpgrade);
         mediator.signal_titanSparkUpdate.add(handler_titanSparkUpdate);
         handler_titanSparkUpdate();
         _loc2_ = 0;
         while(_loc2_ < clip.artifact_.length)
         {
            clip.artifact_[_loc2_].signal_click.add(handler_artifactClick);
            _loc2_++;
         }
         clip.artifact_spirit.signal_click.add(handler_spiritArtifactClick);
         height = clip.dialog_frame.graphics.height;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
      
      override protected function draw() : void
      {
         if(isInvalid("INVALIDATION_FLAG_FRAGMENT_COUNT"))
         {
            if(clip)
            {
               updateFragmentCount();
            }
         }
         super.draw();
      }
      
      private function commitData() : void
      {
         titanPreview.loadTitan(mediator.titan.titan);
         clip.tf_label_desc.text = mediator.titanDesc;
         clip.tf_label_element.text = Translate.translateArgs("UI_DIALOG_TITAN_ELEMENT",ColorUtils.hexToRGBFormat(16645626) + Translate.translate("LIB_TITAN_ELEMENT_" + mediator.titanElement.toUpperCase()));
         clip.element_icon.image.texture = AssetStorage.rsx.popup_theme.getTexture("icon_element_" + mediator.titanElement);
         clip.label_name.text = mediator.titanName;
         miniList.selectedItem = mediator.miniTitanListSelectedItem;
         updateBattleStats(false,false,null);
         updateFragmentCount();
         updateExp();
         onHeroEvolveWatchUpdate();
         updatePower(false);
         updateSkills();
         updateArtifacts();
      }
      
      private function updateArtifacts() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<PlayerTitanArtifactVO> = mediator.titanArtifactsList;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            clip.artifact_[_loc1_].setData(_loc2_[_loc1_]);
            _loc1_++;
         }
         clip.artifact_spirit.setData(mediator.titanSpiritArtifactVO);
      }
      
      private function updateSkills() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         clip.skills_layout.removeChild(clip.tf_skills);
         clip.skills_layout.removeChildren(0,-1,true);
         clip.skills_layout.addChild(clip.tf_skills);
         var _loc1_:Vector.<PlayerHeroSkill> = mediator.titan.skillData.getSkillList();
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = new TitanSkillRenderer();
            var _loc4_:* = 0.7;
            _loc2_.scaleY = _loc4_;
            _loc2_.scaleX = _loc4_;
            _loc2_.data = new TitanSkillValueObject(mediator.titan,_loc1_[_loc3_].skill);
            clip.skills_layout.addChild(_loc2_);
            _loc3_++;
         }
         clip.tf_skills.text = Translate.translateArgs("UI_DIALOG_TITAN_SKILLS",_loc1_.length);
      }
      
      private function createMiniList() : void
      {
         miniList = new TitanPopupMiniHeroList(clip.minilist_layout_container,clip.miniList_leftArrow,clip.miniList_rightArrow);
         miniList.dataProvider = mediator.miniTitanListDataProvider;
         miniList.selectedItem = mediator.miniTitanListSelectedItem;
         miniList.addEventListener("change",handler_miniListSelectionChange);
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
         clip.tf_power_label.validate();
         clip.tf_power.validate();
         clip.power_bg.graphics.width = clip.tf_power_label.width + clip.power_icon.graphics.width + clip.tf_power.width + 40;
         clip.power_bg.graphics.x = clip.layout_power.x + (clip.layout_power.width - clip.power_bg.graphics.width) / 2;
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
         var _loc2_:* = mediator.level >= mediator.levelMax;
         var _loc1_:* = mediator.level >= mediator.levelMaxByTeam;
         clip.max_level_info.graphics.visible = _loc2_ || _loc1_;
         clip.upgrade_level_info.graphics.visible = !(_loc2_ || _loc1_);
         clip.tf_level.text = mediator.level.toString();
         if(!(_loc2_ || _loc1_))
         {
            clip.upgrade_level_info.price_1.data = mediator.expComsumableCost;
            clip.upgrade_level_info.price_2.data = mediator.levelUpCost;
            var _loc3_:* = Math.max(clip.upgrade_level_info.price_1.tf_amount.width,clip.upgrade_level_info.price_2.tf_amount.width) + 30;
            clip.upgrade_level_info.price_2.bg.graphics.width = _loc3_;
            clip.upgrade_level_info.price_1.bg.graphics.width = _loc3_;
         }
         else if(_loc2_)
         {
            clip.max_level_info.tf_text.text = Translate.translate("UI_DIALOG_TITAN_MAX_LEVEL");
         }
         else if(_loc1_)
         {
            clip.max_level_info.tf_text.text = Translate.translate("UI_DIALOG_TITAN_MAX_LEVEL_BY_TEAM");
         }
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
      
      private function updateBattleStats(param1:Boolean, param2:Boolean, param3:DisplayObject) : void
      {
         var _loc5_:Number = NaN;
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var _loc6_:BattleStats = mediator.titan.battleStats;
         var _loc4_:BattleStats = null;
         if(param1)
         {
            _loc4_ = mediator.titan.getBasicBattleStatsNextLevel();
         }
         else if(param2)
         {
            _loc4_ = mediator.titan.getBasicBattleStatsNextStar();
         }
         if(_loc6_)
         {
            if(_loc4_)
            {
               _loc5_ = _loc4_.physicalAttack - _loc6_.physicalAttack;
               clip.tf_health.text = Translate.translate("LIB_BATTLESTATDATA_HP") + ": " + ColorUtils.hexToRGBFormat(16645626) + NumberUtils.numberToString(Math.round(_loc6_.hp)) + ColorUtils.hexToRGBFormat(15919178) + " +" + NumberUtils.numberToString(Math.round(_loc4_.hp) - Math.round(_loc6_.hp));
               clip.tf_attack.text = Translate.translate("LIB_BATTLESTATDATA_ATTACK") + ": " + ColorUtils.hexToRGBFormat(16645626) + NumberUtils.numberToString(Math.round(_loc6_.physicalAttack)) + ColorUtils.hexToRGBFormat(15919178) + " +" + NumberUtils.numberToString(Math.round(_loc4_.physicalAttack) - Math.round(_loc6_.physicalAttack));
            }
            else
            {
               clip.tf_health.text = Translate.translate("LIB_BATTLESTATDATA_HP") + ": " + ColorUtils.hexToRGBFormat(16645626) + NumberUtils.numberToString(Math.round(_loc6_.hp));
               clip.tf_attack.text = Translate.translate("LIB_BATTLESTATDATA_ATTACK") + ": " + ColorUtils.hexToRGBFormat(16645626) + NumberUtils.numberToString(Math.round(_loc6_.physicalAttack));
            }
         }
         if(param1 || param2)
         {
            Starling.current.stage.addChild(clip.tooltip.graphics);
            if(param3)
            {
               _loc8_ = param3.parent.localToGlobal(new Point(param3.x,param3.y));
               clip.tooltip.graphics.x = _loc8_.x + param3.width / 2 - clip.tooltip.graphics.width / 2;
               clip.tooltip.graphics.y = _loc8_.y - clip.tooltip.graphics.height + 5;
            }
            if(param1)
            {
               _loc7_ = mediator.powerNextLevel - mediator.power;
               clip.tooltip.tf_power.text = "+" + _loc7_;
               clip.tooltip.pyramid_counter.data = new InventoryItem(DataStorage.consumable.getTitanSparkDesc(),_loc7_);
            }
            else if(param2)
            {
               _loc7_ = mediator.powerNextStar - mediator.power;
               clip.tooltip.tf_power.text = "+" + _loc7_;
               clip.tooltip.pyramid_counter.data = new InventoryItem(DataStorage.consumable.getTitanSparkDesc(),_loc7_);
            }
         }
         else
         {
            clip.tooltip.graphics.removeFromParent();
         }
      }
      
      private function handler_heroChanged() : void
      {
         updatedStatsQueue.reset();
         commitData();
      }
      
      private function handler_powerUpdate() : void
      {
         updatePower();
      }
      
      private function onFragmentCountUpdate() : void
      {
         invalidate("INVALIDATION_FLAG_FRAGMENT_COUNT");
      }
      
      private function handler_updateExp() : void
      {
         var _loc1_:* = null;
         updateExp();
         if(titanPreview)
         {
            titanPreview.win();
         }
         if(AssetStorage.rsx.clan_screen.completed)
         {
            _loc1_ = AssetStorage.rsx.clan_screen.create(GuiAnimation,"levelup_fx_titan");
            _loc1_.playOnceAndHide();
            _loc1_.disposeWhenCompleted = true;
            _loc1_.container.x = 0;
            _loc1_.container.y = -20;
            clip.titan_position.container.addChild(_loc1_.container);
            _loc1_ = AssetStorage.rsx.clan_screen.create(GuiAnimation,"levelup_fx_xp");
            _loc1_.playOnceAndHide();
            _loc1_.disposeWhenCompleted = true;
            _loc1_.container.x = 25;
            _loc1_.container.y = 23;
            clip.icon_exp.container.addChild(_loc1_.container);
         }
      }
      
      private function onHeroEvolve() : void
      {
         commitData();
      }
      
      private function handler_miniListSelectionChange(param1:Event) : void
      {
         mediator.action_miniListSelectionUpdate(miniList.selectedItem as PlayerTitanEntryValueObject);
      }
      
      private function handler_statsUpdate(param1:Vector.<BattleStatValueObject>) : void
      {
         updatedStatsQueue.add(param1);
      }
      
      private function onUpdatedStatDelivered(param1:BattleStatValueObject) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc5_:Number = NaN;
         var _loc3_:Number = NaN;
         if(titanPreview.graphics)
         {
            if(param1.ident == "physicalAttack")
            {
               _loc2_ = mediator.titan.battleStats;
               _loc5_ = _loc2_.physicalAttack;
               _loc3_ = _loc5_ - param1.value;
               _loc4_ = param1.name + " +" + NumberUtils.numberToString(Math.round(_loc5_) - Math.round(_loc3_));
            }
            else
            {
               _loc4_ = param1.name + " +" + NumberUtils.numberToString(int(param1.value));
            }
            FloatingTextContainer.showInDisplayObjectCenter(titanPreview.graphics,0,30,_loc4_,mediator,300);
         }
      }
      
      private function handler_hoverEvolve() : void
      {
         if(hoverEvolve.hover)
         {
            updateBattleStats(false,true,clip.button_evolve.graphics);
         }
         else
         {
            updateBattleStats(false,false,null);
         }
      }
      
      private function handler_hoverLevelUpByStarMoney() : void
      {
         if(hoverLevelUpByStarMoney.hover)
         {
            updateBattleStats(true,false,clip.upgrade_level_info.button_level_up_2.graphics);
         }
         else
         {
            updateBattleStats(false,false,null);
         }
      }
      
      private function handler_hoverLevelUpByConsumable() : void
      {
         if(hoverLevelUpByConsumable.hover)
         {
            updateBattleStats(true,false,clip.upgrade_level_info.button_level_up_1.graphics);
         }
         else
         {
            updateBattleStats(false,false,null);
         }
      }
      
      private function handler_useButtonClick() : void
      {
         mediator.action_navigateToForge();
      }
      
      private function handler_titanSparkUpdate() : void
      {
         clip.pyramid_counter.data = mediator.playerTitanSpark;
      }
      
      private function handler_titanArtifactUpgrade() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < clip.artifact_.length)
         {
            clip.artifact_[_loc1_].updateRedDotState();
            _loc1_++;
         }
         clip.artifact_spirit.updateRedDotState();
         updateBattleStats(false,false,null);
         updatePower();
      }
      
      private function handler_artifactClick(param1:PlayerTitanArtifactVO) : void
      {
         if(param1)
         {
            mediator.action_navigate_to_artifacts(param1.artifact.desc);
         }
      }
      
      private function handler_spiritArtifactClick(param1:PlayerTitanArtifactVO) : void
      {
         if(param1)
         {
            mediator.action_navigate_to_spirit_artifacts(param1.artifact);
         }
      }
   }
}

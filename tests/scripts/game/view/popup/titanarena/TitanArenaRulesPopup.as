package game.view.popup.titanarena
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetList;
   import engine.core.assets.RequestableAsset;
   import engine.core.clipgui.GuiAnimation;
   import feathers.controls.LayoutGroup;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.storage.titanarenaleague.TitanArenaReward;
   import game.data.storage.titanarenaleague.TitanArenaTournamentReward;
   import game.mediator.gui.popup.titanarena.TitanArenaRulesPopupMediator;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GameLabel;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrollContainer;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import game.view.popup.common.PopupSideTab;
   import game.view.popup.theme.LabelStyle;
   
   public class TitanArenaRulesPopup extends AsyncClipBasedPopupWithPreloader implements ITutorialActionProvider, ITutorialNodePresenter
   {
       
      
      private var mediator:TitanArenaRulesPopupMediator;
      
      private var clip:TitanArenaRulesPopupClip;
      
      private var scrollContainer:GameScrollContainer;
      
      private var content:ClipLayout;
      
      private var toggle:ToggleGroup;
      
      private var _progressAsset:RequestableAsset;
      
      public function TitanArenaRulesPopup(param1:TitanArenaRulesPopupMediator)
      {
         super(param1,AssetStorage.rsx.dialog_titan_arena);
         this.mediator = param1;
         var _loc2_:AssetList = new AssetList();
         _loc2_.addAssets(AssetStorage.rsx.dialog_titan_arena);
         _progressAsset = _loc2_;
         AssetStorage.instance.globalLoader.requestAsset(_loc2_);
      }
      
      override protected function get progressAsset() : RequestableAsset
      {
         return _progressAsset;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TITAN_VALLEY_ARENA_RULES;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:* = null;
         if(clip == null)
         {
            return TutorialActionsHolder.create(this);
         }
         _loc2_ = TutorialActionsHolder.create(clip.graphics);
         _loc2_.addCloseButton(clip.button_close);
         return _loc2_;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         clip = AssetStorage.rsx.dialog_titan_arena.create(TitanArenaRulesPopupClip,"dialog_titan_arena_rules");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width - 100;
         height = clip.dialog_frame.graphics.height;
         clip.button_close.signal_click.add(close);
         var _loc2_:GameScrollBar = new GameScrollBar();
         _loc2_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc2_);
         scrollContainer = new GameScrollContainer(_loc2_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         (scrollContainer.layout as VerticalLayout).horizontalAlign = "center";
         (scrollContainer.layout as VerticalLayout).gap = 8;
         scrollContainer.width = clip.list_container.graphics.width;
         scrollContainer.height = clip.list_container.graphics.height;
         clip.list_container.addChild(scrollContainer);
         content = ClipLayout.verticalCenter(10);
         scrollContainer.addChild(content);
         toggle = new ToggleGroup();
         var _loc3_:int = mediator.tabs.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = createButton(mediator.tabs[_loc4_]);
            toggle.addItem(_loc5_);
            clip.layout_tabs.addChild(_loc5_.graphics);
            if(mediator.tabs[_loc4_] == mediator.selectedTab)
            {
               toggle.selectedIndex = _loc4_;
            }
            _loc4_++;
         }
         toggle.signal_updateSelectedItem.add(handler_tabSelected);
         updateContent(toggle.selectedIndex);
      }
      
      private function updateContent(param1:uint) : void
      {
         var _loc3_:* = undefined;
         var _loc7_:* = undefined;
         var _loc9_:* = undefined;
         var _loc4_:* = undefined;
         var _loc6_:* = undefined;
         var _loc5_:* = null;
         var _loc10_:* = undefined;
         var _loc8_:* = 0;
         var _loc2_:* = null;
         var _loc11_:* = null;
         scrollContainer.verticalScrollPosition = 0;
         content.removeChildren();
         switch(int(param1))
         {
            case 0:
               addGraphics();
               addText(LabelStyle.label_size24_beige_center(),Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_RULE_1"));
               if(mediator.tournamentRaidIsStageBased)
               {
                  addText(LabelStyle.label_size16_multiline(),Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_RULE_1_DESC_NEW"));
               }
               else
               {
                  addText(LabelStyle.label_size16_multiline(),Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_RULE_1_DESC"));
               }
               addText(LabelStyle.label_size24_beige_center(),Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_RULE_2"));
               addText(LabelStyle.label_size16_multiline(),Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_RULE_2_DESC"));
               break;
            case 1:
               _loc3_ = mediator.getTournamentRewardListByCupId(1);
               _loc7_ = mediator.getTournamentRewardListByCupId(2);
               _loc9_ = mediator.getTournamentRewardListByCupId(3);
               _loc4_ = mediator.getTournamentRewardListByCupId(4);
               _loc6_ = mediator.getTournamentRewardListByCupId(5);
               addText(LabelStyle.label_size24_beige_center(),Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_CUPS"));
               addText(LabelStyle.label_size16_multiline(),Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_CUPS_DESC"));
               addCupAnimation("cup_1_animation_with_bg");
               addSpacer(0,-250);
               addText(LabelStyle.createLabel(18,16770485,"center"),Translate.translate("LIB_TITAN_ARENA_CUP_1"));
               addSpacer(0,164);
               addTournamentRewardsTitle();
               addTournamentRewards(_loc3_,_loc7_);
               addCupAnimation("cup_2_animation_with_bg");
               addSpacer(0,-250);
               addText(LabelStyle.createLabel(18,16770485,"center"),Translate.translate("LIB_TITAN_ARENA_CUP_2"));
               addSpacer(0,164);
               addTournamentRewardsTitle();
               addTournamentRewards(_loc7_,_loc9_);
               addCupAnimation("cup_3_animation_with_bg");
               addSpacer(0,-250);
               addText(LabelStyle.createLabel(18,16770485,"center"),Translate.translate("LIB_TITAN_ARENA_CUP_3"));
               addSpacer(0,164);
               addTournamentRewardsTitle();
               addTournamentRewards(_loc9_,_loc4_);
               addCupAnimation("cup_4_animation_with_bg");
               addSpacer(0,-250);
               addText(LabelStyle.createLabel(18,16770485,"center"),Translate.translate("LIB_TITAN_ARENA_CUP_4"));
               addSpacer(0,164);
               addTournamentRewardsTitle();
               addTournamentRewards(_loc4_,_loc6_);
               addText(LabelStyle.createLabel(18,16770485,"center"),Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_CUPS_REWARD"));
               addTournamentRewardsTitle();
               addTournamentRewards(_loc6_,null);
               break;
            case 2:
               addText(LabelStyle.label_size24_beige_center(),Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_POINTS"));
               addText(LabelStyle.label_size16_multiline(),Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_POINTS_DESC_1"));
               _loc5_ = AssetStorage.rsx.dialog_titan_arena.create(TitanArenaPointsRewardsTitlesClip,"titan_arena_points_rewards_title");
               _loc5_.setTitles(Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_WEEK_POINTS"),Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_VICTORY_REWARD"));
               content.addChild(_loc5_.container);
               _loc10_ = mediator.victoryRewardList;
               _loc8_ = uint(0);
               while(_loc8_ < _loc10_.length)
               {
                  if(_loc8_ < _loc10_.length - 1)
                  {
                     _loc2_ = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_RULES_POINTS_RANGE_1",_loc10_[_loc8_].tournamentPoints,_loc10_[_loc8_ + 1].tournamentPoints - 1);
                  }
                  else
                  {
                     _loc2_ = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_RULES_POINTS_RANGE_2",_loc10_[_loc8_].tournamentPoints);
                  }
                  _loc11_ = AssetStorage.rsx.dialog_titan_arena.create(TitanArenaPointsRewardsRenderer,"titan_arena_rules_points_rewards_renderer");
                  _loc11_.setData(_loc2_,_loc10_[_loc8_].reward);
                  content.addChild(_loc11_.container);
                  _loc8_++;
               }
         }
      }
      
      private function addSpacer(param1:Number, param2:Number) : void
      {
         var _loc3_:LayoutGroup = new LayoutGroup();
         _loc3_.width = param1;
         _loc3_.height = param2;
         content.addChild(_loc3_);
      }
      
      private function addGraphics() : void
      {
         var _loc2_:LayoutGroup = new LayoutGroup();
         content.addChild(_loc2_);
         var _loc1_:TitanArenaRulesGraphicsClip = AssetStorage.rsx.dialog_titan_arena.create(TitanArenaRulesGraphicsClip,"rules_info_graphics_clip");
         _loc1_.graphics.x = -10;
         _loc2_.addChild(_loc1_.graphics);
         _loc1_.tf_1.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_GRAPHICS_TEXT_1");
         _loc1_.tf_2.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_GRAPHICS_TEXT_2");
         _loc1_.tf_3.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_GRAPHICS_TEXT_3");
         _loc1_.tf_1.validate();
         _loc1_.tf_2.validate();
         _loc1_.tf_3.validate();
         _loc1_.bg1.graphics.height = Math.max(36,_loc1_.tf_1.height + 20);
         _loc1_.bg2.graphics.height = Math.max(36,_loc1_.tf_2.height + 20);
         _loc1_.bg3.graphics.height = Math.max(36,_loc1_.tf_3.height + 20);
         _loc1_.bg1.graphics.y = _loc1_.graphics.height - _loc1_.bg1.graphics.height - 27;
         _loc1_.bg2.graphics.y = _loc1_.graphics.height - _loc1_.bg2.graphics.height - 27;
         _loc1_.bg3.graphics.y = _loc1_.graphics.height - _loc1_.bg3.graphics.height - 27;
         _loc1_.tf_1.y = _loc1_.bg1.graphics.y + 8;
         _loc1_.tf_2.y = _loc1_.bg2.graphics.y + 8;
         _loc1_.tf_3.y = _loc1_.bg3.graphics.y + 8;
      }
      
      private function addText(param1:GameLabel, param2:String) : void
      {
         param1.width = scrollContainer.width;
         param1.text = param2;
         content.addChild(param1);
      }
      
      private function createButton(param1:String) : PopupSideTab
      {
         var _loc2_:PopupSideTab = AssetStorage.rsx.popup_theme.create(PopupSideTab,"dialog_side_tab_shop");
         _loc2_.label = Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_" + param1.toUpperCase());
         return _loc2_;
      }
      
      private function addCupAnimation(param1:String) : void
      {
         var _loc2_:LayoutGroup = new LayoutGroup();
         _loc2_.height = 230;
         content.addChild(_loc2_);
         var _loc3_:GuiAnimation = AssetStorage.rsx.dialog_titan_arena.create(GuiAnimation,param1);
         _loc2_.addChild(_loc3_.graphics);
      }
      
      private function addTournamentRewardsTitle() : void
      {
         var _loc1_:TitanArenaCupRewardsTitlesClip = AssetStorage.rsx.dialog_titan_arena.create(TitanArenaCupRewardsTitlesClip,"titan_arena_cup_rewards_title");
         content.addChild(_loc1_.container);
      }
      
      private function addTournamentRewards(param1:Vector.<TitanArenaTournamentReward>, param2:Vector.<TitanArenaTournamentReward>) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = 0;
         _loc4_ = uint(0);
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_].placeFrom == param1[_loc4_].placeTo)
            {
               _loc3_ = Translate.translateArgs("UI_COMMON_PLACE",param1[_loc4_].placeFrom);
            }
            else if(_loc4_ < param1.length - 1)
            {
               _loc3_ = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_RULES_PLACE_RANGE_2",param1[_loc4_].placeFrom,param1[_loc4_ + 1].placeFrom - 1);
            }
            else if(param2)
            {
               _loc3_ = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_RULES_PLACE_RANGE_2",param1[_loc4_].placeFrom,param2[0].placeFrom - 1);
            }
            else
            {
               _loc3_ = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_RULES_PLACE_RANGE_3",param1[_loc4_].placeFrom);
            }
            _loc5_ = AssetStorage.rsx.dialog_titan_arena.create(TitanArenaRewardsRenderer,"titan_arena_rewards_renderer");
            _loc5_.setData(_loc3_,param1[_loc4_].winnerReward);
            content.addChild(_loc5_.container);
            _loc4_++;
         }
      }
      
      private function handler_tabSelected() : void
      {
         updateContent(toggle.selectedIndex);
      }
   }
}

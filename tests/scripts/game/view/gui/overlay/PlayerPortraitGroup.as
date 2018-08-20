package game.view.gui.overlay
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiClipFactory;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.homescreen.PlayerStatsPanelMediator;
   import game.view.gui.homescreen.HomeScreenStyle;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.arena.PlayerPortraitClip;
   import starling.display.Sprite;
   
   public class PlayerPortraitGroup extends Sprite implements ITutorialActionProvider
   {
      
      private static const INVALIDATION_FLAG_DOT_DAILY:String = "INVALIDATION_FLAG_DOT_DAILY";
      
      private static const INVALIDATION_FLAG_DOT_MAIL:String = "INVALIDATION_FLAG_DOT_MAIL";
       
      
      private var mediator:PlayerStatsPanelMediator;
      
      private var portrait:PlayerPortraitClip;
      
      private var asset:PlayerPortraitGroupGuiClip;
      
      public function PlayerPortraitGroup(param1:PlayerStatsPanelMediator)
      {
         super();
         this.mediator = param1;
         addEventListener("addedToStage",handler_addedToStage);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.hasSpecialEvents.unsubscribe(handler_hasSpecialEvents);
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addButton(TutorialNavigator.DAILY_BONUSES,asset.button_dailyBonus);
         _loc2_.addButton(TutorialNavigator.DAILY_QUESTS,asset.button_dailyQuest);
         _loc2_.addButton(TutorialNavigator.MAIL,asset.button_mail);
         _loc2_.addButton(TutorialNavigator.PROFILE,portrait);
         _loc2_.addButton(TutorialNavigator.PROFILE,asset.button_nicknameChange);
         _loc2_.addButton(TutorialNavigator.VIP,asset.button_vip);
         return _loc2_;
      }
      
      protected function handler_addedToStage() : void
      {
         removeEventListener("addedToStage",handler_addedToStage);
         asset = new PlayerPortraitGroupGuiClip();
         var _loc1_:GuiClipFactory = new GuiClipFactory();
         _loc1_.create(asset,HomeScreenStyle.asset.data.getClipByName("player_portrait_group"));
         addChild(asset.graphics);
         portrait = AssetStorage.rsx.popup_theme.create(PlayerPortraitClip,"playerPortrait_mainscreen");
         portrait.isEnabled = true;
         portrait.signal_click.add(mediator.action_playerProfile);
         asset.container_portrait.container.addChild(portrait.graphics);
         asset.button_dailyBonus.redMarkerState = mediator.redMarkerMediator.activity;
         asset.button_dailyBonus.signal_click.add(mediator.action_activitySelect);
         mediator.hasSpecialEvents.onValue(handler_hasSpecialEvents);
         asset.button_dailyQuest.redMarkerState = mediator.redMarkerMediator.dailyQuest;
         asset.button_dailyQuest.signal_click.add(mediator.action_dailyQuestSelect);
         asset.button_dailyQuest.label = Translate.translate("UI_MAINMENU_DAILYQUEST");
         asset.button_mail.redMarkerState = mediator.redMarkerMediator.mail;
         asset.button_mail.signal_click.add(mediator.action_mailSelect);
         asset.button_mail.label = Translate.translate("UI_MAINMENU_MAIL");
         asset.button_nicknameChange.signal_click.add(mediator.action_playerProfile);
         asset.button_vip.signal_click.add(mediator.action_addVIP);
         if(mediator.playerInited)
         {
            handler_playerInit();
         }
         else
         {
            mediator.signal_playerInit.add(handler_playerInit);
         }
         mediator.signal_updateVip.add(handler_updateVip);
         mediator.signal_updateAvatar.add(handler_updateAvatar);
         mediator.signal_updateFrame.add(handler_updateAvatar);
         mediator.signal_updateNickname.add(handler_updateNickname);
         mediator.signal_updateLevel.add(handler_updateLevel);
         Tutorial.addActionsFrom(this);
      }
      
      private function handler_playerInit() : void
      {
         handler_updateVip();
         handler_updateAvatar();
         handler_updateLevel();
         handler_updateNickname();
      }
      
      private function handler_updateAvatar() : void
      {
         portrait.setData(mediator.avatarUserInfo);
      }
      
      private function handler_updateVip() : void
      {
         asset.button_vip.label.text = Translate.translateArgs("UI_COMMON_VIP",Number(mediator.vip));
      }
      
      private function handler_updateNickname() : void
      {
         asset.button_nicknameChange.label.text = mediator.nickname;
      }
      
      private function handler_updateLevel() : void
      {
         portrait.setLevel(mediator.level);
      }
      
      private function handler_hasSpecialEvents(param1:Boolean) : void
      {
         if(param1)
         {
            asset.button_dailyBonus.label = Translate.translate("UI_MAINMENU_SPECIALEVENT");
         }
         else
         {
            asset.button_dailyBonus.label = Translate.translate("UI_MAINMENU_DAILYBONUS");
         }
      }
   }
}

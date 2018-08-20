package game.mediator.gui.homescreen
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.mediator.gui.RedMarkerGlobalMediator;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.mail.PlayerMailPopupMeditator;
   import game.mediator.gui.popup.player.PlayerProfilePopupMediator;
   import game.mediator.gui.popup.quest.QuestListPopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import game.model.user.quest.PlayerQuestEventEntry;
   import game.model.user.specialoffer.PlayerSpecialOfferHooks;
   import game.stat.Stash;
   import game.view.gui.overlay.PlayerPortraitGroup;
   import game.view.gui.overlay.PlayerStatsPanel;
   import game.view.popup.activity.SpecialQuestEventPopupMediator;
   import idv.cjcat.signals.Signal;
   
   public class PlayerStatsPanelMediator
   {
       
      
      protected var stashEventParams:PopupStashEventParams;
      
      private var _panel:PlayerStatsPanel;
      
      private var _portraitGroup:PlayerPortraitGroup;
      
      private var player:Player;
      
      private var _resourceDataGroup:ResourcePanelValueObjectGroup;
      
      private var _signal_socialQuestUpdate:Signal;
      
      private var _signal_updateVip:Signal;
      
      private var _signal_playerInit:Signal;
      
      private var _signal_updateLevel:Signal;
      
      private var _signal_updateNickname:Signal;
      
      private var _signal_updateAvatar:Signal;
      
      private var _signal_updateFrame:Signal;
      
      private var _redMarkerMediator:RedMarkerGlobalMediator;
      
      private var _hasSpecialEvents:BooleanPropertyWriteable;
      
      public function PlayerStatsPanelMediator(param1:Player)
      {
         _signal_socialQuestUpdate = new Signal();
         _hasSpecialEvents = new BooleanPropertyWriteable(false);
         super();
         _redMarkerMediator = RedMarkerGlobalMediator.instance;
         this.player = param1;
         _resourceDataGroup = new ResourcePanelValueObjectGroup(param1);
         _resourceDataGroup.requre_gold(true);
         _resourceDataGroup.requre_starmoney(true);
         _resourceDataGroup.requre_stamina(true);
         _signal_updateLevel = param1.signal_update.level;
         _signal_updateNickname = param1.signal_update.nickname;
         _signal_updateAvatar = param1.avatarData.signal_updateAvatar;
         _signal_updateFrame = param1.avatarFrame.signal_update;
         _signal_playerInit = param1.signal_update.initSignal;
         _signal_updateVip = param1.signal_update.vip_points;
         param1.questData.signal_eventAdd.add(handler_eventUpdate);
         param1.questData.signal_eventRemove.add(handler_eventUpdate);
         handler_eventUpdate(null);
         _panel = new PlayerStatsPanel(this);
         _portraitGroup = new PlayerPortraitGroup(this);
         stashEventParams = new PopupStashEventParams();
         stashEventParams.windowName = "global";
         _resourceDataGroup.stashSource = stashEventParams;
      }
      
      public function dispose() : void
      {
         player.questData.signal_eventAdd.remove(handler_eventUpdate);
         player.questData.signal_eventRemove.remove(handler_eventUpdate);
      }
      
      public function get panel() : PlayerStatsPanel
      {
         return _panel;
      }
      
      public function get portraitGroup() : PlayerPortraitGroup
      {
         return _portraitGroup;
      }
      
      public function get resourceDataGroup() : ResourcePanelValueObjectGroup
      {
         return _resourceDataGroup;
      }
      
      public function get signal_socialQuestUpdate() : Signal
      {
         return _signal_socialQuestUpdate;
      }
      
      public function get signal_updateVip() : Signal
      {
         return _signal_updateVip;
      }
      
      public function get signal_playerInit() : Signal
      {
         return _signal_playerInit;
      }
      
      public function get signal_updateLevel() : Signal
      {
         return _signal_updateLevel;
      }
      
      public function get signal_updateNickname() : Signal
      {
         return _signal_updateNickname;
      }
      
      public function get signal_updateAvatar() : Signal
      {
         return _signal_updateAvatar;
      }
      
      public function get signal_updateFrame() : Signal
      {
         return _signal_updateFrame;
      }
      
      public function get playerInited() : Boolean
      {
         return player.isInited;
      }
      
      public function get redMarkerMediator() : RedMarkerGlobalMediator
      {
         return _redMarkerMediator;
      }
      
      public function get hasSpecialEvents() : BooleanProperty
      {
         return _hasSpecialEvents;
      }
      
      public function get gold() : int
      {
         return player.gold;
      }
      
      public function get vip() : int
      {
         return player.vipLevel.level;
      }
      
      public function get level() : int
      {
         return player.levelData.level.level;
      }
      
      public function get nickname() : String
      {
         return player.nickname;
      }
      
      public function get experience() : int
      {
         return player.experience;
      }
      
      public function get starmoney() : int
      {
         return player.starmoney;
      }
      
      public function get stamina() : int
      {
         return player.stamina;
      }
      
      public function get skillpoints() : int
      {
         return player.refillable.skillpoints.value;
      }
      
      public function get avatarUserInfo() : UserInfo
      {
         return player.getUserInfo();
      }
      
      public function get specialOfferHooks() : PlayerSpecialOfferHooks
      {
         return player.specialOffer.hooks;
      }
      
      public function action_addVIP() : void
      {
         PopupList.instance.dialog_bank(stashEventParams);
      }
      
      public function action_playerProfile() : void
      {
         var _loc1_:PlayerProfilePopupMediator = new PlayerProfilePopupMediator(GameModel.instance.player);
         _loc1_.open(Stash.click("persona_params",stashEventParams));
      }
      
      public function action_activitySelect() : void
      {
         var _loc1_:SpecialQuestEventPopupMediator = new SpecialQuestEventPopupMediator(GameModel.instance.player);
         _loc1_.open(Stash.click("activity_retention",stashEventParams));
      }
      
      public function action_dailyQuestSelect() : void
      {
         var _loc1_:QuestListPopupMediator = new QuestListPopupMediator(GameModel.instance.player,1);
         _loc1_.open(Stash.click("quests_daily",stashEventParams));
      }
      
      public function action_mailSelect() : void
      {
         var _loc1_:PlayerMailPopupMeditator = new PlayerMailPopupMeditator(GameModel.instance.player);
         _loc1_.open(Stash.click("mail",stashEventParams));
      }
      
      private function handler_eventUpdate(param1:PlayerQuestEventEntry) : void
      {
         _hasSpecialEvents.value = player.questData.hasSpecialEvents;
      }
   }
}

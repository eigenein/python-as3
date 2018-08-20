package game.command
{
   import com.progrestar.common.Logger;
   import com.progrestar.common.lang.Translate;
   import com.progrestar.common.new_rpc.RPCClientInitializerParams;
   import game.command.realtime.MessageClientFacade;
   import game.command.requirement.CommandRequirement;
   import game.command.requirement.CommandRequirementCheckResult;
   import game.command.rpc.CommandErrorVerbal;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcClient;
   import game.command.rpc.arena.CommandArenaBuyBattles;
   import game.command.rpc.billing.CommandBillingBundleDrop;
   import game.command.rpc.billing.CommandBillingChooseHero;
   import game.command.rpc.billing.CommandBillingGetLast;
   import game.command.rpc.billing.CommandBundleGetAllAvailableId;
   import game.command.rpc.billing.CommandBundlePause;
   import game.command.rpc.chat.ChatCommandList;
   import game.command.rpc.chest.CommandChestBuy;
   import game.command.rpc.chest.CommandChestBuyDevMulti;
   import game.command.rpc.clan.ClanCommandList;
   import game.command.rpc.dailybonus.CommandDailyBonusFarm;
   import game.command.rpc.friends.FriendCommandList;
   import game.command.rpc.grand.CommandGrandBuyBattles;
   import game.command.rpc.grand.CommandGrandSkipCooldown;
   import game.command.rpc.hero.HeroCommandList;
   import game.command.rpc.inventory.InventoryCommandList;
   import game.command.rpc.login.LoginCommandList;
   import game.command.rpc.mail.MailCommandList;
   import game.command.rpc.mission.CommandPirateTreasureFarm;
   import game.command.rpc.mission.MissionCommandList;
   import game.command.rpc.player.PlayerCommandList;
   import game.command.rpc.pushtest.CommandPushBillingTest;
   import game.command.rpc.pushtest.CommandPushTest;
   import game.command.rpc.quest.QuestCommandList;
   import game.command.rpc.rating.CommandRatingTopGet;
   import game.command.rpc.refillable.CommandAlchemyUse;
   import game.command.rpc.refillable.CommandSkillPointsBuy;
   import game.command.rpc.refillable.CommandStaminaBuy;
   import game.command.rpc.shop.ShopCommandList;
   import game.command.rpc.stash.CommandStashEventSend;
   import game.command.rpc.stash.StashEventAggregator;
   import game.command.rpc.stash.StashEventDescription;
   import game.command.rpc.threebox.CommandLootBoxBuy;
   import game.command.rpc.titan.TitanCommandList;
   import game.command.rpc.tutorial.CommandTutorialSaveProgress;
   import game.command.social.PlatformCommand;
   import game.command.social.PlatformCommandList;
   import game.command.timer.GameTimer;
   import game.command.tower.TowerCommandList;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.chest.ChestDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.IObtainableResource;
   import game.mechanics.boss.model.BossCommandList;
   import game.mechanics.clan_war.model.command.ClanWarCommandList;
   import game.mechanics.dungeon.model.command.DungeonCommandList;
   import game.mechanics.expedition.model.ExpeditionCommandList;
   import game.mechanics.titan_arena.model.command.TitanArenaCommandList;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.alchemy.AlchemyPopupMediator;
   import game.mediator.gui.popup.dailybonus.DailyBonusValueObject;
   import game.mediator.gui.popup.shop.soul.SoulShopUtils;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.specialoffer.PlayerSpecialOfferLootBox;
   import game.view.gui.floatingtext.FloatingTextContainer;
   import game.view.gui.tutorial.TutorialTask;
   
   public class CommandManager
   {
      
      private static const logger:Logger = Logger.getLogger(CommandManager);
       
      
      private var rpcClient:RpcClient;
      
      private var player:Player;
      
      private var _boss:BossCommandList;
      
      private var _chat:ChatCommandList;
      
      private var _clan:ClanCommandList;
      
      private var _clanWar:ClanWarCommandList;
      
      private var _dungeon:DungeonCommandList;
      
      public const expedition:ExpeditionCommandList = new ExpeditionCommandList(this);
      
      private var _friends:FriendCommandList;
      
      private var _hero:HeroCommandList;
      
      private var _initializer:RPCClientInitializerParams;
      
      private var _inventory:InventoryCommandList;
      
      private var _login:LoginCommandList;
      
      private var _mail:MailCommandList;
      
      private var _messageClient:MessageClientFacade;
      
      private var _mission:MissionCommandList;
      
      private var _quest:QuestCommandList;
      
      private var _social:PlatformCommandList;
      
      private var _shop:ShopCommandList;
      
      private var _playerCommands:PlayerCommandList;
      
      private var _titan:TitanCommandList;
      
      private var _titanArena:TitanArenaCommandList;
      
      private var _tower:TowerCommandList;
      
      public function CommandManager(param1:RPCClientInitializerParams, param2:Player)
      {
         super();
         this._initializer = param1;
         this.player = param2;
         _messageClient = new MessageClientFacade();
         rpcClient = new RpcClient(param1);
         rpcClient.signal_updateWaitingState.add(handler_rpcLock);
         rpcClient.signal_date.add(handler_date);
         _mission = new MissionCommandList(this);
         _hero = new HeroCommandList(this);
         _titan = new TitanCommandList(this);
         _inventory = new InventoryCommandList(this);
         _shop = new ShopCommandList(this);
         _social = new PlatformCommandList(this);
         _quest = new QuestCommandList(this);
         _login = new LoginCommandList(this);
         _friends = new FriendCommandList(this);
         _mail = new MailCommandList(this);
         _playerCommands = new PlayerCommandList(this);
         _chat = new ChatCommandList(this);
         _clan = new ClanCommandList(this);
         _tower = new TowerCommandList(this);
         _dungeon = new DungeonCommandList(this);
         _boss = new BossCommandList(this);
         _clanWar = new ClanWarCommandList(this);
         _titanArena = new TitanArenaCommandList(this);
      }
      
      private function handler_rpcLock() : void
      {
         if(Game.instance && Game.instance.stage)
         {
            Game.instance.stage.touchable = !rpcClient.hasBlockingRequests;
         }
      }
      
      private function handler_date(param1:Number, param2:Number) : void
      {
         GameTimer.instance.testUpdateServerTime(param1 * 1000,param2);
      }
      
      public function get boss() : BossCommandList
      {
         return _boss;
      }
      
      public function get chat() : ChatCommandList
      {
         return _chat;
      }
      
      public function get clan() : ClanCommandList
      {
         return _clan;
      }
      
      public function get clanWar() : ClanWarCommandList
      {
         return _clanWar;
      }
      
      public function get dungeon() : DungeonCommandList
      {
         return _dungeon;
      }
      
      public function get friends() : FriendCommandList
      {
         return _friends;
      }
      
      public function get hero() : HeroCommandList
      {
         return _hero;
      }
      
      public function get initializer() : RPCClientInitializerParams
      {
         return _initializer;
      }
      
      public function get inventory() : InventoryCommandList
      {
         return _inventory;
      }
      
      public function get login() : LoginCommandList
      {
         return _login;
      }
      
      public function get mail() : MailCommandList
      {
         return _mail;
      }
      
      public function get messageClient() : MessageClientFacade
      {
         return _messageClient;
      }
      
      public function get mission() : MissionCommandList
      {
         return _mission;
      }
      
      public function get quest() : QuestCommandList
      {
         return _quest;
      }
      
      public function get platform() : PlatformCommandList
      {
         return _social;
      }
      
      public function get shop() : ShopCommandList
      {
         return _shop;
      }
      
      public function get playerCommands() : PlayerCommandList
      {
         return _playerCommands;
      }
      
      public function get titan() : TitanCommandList
      {
         return _titan;
      }
      
      public function get titanArena() : TitanArenaCommandList
      {
         return _titanArena;
      }
      
      public function get tower() : TowerCommandList
      {
         return _tower;
      }
      
      public function get hasBlockingRequests() : Boolean
      {
         return rpcClient.hasBlockingRequests;
      }
      
      public function executeRPCCommand(param1:RPCCommandBase) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:CommandRequirement = param1.prerequisiteCheck(player);
         if(player.isInited)
         {
            _loc3_ = player.checkRequirement(_loc2_);
         }
         if(_loc3_ == null || _loc3_.valid)
         {
            param1.signal_error.addOnce(displayError);
            param1.onClientExecute(clientExecuteCommand);
            rpcClient.executeCommand(param1);
            if(!param1.isImmediate)
            {
               param1.dispatchClientExecute();
            }
            return true;
         }
         handleCommandPrerequisiteCheckResult(_loc3_);
         logger.error("prerequisiteCheck false",param1);
         return false;
      }
      
      private function handleCommandPrerequisiteCheckResult(param1:CommandRequirementCheckResult) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = undefined;
         var _loc6_:* = null;
         var _loc2_:* = null;
         if(param1.insufficientCost)
         {
            _loc4_ = new PopupStashEventParams();
            _loc4_.windowName = "global_not_enough";
            if(param1.insufficientCost.gold)
            {
               _loc3_ = Game.instance.navigator.navigateToRefillable(DataStorage.refillable.getByIdent("alchemy"),_loc4_) as AlchemyPopupMediator;
               FloatingTextContainer.show(Translate.translate("UI_POPUP_MESSAGE_NOTENOUGH_GOLD"),_loc3_);
               return;
            }
            if(param1.insufficientCost.starmoney)
            {
               PopupList.instance.dialog_bank(_loc4_);
               return;
            }
            _loc5_ = param1.insufficientCost.outputDisplay;
            if(_loc5_.length)
            {
               _loc6_ = _loc5_[0].item as CoinDescription;
               if(_loc6_)
               {
                  if(_loc6_ == DataStorage.coin.getByIdent("skull"))
                  {
                     PopupList.instance.message(_loc6_.obtainNavigatorType.not_enough_message,Translate.translate("UI_POPUP_MESSAGE_NOTENOUGH_SKULL"));
                     return;
                  }
                  if(_loc6_ == SoulShopUtils.shopCoin && SoulShopUtils.hasFragmentsToSell(GameModel.instance.player))
                  {
                     PopupList.instance.dialog_soulshop_sell_fragments(true,_loc4_);
                     return;
                  }
               }
               _loc2_ = _loc5_[0].item as IObtainableResource;
               if(_loc2_ && _loc2_.obtainNavigatorType)
               {
                  PopupList.instance.dialog_not_enough_resource(_loc2_.obtainNavigatorType,_loc4_);
               }
            }
         }
         else
         {
            PopupList.instance.error(param1.debugMessage);
         }
      }
      
      private function displayError(param1:RPCCommandBase) : void
      {
         var _loc2_:* = null;
         if(player.isInited)
         {
            _loc2_ = CommandErrorVerbal.getText(param1);
            PopupList.instance.error(_loc2_,"",true);
         }
      }
      
      public function executeSocialCommand(param1:PlatformCommand) : void
      {
         param1.onClientCommand.addOnce(clientExecuteSocialCommand);
         param1.execute();
      }
      
      private function clientExecuteCommand(param1:RPCCommandBase) : void
      {
         param1.clientExecute(player);
      }
      
      private function clientExecuteSocialCommand(param1:PlatformCommand) : void
      {
         param1.clientExecute(player);
      }
      
      public function billingBundleDrop() : CommandBillingBundleDrop
      {
         var _loc1_:CommandBillingBundleDrop = new CommandBillingBundleDrop();
         executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function billingGetLast() : CommandBillingGetLast
      {
         var _loc1_:CommandBillingGetLast = new CommandBillingGetLast();
         executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function billingChooseHero(param1:UnitDescription, param2:PlayerBillingDescription) : CommandBillingChooseHero
      {
         var _loc3_:CommandBillingChooseHero = new CommandBillingChooseHero(param1,param2);
         executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function bundleGetAllAvailableId() : CommandBundleGetAllAvailableId
      {
         var _loc1_:CommandBundleGetAllAvailableId = new CommandBundleGetAllAvailableId();
         executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function bundlePause() : CommandBundlePause
      {
         var _loc1_:CommandBundlePause = new CommandBundlePause();
         executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function chestBuy(param1:ChestDescription, param2:Boolean, param3:Boolean) : CommandChestBuy
      {
         var _loc4_:CommandChestBuy = new CommandChestBuy(param1,param2,param3);
         executeRPCCommand(_loc4_);
         return _loc4_;
      }
      
      public function chestBuyDevMulti(param1:int) : CommandChestBuyDevMulti
      {
         var _loc2_:CommandChestBuyDevMulti = new CommandChestBuyDevMulti(param1);
         executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function lootBoxBuy(param1:PlayerSpecialOfferLootBox, param2:int, param3:Boolean, param4:Boolean, param5:CostData) : CommandLootBoxBuy
      {
         var _loc6_:CommandLootBoxBuy = new CommandLootBoxBuy(param1,param2,param3,param4,param5);
         executeRPCCommand(_loc6_);
         return _loc6_;
      }
      
      public function tutorialSaveProgress(param1:Vector.<TutorialTask>) : CommandTutorialSaveProgress
      {
         var _loc2_:CommandTutorialSaveProgress = new CommandTutorialSaveProgress(param1);
         executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function dailyBonusFarm(param1:int, param2:DailyBonusValueObject) : CommandDailyBonusFarm
      {
         var _loc3_:CommandDailyBonusFarm = new CommandDailyBonusFarm(param1,param2);
         executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function refillableStaminaBuy() : CommandStaminaBuy
      {
         var _loc1_:CommandStaminaBuy = new CommandStaminaBuy();
         executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function refillableSkillPointsBuy() : CommandSkillPointsBuy
      {
         var _loc1_:CommandSkillPointsBuy = new CommandSkillPointsBuy();
         executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function refillableGoldBuy(param1:Boolean) : CommandAlchemyUse
      {
         var _loc2_:CommandAlchemyUse = new CommandAlchemyUse(param1);
         executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function refillableArenaBattlesBuy() : CommandArenaBuyBattles
      {
         var _loc1_:CommandArenaBuyBattles = new CommandArenaBuyBattles();
         executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function refillableGrandBattlesBuy() : CommandGrandBuyBattles
      {
         var _loc1_:CommandGrandBuyBattles = new CommandGrandBuyBattles();
         executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function refillableGrandSkipCooldown() : CommandGrandSkipCooldown
      {
         var _loc1_:CommandGrandSkipCooldown = new CommandGrandSkipCooldown();
         executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function ratingTopGet(param1:String) : CommandRatingTopGet
      {
         var _loc2_:CommandRatingTopGet = new CommandRatingTopGet(param1);
         executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function pushTest() : void
      {
         var _loc1_:CommandPushTest = new CommandPushTest();
         executeRPCCommand(_loc1_);
      }
      
      public function pushBillingTest(param1:PlayerBillingDescription) : void
      {
         var _loc2_:CommandPushBillingTest = new CommandPushBillingTest(param1);
         executeRPCCommand(_loc2_);
      }
      
      public function pirateTreasure_farm() : CommandPirateTreasureFarm
      {
         var _loc1_:CommandPirateTreasureFarm = new CommandPirateTreasureFarm();
         executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function createMessageClient(param1:Boolean) : void
      {
         _messageClient.create(param1);
      }
      
      public function initMessageClient(param1:Player, param2:Object = null) : void
      {
         _messageClient.initialize(param1,param2);
      }
      
      public function stashEvent(param1:StashEventDescription) : void
      {
         param1.addTimestamp(GameTimer.instance.currentServerTime);
         StashEventAggregator.add(param1);
      }
      
      public function stashEvent_flush() : void
      {
         var _loc2_:* = null;
         var _loc1_:Vector.<StashEventDescription> = StashEventAggregator.flush();
         if(_loc1_.length)
         {
            _loc2_ = new CommandStashEventSend(_loc1_);
            executeRPCCommand(_loc2_);
         }
      }
   }
}

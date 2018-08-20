package game.model
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.common.util.ExternalInterfaceProxy;
   import engine.context.GameContext;
   import engine.context.platform.social.GMRSocialFacadeHelper;
   import game.assets.storage.AssetStorage;
   import game.command.CommandManager;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.login.CommandMobileClientInit;
   import game.command.rpc.merge.CommandUserMergeGetMergeData;
   import game.command.rpc.merge.CommandUserMergeGetStatus;
   import game.command.rpc.player.server.ServerListUserValueObject;
   import game.command.timer.GameTimer;
   import game.data.locale.LocaleStorage;
   import game.data.storage.DataStorage;
   import game.model.user.NextDayUpdatedManager;
   import game.model.user.Player;
   import game.model.user.social.GMRUserAgreementCheck;
   import game.stat.VKPixel;
   import game.util.logging.SpeedHackCheckManager;
   
   public class GameModel
   {
      
      private static var _instance:GameModel;
       
      
      public const player:Player = new Player();
      
      public var context:GameContext;
      
      public var actionManager:CommandManager;
      
      public function GameModel()
      {
         super();
      }
      
      public static function get instance() : GameModel
      {
         if(!_instance)
         {
            _instance = new GameModel();
         }
         return _instance;
      }
      
      public function init() : void
      {
         new LocaleStorage(context.localeStaticData,context.localeID);
         actionManager = new CommandManager(new GameRPCInitParams(context),player);
         var _loc1_:CommandUserMergeGetStatus = new CommandUserMergeGetStatus();
         _loc1_.signal_complete.add(rpcGetMergeStatus);
         _loc1_.signal_error.add(rpcGetMergeStatusError);
         actionManager.executeRPCCommand(_loc1_);
      }
      
      private function rpcGetMergeStatusError(param1:RPCCommandBase) : void
      {
         if(param1.error.name == "ServerOffline")
         {
            context.initSuccessSignal.dispatch();
            context.blockMessageSignal.dispatch(Translate.translate("UI_COMMON_SERVER_OFFLINE"));
         }
         else
         {
            context.initErrorSignal.dispatch(param1.error.message);
         }
      }
      
      private function rpcGetMergeStatus(param1:CommandUserMergeGetStatus) : void
      {
         var _loc5_:* = null;
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc2_:Object = param1.result.data;
         if(_loc2_ && _loc2_.body)
         {
            _loc4_ = _loc2_.body.needMerge;
            _loc3_ = _loc2_.body.processingMerge;
            GameTimer.instance.initServerTime(_loc2_["getTime"],0,0);
            player.specialOffer.mergebonusEndTime = _loc2_.body.bonusEndTime;
         }
         if(!_loc4_)
         {
            rpcInit();
         }
         else
         {
            initLib();
            if(!_loc3_)
            {
               _loc5_ = new CommandUserMergeGetMergeData();
               _loc5_.signal_complete.add(rpcGetMergeInfo);
               _loc5_.signal_error.add(rpcInitError);
               actionManager.executeRPCCommand(_loc5_);
            }
            else
            {
               context.initSuccessSignal.dispatch();
               context.blockMessageSignal.dispatch(Translate.translate("UI_DIALOG_MERGE_PROCESSING"));
            }
         }
      }
      
      private function rpcInit() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(GameModel.instance.context.platformFacade.isMobile)
         {
            _loc2_ = actionManager.login.commandMobileInit();
            _loc2_.onComplete.add(rpcInitCompleteMobile);
            _loc2_.onError.add(rpcInitErrorMobile);
         }
         else
         {
            _loc1_ = actionManager.login.commandSocialInit(context);
            _loc1_.signal_complete.add(rpcInitComplete);
            _loc1_.signal_error.add(rpcInitError);
         }
      }
      
      private function rpcGetMergeInfo(param1:CommandUserMergeGetMergeData) : void
      {
         var _loc5_:* = null;
         var _loc4_:Array = [];
         var _loc3_:Object = param1.result.body;
         var _loc7_:int = 0;
         var _loc6_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            _loc5_ = new ServerListUserValueObject(_loc2_);
            _loc4_.push(_loc5_);
         }
         context.initSuccessSignal.dispatch();
         context.selectAccountSignal.dispatch(_loc4_);
      }
      
      private function _onLoginComplete(param1:Object) : void
      {
         var _loc2_:Number = param1["userGetInfo"].nextDayTs;
         GameTimer.instance.initServerTime(param1["getTime"],_loc2_,param1["userGetInfo"].timeZone);
         player.init(param1["userGetInfo"]);
         (actionManager.initializer as GameRPCInitParams).writePlayerId(player.id);
         if(ExternalInterfaceProxy.available)
         {
            ExternalInterfaceProxy.call("window.feedback.setGameInternalId",player.id);
         }
         GMRSocialFacadeHelper.playerId = player.id;
         player.avatarData.updateAvailableAvatars(param1["userGetAvailableAvatars"]);
         player.inventory.init(param1["inventoryGet"]);
         player.heroes.init(param1["heroGetAll"],param1["teamGetAll"]);
         player.titans.init(param1["titanGetAll"],param1["titanSpiritGetAll"]);
         player.missions.init(param1["missionGetAll"],player);
         player.dailyBonus.init(param1["dailyBonusGetInfo"]);
         player.billingData.initialize(param1["billingGetAll"],GameModel.instance.context.platformFacade);
         player.billingData.initializeLastBilling(param1["billingGetLast"]);
         player.questData.init(param1["questGetAll"]);
         player.questData.initEvents(param1["questGetEvents"]);
         player.arena.init(param1["arenaGetAll"]);
         player.grand.init(param1["arenaGetAll"]);
         player.chat.init(param1["chatGetAll"],param1["chatGetInfo"]);
         player.friends.init(param1["friendsGetInfo"]);
         player.mail.init(param1["mailGetAll"]);
         player.heroes.initWatcher(player);
         player.titans.initWatcher(player);
         player.clan.init(param1["clanGetInfo"],param1["userGetInfo"],param1["clanWarGetWarlordInfo"],param1["clanWarGetBriefInfo"]);
         player.socialQuestData.init(param1["socialQuestGetInfo"],player);
         player.settings.init(param1["settingsGetAll"]);
         player.subscription.init(param1["subscriptionGetInfo"],param1["zeppelinGiftGet"]);
         player.tutorial.init(param1["tutorialGetInfo"]);
         player.specialOffer.init(param1["offerGetAll"]);
         player.specialShop.init(param1["heroesMerchantGet"]);
         player.freeGiftData.init(param1["freebieHaveGroup"]);
         player.easterEggs.initialize(param1["pirateTreasureIsAvailable"]);
         player.artifactChest.initialize(param1["artifactGetChestLevel"]);
         player.titanArtifactChest.initialize(param1["titanArtifactGetChest"]);
         player.titanSummoningCircle.initialize(param1["titanGetSummoningCircle"]);
         player.expedition.init(param1["expeditionGet"]);
         player.ny.init(param1["newYearGetInfo"]);
         player.titanArenaData.initTrophies(param1["hallOfFameGetTrophies"]);
         player.titanArenaData.updateChestRewardStatus(param1["titanArenaGetChestReward"]);
         player.boss.init(param1["bossGetAll"]);
         player.signal_update.initSignal.dispatch();
         context.initSuccessSignal.dispatch();
         new NextDayUpdatedManager();
         if(context.platformFacade.network == "vkontakte")
         {
            try
            {
               VKPixel.init(player);
            }
            catch(error:Error)
            {
            }
            "registration";
            if(param1.body.isNewUser)
            {
               try
               {
                  VKPixel.send("registration");
               }
               catch(error:Error)
               {
               }
            }
         }
         if(context.platformFacade.network == "gamesmailru")
         {
            new GMRUserAgreementCheck(player);
         }
      }
      
      private function rpcInitCompleteMobile(param1:CommandMobileClientInit) : void
      {
         initLib();
         actionManager.createMessageClient(true);
         _onLoginComplete(param1.result.data);
         actionManager.initMessageClient(player,param1.result.data["getPushdCredentials"]);
      }
      
      private function rpcInitComplete(param1:RPCCommandBase) : void
      {
         SplitResolver.applySplitData(context.libStaticData,param1);
         MissionReplaceResolver.applyMissionReplace(context.libStaticData,param1);
         initLib();
         actionManager.createMessageClient(false);
         _onLoginComplete(param1.result.data);
         actionManager.initMessageClient(player,null);
      }
      
      private function initLib() : void
      {
         new DataStorage(context.libStaticData);
         DataStorage.applyLocale();
         GMRSocialFacadeHelper.oneTimeBillings = DataStorage.rule.oneTimeBillings;
         if(!AssetStorage.instance.inited)
         {
            AssetStorage.instance.init(GameContext.instance.assetIndex);
         }
      }
      
      private function rpcInitErrorMobile(param1:CommandMobileClientInit) : void
      {
      }
      
      private function rpcInitError(param1:RPCCommandBase) : void
      {
         context.initErrorSignal.dispatch(param1.error.message);
      }
   }
}

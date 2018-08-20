package game.util
{
   import battle.BattleLog;
   import battle.utils.Version;
   import com.progrestar.common.Logger;
   import com.progrestar.common.lang.Translate;
   import engine.context.GameContext;
   import engine.context.platform.PlatformUser;
   import engine.debug.ClickLoger;
   import engine.loader.ClientVersion;
   import feathers.core.PopUpManager;
   import flash.desktop.Clipboard;
   import flash.display.Sprite;
   import flash.external.ExternalInterface;
   import flash.system.ApplicationDomain;
   import flash.system.System;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import game.assets.storage.AssetDisposingWatcher;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.BattleAssetStorage;
   import game.battle.BattleLogEncoder;
   import game.battle.controller.BattleController;
   import game.battle.controller.MultiBattleResult;
   import game.battle.controller.entities.BattleHero;
   import game.battle.controller.statistic.BattleDamageStatistics;
   import game.battle.controller.thread.ArenaBattleThread;
   import game.battle.gui.BattleGuiMediator;
   import game.battle.prefab.PairOfDeersPresentationBattle;
   import game.command.rpc.CommandResult;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.arena.BattleResultValueObjectFactory;
   import game.command.rpc.arena.CommandArenaSetHeroes;
   import game.command.rpc.chest.CommandChestBuyDevMulti;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.command.rpc.merge.CommandTestAddUserToUserMerge;
   import game.command.rpc.mission.CommandBattleStartReplay;
   import game.command.rpc.mission.CommandMissionStart;
   import game.command.rpc.mission.MissionBattleResultValueObject;
   import game.command.rpc.player.CommandOfferGetAll;
   import game.command.rpc.player.CommandUserResetDay;
   import game.command.timer.GameTimer;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.HeroStarEvolutionData;
   import game.data.storage.level.PlayerTeamLevel;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.notification.NotificationDescription;
   import game.data.storage.pve.mission.MissionDescription;
   import game.data.storage.skills.SkillDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mechanics.clan_war.mediator.ActiveClanWarMembersPopupMediator;
   import game.mechanics.clan_war.mediator.ClanWarAssignChampionsPopupMediator;
   import game.mechanics.clan_war.mediator.ClanWarLeaguesAndRewardsPopupMediator;
   import game.mechanics.clan_war.mediator.ClanWarLeaguesPopupMediator;
   import game.mechanics.clan_war.mediator.ClanWarStartScreenMediator;
   import game.mechanics.expedition.mediator.ExpeditionListPopupMediator;
   import game.mechanics.grand.mediator.GrandPopupMediator;
   import game.mechanics.titan_arena.mediator.TitanArenaPopupMediator;
   import game.mechanics.titan_arena.mediator.chest.TitanArtifactChestPopupMediator;
   import game.mechanics.titan_arena.mediator.halloffame.TitanArenaHallOfFamePopupMediator;
   import game.mechanics.titan_arena.mediator.rating.TitanArenaRatingPopupMediator;
   import game.mechanics.titan_arena.mediator.reward.TitanArenaPointsRewardPopupMediator;
   import game.mechanics.titan_arena.mediator.reward.TitanArenaRewardPopupMediator;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.HeroRewardPopupHandler;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.arena.ArenaPopupMediator;
   import game.mediator.gui.popup.billing.bundle.BundleSkillValueObject;
   import game.mediator.gui.popup.billing.bundle.RaidPromoPopupMediator;
   import game.mediator.gui.popup.billing.vip.VipLevelUpPopupMediator;
   import game.mediator.gui.popup.chat.ProcessingURLTextMediator;
   import game.mediator.gui.popup.clan.ClanEditIconPopupMediator;
   import game.mediator.gui.popup.clan.ClanInfoPopupMediator;
   import game.mediator.gui.popup.clan.ClanItemForActivityPopupMediator;
   import game.mediator.gui.popup.clan.ClanSearchPopupMediator;
   import game.mediator.gui.popup.clan.activitystats.ClanActivityStatsPopupMediator;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.mediator.gui.popup.hero.skill.SkillTooltipMessageFactory;
   import game.mediator.gui.popup.mail.PlayerMailImportantPopupMediator;
   import game.mediator.gui.popup.mission.MissionDefeatPopupMediator;
   import game.mediator.gui.popup.mission.MissionRewardPopupMediator;
   import game.mediator.gui.popup.settings.SettingsPopupMediator;
   import game.mediator.gui.popup.social.CommunityPromoPopupMediator;
   import game.mediator.gui.popup.team.TeamGatherByActivityPopupMediator;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.mediator.gui.popup.titan.TitanArtifactListPopupMediator;
   import game.mediator.gui.popup.titan.TitanListPopupMediator;
   import game.mediator.gui.popup.titan.upgrade.TitanStarUpPopup;
   import game.mediator.gui.popup.titanarena.TitanArenaRulesPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.clan.ClanMemberValueObject;
   import game.model.user.friends.PlayerFriendEntry;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.HeroEntrySourceData;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerHeroEntrySourceData;
   import game.model.user.hero.TitanEntry;
   import game.model.user.hero.TitanEntrySourceData;
   import game.model.user.mail.PlayerMailEntry;
   import game.model.user.quest.PlayerQuestEntry;
   import game.model.user.shop.SpecialShopMerchant;
   import game.model.user.specialoffer.PlayerSpecialOfferEntry;
   import game.model.user.specialoffer.PlayerSpecialOfferWithTimer;
   import game.util.screencap.ScreenCaptureTest;
   import game.view.gui.clanscreen.heroes.ClanScreenHeroes;
   import game.view.gui.overlay.offer.SpecialOfferSideBar;
   import game.view.popup.hero.upgrade.HeroColorUpPopup;
   import game.view.popup.hero.upgrade.HeroStarUpPopup;
   import game.view.popup.mail.PlayerMailMultifarmPopup;
   import game.view.popup.odnoklassniki.OdnoklassnikiEventPopup;
   import game.view.popup.reward.RewardHeroPopup;
   import game.view.popup.reward.RewardSpiritPopup;
   import game.view.popup.shop.special.SpecialShopPopupMediator;
   import game.view.popup.shop.special.SpecialShopWelcomePopup;
   import game.view.popup.test.BattleTestStatsPopupMediator;
   import game.view.popup.test.BattleTestVerificationPopupMediator;
   import game.view.popup.test.battlelist.BattleTestListPopupMediator;
   import game.view.popup.test.grade.BattleTestGradeModel;
   import game.view.specialoffer.welcomeback.SpecialOfferWelcomeBackBonusesPopupMediator;
   import org.osflash.signals.Signal;
   import starling.core.Starling;
   import starling.textures.TextureMemoryManager;
   
   public class ConsoleCommands
   {
      
      public static const signal_trigger:Signal = new Signal();
       
      
      public function ConsoleCommands()
      {
         super();
         var _loc1_:int = 1;
      }
      
      [Console(text="Соглашение GMR")]
      public function gmr_testAgreement() : void
      {
         ExternalInterface.call("window.GMRExternalApi.userConfirm");
         ExternalInterface.addCallback("userConfirmCallback",gmr_callback);
      }
      
      private function gmr_callback(param1:Object) : void
      {
      }
      
      [Console(text="Задать максимальный уровень юнитов в testBalance")]
      public function overrideTestBalanceMaxLevel(param1:int) : String
      {
         BattleTestGradeModel.MAX_LEVEL = param1;
         return "Для testBalance установлен максимальный уровень " + param1 + ".";
      }
      
      [Console(text="Вывод информации об ассетах, которые не удалось выгрузить")]
      public function reportAssetDisposing() : void
      {
         disposeUnusedAssets();
         gc();
         gc();
         printGcFailedAssets();
      }
      
      [Console(text="Вывести список rsx ассетов, которые не выгрузились после dispose()")]
      public function printGcFailedAssets() : void
      {
      }
      
      [Console(text="Вывести список rsx ассетов, которые могут быть выгружены, если не используются в данный момент")]
      public function printAssetsAllowedToBeDisposed() : void
      {
      }
      
      [Console(text="Принудительная выгрузка всех неиспользуемых героев")]
      public function dropHeroesAssets() : void
      {
         TextureMemoryManager.signal_memoryAlarm.dispatch();
      }
      
      [Console(text="Принудительная выгрузка всех неиспользуемых ассетов")]
      public function disposeUnusedAssets() : void
      {
         AssetDisposingWatcher.DEBUG_ASSET_DISPOSING = true;
         AssetStorage.rsx.disposeUnusedAssets();
      }
      
      [Console(text="Окно получения духа")]
      public function testDialog_rewardSpirit(param1:int) : void
      {
         var _loc2_:TitanArtifactDescription = DataStorage.titanArtifact.getArtifactById(param1);
         PopUpManager.addPopUp(new RewardSpiritPopup(_loc2_));
      }
      
      [Console(text="победить всех на арене титанов")]
      public function titanArena_testGetNextTier() : void
      {
         GameModel.instance.actionManager.titanArena.testGetNextTier();
      }
      
      [Console(text="Открыть Алтарь Стихий")]
      public function openTitanArtifactChest() : void
      {
         new TitanArtifactChestPopupMediator(GameModel.instance.player).open(null);
      }
      
      [Console(text="Открыть окно наград за очки Турнира Стихий")]
      public function openTitanArenaPointsRewardPopup() : void
      {
         new TitanArenaPointsRewardPopupMediator(GameModel.instance.player).open(null);
      }
      
      [Console(text="Скрыть боковую панель с акциями")]
      public function hideSideBar() : void
      {
         SpecialOfferSideBar.HIDDEN.toggle();
      }
      
      [Console(text="Вызывать что-нибудь где-нибудь")]
      public function trigger() : void
      {
         signal_trigger.dispatch();
      }
      
      [Console(text="testMailUpdate")]
      public function testMailUpdate() : void
      {
         GameModel.instance.player.mail.action_addUnknownMessage();
      }
      
      [Console(text="Арена Титанов")]
      public function testDialog_titanArena() : void
      {
         new TitanArenaPopupMediator(GameModel.instance.player).open(null);
      }
      
      [Console(text="Награда на Арене Титанов")]
      public function testDialog_titanArenaReward() : void
      {
         new TitanArenaRewardPopupMediator(GameModel.instance.player).open(null);
      }
      
      [Console(text="Рейтинг Арены Титанов")]
      public function testDialog_titanArenaRating() : void
      {
         new TitanArenaRatingPopupMediator(GameModel.instance.player).open(null);
      }
      
      [Console(text="Зал славы Арены Титанов")]
      public function testDialog_titanArenaHallOfFrame() : void
      {
         new TitanArenaHallOfFamePopupMediator(GameModel.instance.player).open(null);
      }
      
      [Console(text="Отобразить окно правил Арены Титанов")]
      public function titanArenaRules() : void
      {
         new TitanArenaRulesPopupMediator(GameModel.instance.player).open(null);
      }
      
      [Console(text="Отобразить окно списка титанов с артефактами")]
      public function openDialogTitanArtifactList() : void
      {
         new TitanArtifactListPopupMediator(GameModel.instance.player).open(null);
      }
      
      [Console(text="testDialog_quizStart")]
      public function testDialog_quizStart() : void
      {
         GameModel.instance.player.quizData.action_quizNavigateTo(null);
      }
      
      [Console(text="CommunityPromoPopupMediator")]
      public function testDialog_communityPromoPopupMediator() : void
      {
         var _loc1_:CommunityPromoPopupMediator = new CommunityPromoPopupMediator(GameModel.instance.player);
         _loc1_.open();
      }
      
      [Console(text="Сневалидировать следующий бой или реплей на арене. Значения опционального параметра: 1 - несвалидировалось, потому что новая версия")]
      public function invalidateNextArenaBattle(param1:int = 0) : String
      {
         ArenaBattleThread.INVALIDATE_NEXT_BATTLE_TYPE = param1;
         var _loc2_:String = "\n0 - свалидируется как обычно\n1 - не свалидируется как реплей с новой версии\n2 - не свалидируется как реплей со старой версии\n3 - не свалидируется как ошибка валидации\n";
         var _loc3_:* = param1;
         if(ArenaBattleThread.INVALIDATE_NEXT_BATTLE_TYPE_NO !== _loc3_)
         {
            if(ArenaBattleThread.INVALIDATE_NEXT_BATTLE_TYPE_HIGH !== _loc3_)
            {
               if(ArenaBattleThread.INVALIDATE_NEXT_BATTLE_TYPE_LOW !== _loc3_)
               {
                  if(ArenaBattleThread.INVALIDATE_NEXT_BATTLE_TYPE_SAME !== _loc3_)
                  {
                     return _loc2_;
                  }
                  return "Следующий бой на арене не свалидируется как ошибка валидации" + _loc2_;
               }
               return "Следующий бой на арене не свалидируется как реплей со старой версии игры" + _loc2_;
            }
            return "Следующий бой на арене не свалидируется как реплей с новой версии игры" + _loc2_;
         }
         return "Следующий бой на арене свалидируется как обычно" + _loc2_;
      }
      
      [Console(text="Демо бой с оленями")]
      public function testBattleScenario() : void
      {
         new PairOfDeersPresentationBattle().start();
      }
      
      [Console(text="Проверка мат-фильтра")]
      public function foulLanguageFilter_test() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Array = ["hey gtg ttyl"];
         var _loc2_:int = _loc1_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            trace(_loc1_[_loc3_]," === ",FoulLanguageFilter.checkBadWordsAndCorrect(_loc1_[_loc3_]));
            _loc3_++;
         }
      }
      
      [Console(text="Карта с экспедициями")]
      public function testDialog_expeditionList() : void
      {
         var _loc1_:ExpeditionListPopupMediator = new ExpeditionListPopupMediator(GameModel.instance.player);
         _loc1_.open(null);
      }
      
      [Console(text="Список героев с артевактами")]
      public function testDialog_heroArtifactList() : void
      {
         PopupList.instance.dialog_hero_artifact_list(null);
      }
      
      [Console(text="отображение окна артефактов конкретного героя")]
      public function showHeroArtifacts(param1:int) : void
      {
         PopupList.instance.dialog_artifacts(DataStorage.hero.getHeroById(param1),null,null);
      }
      
      [Console(text="отображение окна статистики активности гильдии")]
      public function showClanActivityStats() : void
      {
         var _loc1_:ClanActivityStatsPopupMediator = new ClanActivityStatsPopupMediator(GameModel.instance.player);
         _loc1_.open(null);
      }
      
      [Console(text="отображение окна лиг и наград")]
      public function showClanWarLeaguesAndRewards() : void
      {
         var _loc1_:ClanWarLeaguesAndRewardsPopupMediator = new ClanWarLeaguesAndRewardsPopupMediator(GameModel.instance.player);
         _loc1_.open(null);
      }
      
      [Console(text="отображение рейтинга по лигам")]
      public function showClanWarLeaguesRaiting() : void
      {
         var _loc1_:ClanWarLeaguesPopupMediator = new ClanWarLeaguesPopupMediator(GameModel.instance.player);
         _loc1_.open(null);
      }
      
      [Console(text="clanWarSetWarriors")]
      public function clanWarSetWarriors() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Array = [];
         var _loc5_:Vector.<ClanMemberValueObject> = GameModel.instance.player.clan.clan.members;
         var _loc1_:int = _loc5_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_.push(_loc5_[_loc3_].id);
            _loc3_++;
         }
         var _loc2_:Array = [];
         GameModel.instance.actionManager.clanWar.clanWarEnableWarrior(_loc4_,_loc2_);
      }
      
      [Console(text="clanWarStart")]
      public function clanWarStart() : void
      {
         GameModel.instance.actionManager.clanWar.clanWarTestStart();
      }
      
      [Console(text="clanWar")]
      public function clanWar() : void
      {
         var _loc1_:ClanWarStartScreenMediator = new ClanWarStartScreenMediator(GameModel.instance.player);
         _loc1_.open();
      }
      
      [Console(text="отображение окна участников гильдии в клановой войне (до старта)")]
      public function showClanWarMembers() : void
      {
         var _loc1_:ClanWarAssignChampionsPopupMediator = new ClanWarAssignChampionsPopupMediator(GameModel.instance.player);
         _loc1_.open(null);
      }
      
      [Console(text="отображение окна участников гильдии в клановой войне (после старта)")]
      public function showActiveClanWarMembers() : void
      {
         var _loc1_:ActiveClanWarMembersPopupMediator = new ActiveClanWarMembersPopupMediator(GameModel.instance.player);
         _loc1_.open(null);
      }
      
      [Console(text="browserZoomFactor")]
      public function browserZoomFactor() : void
      {
      }
      
      [Console(text="printTextures")]
      public function printTextures() : String
      {
         TextureMemoryManager.print();
         return "GPU mem occupided: approximately " + TextureMemoryManager.memoryOccupiedMb.toFixed(2) + " mb";
      }
      
      [Console(text="resetClanHeroes")]
      public function resetClanHeroes() : void
      {
         ClanScreenHeroes.lastDebugInstance.restart(GameModel.instance.player);
      }
      
      [Console(text="up")]
      public function up() : void
      {
         Game.instance.screen.getMainScreen().toClanScreen();
      }
      
      [Console(text="down")]
      public function down() : void
      {
         Game.instance.screen.getMainScreen().toHomeScreen();
      }
      
      [Console(text="simulate_error")]
      public function simulate_error() : void
      {
         GameModel.instance.player.inventory.addItem(null,1);
      }
      
      [Console(text="record_replayArena")]
      public function record_replayArena(param1:String = "1484235600967362131") : void
      {
         id = param1;
         var s:Sprite = Starling.current.nativeStage.getChildAt(0) as Sprite;
         var screenCaptureTest:ScreenCaptureTest = new ScreenCaptureTest(0,s,GameContext.instance.assetIndex.getRootURL() + "assets/");
         ProcessingURLTextMediator.signal_replayStart.add(function():void
         {
            screenCaptureTest.start();
         });
         ProcessingURLTextMediator.signal_replayComplete.add(function():void
         {
            screenCaptureTest.stop();
         });
         ProcessingURLTextMediator.replay(id);
      }
      
      [Console(text="record_screenCaptureTest")]
      public function record_screenCaptureTest(param1:int = 100) : void
      {
         var _loc2_:Sprite = Starling.current.nativeStage.getChildAt(0) as Sprite;
      }
      
      [Console(text="Промотать клиентское время вперёд или назад на заданное кол-во секунд")]
      public function adjustTime(param1:int) : void
      {
         var _loc2_:int = GameTimer.artificialOffset;
         GameTimer.artificialOffset = GameTimer.artificialOffset + param1;
         GameTimer.instance.adjustServerTime((GameTimer.instance.currentServerTime - _loc2_) * 1000,0);
      }
      
      [Console(text="dropContext")]
      public function dropContext() : void
      {
         Starling.context.dispose();
      }
      
      [Console(text="gc")]
      public function gc() : void
      {
         System.gc();
      }
      
      [Console(text="printHeroWatchListenersCount")]
      public function printHeroWatchListenersCount() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = DataStorage.hero.getPlayableHeroes();
         for each(var _loc1_ in DataStorage.hero.getPlayableHeroes())
         {
            GameModel.instance.player.heroes.watcher.getHeroWatch(_loc1_).print();
         }
      }
      
      [Console(text="checkMissingSymbols")]
      public function checkMissingSymbols() : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Dictionary = new Dictionary();
         var _loc9_:int = 0;
         var _loc8_:* = Translate.dictionary;
         for(var _loc7_ in Translate.dictionary)
         {
            _loc3_ = Translate.dictionary[_loc7_];
            _loc2_ = _loc3_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc4_ = _loc3_.charCodeAt(_loc6_);
               if(!AssetStorage.font.Officina14.hasChars(_loc3_.charAt(_loc6_)))
               {
                  _loc5_[_loc3_.charAt(_loc6_)] = 1;
               }
               _loc6_++;
            }
         }
         var _loc1_:String = "";
         var _loc11_:int = 0;
         var _loc10_:* = _loc5_;
         for(_loc7_ in _loc5_)
         {
            _loc1_ = _loc1_ + _loc7_;
         }
      }
      
      [Console(text="Открыть х10 сундуков n раз")]
      public function townChest_openMulti(param1:int, param2:int = 10) : void
      {
         amount = param1;
         step = param2;
         var _exec:Function = function():void
         {
            var _loc1_:CommandChestBuyDevMulti = GameModel.instance.actionManager.chestBuyDevMulti(step);
            _loc1_.onClientExecute(_f);
         };
         var cost:int = 1500;
         HeroRewardPopupHandler.instance.hold();
         var dict:Dictionary = new Dictionary();
         var list:Vector.<HeroDescription> = DataStorage.hero.getHeroList();
         var heroListLength:int = list.length;
         var iteration:int = 0;
         var _f:Function = function(param1:RPCCommandBase):void
         {
            var _loc6_:int = 0;
            var _loc7_:* = null;
            var _loc11_:int = 0;
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:Boolean = false;
            var _loc10_:int = 0;
            var _loc2_:* = null;
            var _loc12_:* = 0;
            var _loc8_:int = 0;
            _loc6_ = 0;
            while(_loc6_ < heroListLength)
            {
               _loc7_ = list[_loc6_];
               if(!dict[_loc7_.id])
               {
                  dict[_loc7_.id] = [];
               }
               _loc11_ = 0;
               _loc11_ = _loc11_ + GameModel.instance.player.inventory.getFragmentCount(list[_loc6_]);
               _loc3_ = GameModel.instance.player.heroes.getById(list[_loc6_].id);
               if(_loc3_)
               {
                  _loc11_ = _loc11_ + _loc7_.startingStar.star.summonFragmentCost;
                  _loc4_ = _loc7_.startingStar;
                  while(_loc4_.next && _loc3_.star.star.id >= _loc4_.next.star.id)
                  {
                     _loc11_ = _loc11_ + _loc4_.star.evolveFragmentCost;
                     _loc4_ = _loc4_.next;
                  }
               }
               dict[_loc7_.id][iteration] = _loc11_;
               _loc6_++;
            }
            iteration = Number(iteration) + 1;
            if(iteration < amount)
            {
               _exec();
            }
            else
            {
               _loc5_ = false;
               var _loc14_:int = 0;
               var _loc13_:* = dict;
               for(var _loc9_ in dict)
               {
                  if(!_loc5_)
                  {
                     _loc10_ = dict[_loc9_].length;
                     _loc2_ = [];
                     _loc12_ = _loc10_;
                     _loc8_ = 0;
                     while(_loc8_ < _loc12_)
                     {
                        _loc2_.push(cost * step * (_loc8_ + 1));
                        _loc8_++;
                     }
                     trace("name","\t","id","\t",_loc2_.join("\t"));
                     _loc5_ = true;
                  }
                  trace(DataStorage.hero.getUnitById(_loc9_).name,"\t",_loc9_,"\t",dict[_loc9_].join("\t"));
               }
            }
         };
      }
      
      [Console(text="Переключение между быстрой и интерпретируемой боёвкой")]
      public function toggleInterpreter() : String
      {
         BattleAssetStorage.USE_INTERPRETER = !BattleAssetStorage.USE_INTERPRETER;
         return !!BattleAssetStorage.USE_INTERPRETER?"Используется интерпретатор. (медленно, как на бою)":"Используется код в swf, быстро";
      }
      
      [Console(text="окно героя")]
      public function testDialog_hero(param1:int) : void
      {
         var _loc2_:HeroDescription = DataStorage.hero.getHeroById(param1);
         var _loc3_:RewardHeroPopup = new RewardHeroPopup(_loc2_,0);
         _loc3_.open();
         PopupList.instance.dialog_hero(_loc2_);
      }
      
      [Console(text="")]
      public function test_heroQuestAdvice() : void
      {
         var _loc3_:Player = GameModel.instance.player;
         var _loc1_:Vector.<PlayerQuestEntry> = _loc3_.questData.getDailyList();
         var _loc2_:Vector.<PlayerQuestEntry> = new Vector.<PlayerQuestEntry>();
      }
      
      [Console(text="Окно о важном апдейте")]
      public function testDialog_importantUpdate() : void
      {
         var _loc3_:Object = {
            "id":"14056",
            "read":"0",
            "reward":[],
            "message":"500 get",
            "type":"massImportant",
            "params":{"imgName":"500k.jpg"},
            "senderId":"-3",
            "ctime":"1474019217"
         };
         var _loc1_:PlayerMailEntry = new PlayerMailEntry(_loc3_);
         var _loc2_:PlayerMailImportantPopupMediator = new PlayerMailImportantPopupMediator(GameModel.instance.player,_loc1_);
         _loc2_.open();
      }
      
      [Console(text="Окно промо випа / рейдов")]
      public function testDialog_raid_promo() : void
      {
         var _loc1_:RaidPromoPopupMediator = new RaidPromoPopupMediator(GameModel.instance.player);
         _loc1_.open();
      }
      
      [Console(text="Окно приветствия торговца редкостями")]
      public function testDialog_specialShopWelcome() : void
      {
         var _loc1_:SpecialShopWelcomePopup = new SpecialShopWelcomePopup(null);
         _loc1_.open();
      }
      
      [Console(text="Окно бонуса при покупке ОКов в одноклассниках")]
      public function testDialog_odnoklassnikiOffer() : void
      {
         var _loc1_:OdnoklassnikiEventPopup = new OdnoklassnikiEventPopup(null);
         _loc1_.open();
      }
      
      [Console(text="Окно редактирования логотипа клана")]
      public function testDialog_clanEditIcon() : void
      {
         var _loc1_:ClanEditIconPopupMediator = new ClanEditIconPopupMediator(GameModel.instance.player,new ClanIconValueObject());
         _loc1_.open();
      }
      
      [Console(text="Текст-описание героя")]
      public function testTrace_heroDesc(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc11_:* = null;
         var _loc17_:* = null;
         var _loc16_:* = null;
         var _loc7_:* = null;
         var _loc13_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:HeroDescription = DataStorage.hero.getHeroById(param1);
         var _loc2_:String = "";
         _loc2_ = _loc2_ + _loc4_.name;
         _loc2_ = _loc2_ + "\n";
         _loc2_ = _loc2_ + "\n";
         var _loc14_:String = Translate.translate("LIB_BATTLESTATDATA_" + _loc4_.mainStat.name.toUpperCase());
         _loc2_ = _loc2_ + Translate.translateArgs("UI_DIALOG_HERO_MAIN_STAT",_loc14_);
         _loc2_ = _loc2_ + "\n";
         _loc2_ = _loc2_ + "\n";
         var _loc9_:Vector.<String> = _loc4_.role.localizedExtendedRoleList;
         if(_loc9_.length == 1)
         {
            _loc3_ = Translate.translateArgs("UI_DIALOG_HERO_ROLE_SINGLE",_loc9_.join(", "));
         }
         else
         {
            _loc3_ = Translate.translateArgs("UI_DIALOG_HERO_ROLE_LIST",_loc9_.join(", "));
         }
         _loc2_ = _loc2_ + _loc3_;
         _loc2_ = _loc2_ + "\n";
         _loc2_ = _loc2_ + "\n";
         _loc2_ = _loc2_ + _loc4_.descText;
         _loc2_ = _loc2_ + "\n";
         _loc2_ = _loc2_ + "\n";
         var _loc12_:PlayerHeroEntrySourceData = PlayerHeroEntrySourceData.createEmpty(_loc4_);
         var _loc10_:PlayerHeroEntry = new PlayerHeroEntry(_loc4_,_loc12_);
         var _loc6_:Vector.<SkillDescription> = DataStorage.skill.getByHero(_loc4_.id).concat();
         _loc6_.sort(SkillDescription.sort_byTier);
         _loc6_.shift();
         var _loc15_:int = _loc6_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc15_)
         {
            _loc11_ = new SkillTooltipMessageFactory(_loc10_,_loc6_[_loc5_]);
            _loc17_ = new BundleSkillValueObject(_loc6_[_loc5_],_loc11_);
            _loc2_ = _loc2_ + _loc17_.name;
            _loc2_ = _loc2_ + "\n";
            _loc16_ = _loc17_.desc;
            _loc7_ = _loc16_.split("^");
            _loc16_ = "";
            _loc13_ = _loc7_.length;
            _loc8_ = 0;
            while(_loc8_ < _loc13_)
            {
               if((_loc7_[_loc8_] as String).match(/{\d+ \d+ \d+}/).length == 0)
               {
                  _loc16_ = _loc16_ + _loc7_[_loc8_];
               }
               _loc8_++;
            }
            _loc2_ = _loc2_ + _loc16_;
            _loc2_ = _loc2_ + "\n";
            _loc2_ = _loc2_ + "\n";
            _loc5_++;
         }
         Clipboard.generalClipboard.setData("air:text",_loc2_);
      }
      
      [Console(text="Версия боёвки. Без параметров - узнать текущую версию. С параметром - переопределить версию")]
      public function battleVersion(param1:int = 0) : String
      {
         if(param1 != 0)
         {
            Version.current = param1;
         }
         return "Version.current=" + String(Version.current) + " Version.last=" + String(Version.last);
      }
      
      [Console(text="Список героя с рунами в кузнице")]
      public function testDialog_heroRuneList() : void
      {
         PopupList.instance.dialog_hero_rune_list(null);
      }
      
      [Console(text="Симулировать на клиенте время завершения для всех акций согласно заданному значению в секундах")]
      public function specialOffer_setTimeLeft(param1:int = 5) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = GameModel.instance.player.specialOffer.unsafeList;
         for each(var _loc2_ in GameModel.instance.player.specialOffer.unsafeList)
         {
            if(_loc2_ is PlayerSpecialOfferWithTimer)
            {
               (_loc2_ as PlayerSpecialOfferWithTimer).unsafeEndTime = GameTimer.instance.currentServerTime + param1;
            }
         }
      }
      
      [Console(text="Симулировать обновление офера `камни души за энергию` : id offer\'a - int=2, progress=4")]
      public function specialOffer_update_timer(param1:int = 5) : void
      {
         var _loc2_:RPCCommandBase = new RPCCommandBase();
         _loc2_.result = new CommandResult({"missionEnd":{"specialOffers":[{
            "clientData":null,
            "id":1,
            "type":"energySpent",
            "endTime":GameTimer.instance.currentServerTime + param1,
            "offerData":{
               "saveData":true,
               "reward":{"fragmentHero":{"12":1}},
               "energyDelta":6
            }
         }]}});
         GameModel.instance.player.specialOffer.onRpc_update(_loc2_);
      }
      
      [Console(text="Обновить активные спец предложения")]
      public function billings_reset() : void
      {
         GameModel.instance.actionManager.playerCommands.updateBilllingsOnTransaction();
      }
      
      [Console(text="Симулировать обновление офера `камни души за энергию` : id offer\'a - int=2, progress=4")]
      public function specialOffer_update_limit(param1:int = 4) : void
      {
         var _loc2_:RPCCommandBase = new RPCCommandBase();
         _loc2_.result = new CommandResult({"missionEnd":{"specialOffers":[{
            "clientData":null,
            "id":2,
            "type":"energySpent",
            "offerData":{
               "reward":{"fragmentHero":{"12":1}},
               "saveData":[],
               "energyDelta":6
            },
            "extraData":{
               "limit":{"fragmentHero":{"12":30}},
               "current":{"fragmentHero":{"12":param1}}
            }
         }]}});
         GameModel.instance.player.specialOffer.onRpc_update(_loc2_);
      }
      
      [Console(text="Симулировать удаление офера по числовому id")]
      public function specialOffer_remove(param1:int) : void
      {
         var _loc2_:RPCCommandBase = new RPCCommandBase();
         _loc2_.result = new CommandResult({"missionEnd":{"endSpecialOffers":[param1]}});
         GameModel.instance.player.specialOffer.onRpc_update(_loc2_);
      }
      
      [Console(text="Получить список активных акций/оферов")]
      public function specialOffer_list() : String
      {
         return GameModel.instance.player.specialOffer.unsafeList.join("\n");
      }
      
      [Console(text="Симуляция запланированной смены дня на сервере. Время следующего ресета не обновляется")]
      public function nextDayReset() : void
      {
         PopupList.instance.message(Translate.translate("UI_POPUP_MESSAGE_DAY_RESET"));
         var _loc1_:CommandUserResetDay = GameModel.instance.actionManager.playerCommands.userResetDay(GameModel.instance.player.levelData.level.level);
         _loc1_.onClientExecute(handler_resetClientExecute);
      }
      
      private function handler_resetClientExecute(param1:CommandUserResetDay) : void
      {
         GameTimer.instance.nextDayTimestamp = param1.result.data.body.nextDayTs;
      }
      
      [Console(text="Диалог башни")]
      public function testDialog_tower() : void
      {
         GameModel.instance.player.tower.openFloorPopup();
      }
      
      [Console(text="Открытие любого диалога с медиатором и одним параметром у конструктора - player")]
      public function testDialog(param1:String) : String
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      [Console(text="Диалог настроек")]
      public function testDialog_settings() : void
      {
         var _loc1_:SettingsPopupMediator = new SettingsPopupMediator(GameModel.instance.player);
         _loc1_.open();
      }
      
      [Console(text="")]
      public function startRecording() : void
      {
         ClickLoger.startRecording();
      }
      
      [Console(text="")]
      public function stopRecording() : void
      {
         ClickLoger.stopRecording();
      }
      
      [Console(text="")]
      public function startReplay() : void
      {
         BattleController.DEFAULT_TIME_SCALE = 21;
         ClickLoger.startReplay();
      }
      
      [Console(text="requestsSend")]
      public function requestsSend(... rest) : void
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc9_:* = undefined;
         _loc3_ = 0;
         var _loc7_:int = 0;
         var _loc2_:NotificationDescription = DataStorage.notification.getByIdent("friendGift");
         var _loc8_:Vector.<PlatformUser> = new Vector.<PlatformUser>();
         if(rest.length)
         {
            _loc3_ = rest.length;
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               _loc5_ = GameModel.instance.player.friends.getByAccountId(rest[_loc6_]);
               if(_loc5_)
               {
                  _loc4_ = _loc5_.platformUser;
                  _loc8_.push(_loc4_);
               }
               _loc6_++;
            }
         }
         else
         {
            _loc9_ = GameModel.instance.player.friends.getAppFriends();
            _loc3_ = Math.min(10,_loc9_.length);
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               _loc8_.push(_loc9_[_loc7_].platformUser);
               _loc7_++;
            }
         }
         GameModel.instance.actionManager.platform.requestSend(_loc8_,_loc2_);
      }
      
      [Console(text="Закрыть всё и вся, даже если нельзя")]
      public function closeAll() : void
      {
         GamePopupManager.closeAll();
      }
      
      [Console(text="Переключение начала всех боёв с включённым автобоем")]
      public function autoBattleEverywhere() : String
      {
         BattleController.DEFAULT_AUTO_BATTLE = !BattleController.DEFAULT_AUTO_BATTLE;
         if(BattleController.DEFAULT_AUTO_BATTLE)
         {
            return "Теперь все бои начинаюся с включённым автобоем";
         }
         return "Не все бои теперь начинаюся с включённым автобоем";
      }
      
      [Console(text="Многократное ускорение боя по-умолчанию")]
      public function superFastBattle() : void
      {
         if(BattleController.DEFAULT_TIME_SCALE != 20)
         {
            BattleController.DEFAULT_TIME_SCALE = 20;
         }
         else
         {
            BattleController.DEFAULT_TIME_SCALE = 1;
         }
      }
      
      [Console(text="Многократное замедление боя по-умолчанию")]
      public function superSlowBattle() : void
      {
         if(BattleController.DEFAULT_TIME_SCALE != 0.1)
         {
            BattleController.DEFAULT_TIME_SCALE = 0.1;
         }
         else
         {
            BattleController.DEFAULT_TIME_SCALE = 1;
         }
      }
      
      [Console(text="Окно страта заданной мисси")]
      public function textDialog_missionStart(param1:int = 35) : void
      {
         id = param1;
         onMissionStartCommand = function(param1:RPCCommandBase):void
         {
            team.close();
         };
         startOnTeamSelect = function(param1:TeamGatherPopupMediator):void
         {
            var _loc2_:Vector.<PlayerHeroEntry> = param1.playerEntryTeamList;
            var _loc3_:CommandMissionStart = GameModel.instance.actionManager.mission.missionStart(mission,_loc2_);
            _loc3_.signal_complete.add(onMissionStartCommand);
         };
         var mission:MissionDescription = DataStorage.mission.getMissionById(id);
         var mechanic:MechanicDescription = MechanicStorage.MISSION;
         var team:TeamGatherByActivityPopupMediator = new TeamGatherByActivityPopupMediator(GameModel.instance.player,mechanic);
         team.signal_teamGatherComplete.addOnce(startOnTeamSelect);
         team.open();
      }
      
      [Console(text="Потоковое тестирование валидации")]
      public function testVerification() : void
      {
         var _loc1_:BattleTestVerificationPopupMediator = new BattleTestVerificationPopupMediator(GameModel.instance.player);
         _loc1_.open();
      }
      
      [Console(text="Диалог арены обв.")]
      public function arenaDialog() : void
      {
         var _loc1_:ArenaPopupMediator = new ArenaPopupMediator(GameModel.instance.player);
         _loc1_.open();
      }
      
      [Console(text="Установить геров на арену")]
      public function setArenaHeroes() : void
      {
         var _loc2_:Player = GameModel.instance.player;
         var _loc1_:TeamGatherPopupMediator = new TeamGatherPopupMediator(_loc2_,UnitUtils.heroVectorToUnitVector(_loc2_.arena.getDefenders()[0]));
         _loc1_.signal_teamGatherComplete.addOnce(saveArenaTeamOnTeamSelect);
         _loc1_.open();
      }
      
      private function saveArenaTeamOnTeamSelect(param1:TeamGatherPopupMediator) : void
      {
         var _loc2_:CommandArenaSetHeroes = new CommandArenaSetHeroes(param1.descriptionList);
         GameModel.instance.actionManager.executeRPCCommand(_loc2_);
      }
      
      [Console(text="Логирование пирожков")]
      public function log(param1:String) : void
      {
         Logger.getLogger(this).debug(param1);
      }
      
      [Console(text="Просмотреть реплей. [id реплея] [версия боёвки, по умолчанию - версия из реплея] [тип боя, по умолчанию - тип из реплея]")]
      public function replay(param1:String, param2:int = 0, param3:String = null) : void
      {
         var _loc4_:CommandBattleStartReplay = new CommandBattleStartReplay(param1,param2,param3);
         GameModel.instance.actionManager.executeRPCCommand(_loc4_);
      }
      
      [Console(text="Просмотреть реплей в режиме инспекции. [id реплея] [версия боёвки, по умолчанию - версия из реплея] [тип боя, по умолчанию - тип из реплея]")]
      public function inspect(param1:String = null, param2:int = 0, param3:String = null) : String
      {
         var _loc5_:* = false;
         var _loc4_:Boolean = param1 == null || !BattleHero.BATTLE_INSPECTOR;
         if(_loc4_)
         {
            var _loc6_:* = !BattleHero.BATTLE_INSPECTOR;
            BattleHero.BATTLE_INSPECTOR = _loc6_;
            _loc5_ = _loc6_;
            BattleGuiMediator.enableTestSpeedUp.value = _loc5_;
         }
         if(param1)
         {
            replay(param1,param2,param3);
         }
         if(param1 == null)
         {
            return "Инспектор боя " + (!!_loc5_?"включён":"выключен");
         }
         return null;
      }
      
      [Console(text="trace лога последнего боя")]
      public function traceBattleLog() : void
      {
      }
      
      [Console(text="Автоматическое проведение боёв и сбор статистики для баланса персонажей")]
      public function testBalance(param1:String = null) : void
      {
         var _loc2_:BattleTestStatsPopupMediator = new BattleTestStatsPopupMediator(GameModel.instance.player,param1);
         _loc2_.open();
      }
      
      [Console(text="Вывод в trace лога боя на основании серии ошибок из лога ошибок")]
      public function decodeBattleLog(param1:String) : void
      {
         BattleLogEncoder.printLogFromErrorList(param1);
      }
      
      [Console(text="Скрыть статы")]
      public function hideStats() : void
      {
         Starling.current.showStats = !Starling.current.showStats;
      }
      
      [Console(text="Всегда показывать кнопку Ускорения бойв")]
      public function showFastBattle() : void
      {
         BattleGuiMediator.enableTestSpeedUp.toggle();
      }
      
      [Console(text="Окно победы в миссии")]
      public function testDialog_missionVictory() : void
      {
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc1_:RewardData = new RewardData();
         _loc1_.gold = 495;
         _loc1_.experience = 60;
         _loc1_.inventoryCollection.addItem(DataStorage.gear.getById(1) as GearItemDescription,1);
         _loc1_.inventoryCollection.addItem(DataStorage.gear.getById(2) as GearItemDescription,2);
         _loc1_.inventoryCollection.addItem(DataStorage.gear.getById(3) as GearItemDescription,12);
         _loc1_.inventoryCollection.addItem(DataStorage.gear.getById(4) as GearItemDescription,13);
         _loc1_.inventoryCollection.addItem(DataStorage.gear.getById(5) as GearItemDescription,15);
         _loc1_.inventoryCollection.addItem(DataStorage.gear.getById(6) as GearItemDescription,16);
         var _loc5_:Vector.<RewardData> = new Vector.<RewardData>();
         _loc5_.push(_loc1_);
         var _loc9_:Vector.<UnitEntryValueObject> = new Vector.<UnitEntryValueObject>();
         var _loc6_:Vector.<PlayerHeroEntry> = GameModel.instance.player.heroes.getList();
         var _loc4_:int = Math.min(_loc6_.length,5);
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc7_ = _loc6_[_loc8_].hero;
            _loc9_.push(new HeroEntryValueObject(_loc7_,_loc6_[_loc8_]));
            _loc1_.addHeroXp(_loc7_,12);
            _loc8_++;
         }
         var _loc2_:MultiBattleResult = new MultiBattleResult();
         _loc2_.attackers = _loc9_;
         _loc2_.setVictory(2);
         var _loc10_:MissionBattleResultValueObject = BattleResultValueObjectFactory.createMissionResult(_loc2_);
         _loc10_.reward = _loc1_;
         var _loc3_:MissionRewardPopupMediator = new MissionRewardPopupMediator(GameModel.instance.player,_loc10_,null);
         _loc3_.open();
      }
      
      [Console(text="Окно победы на арене")]
      public function testDialog_arenaVictory() : void
      {
         var _loc4_:* = null;
         var _loc1_:RewardData = new RewardData();
         _loc1_.gold = 495;
         _loc1_.experience = 60;
         _loc1_.inventoryCollection.addItem(DataStorage.gear.getById(1) as GearItemDescription,1);
         _loc1_.inventoryCollection.addItem(DataStorage.gear.getById(2) as GearItemDescription,2);
         _loc1_.inventoryCollection.addItem(DataStorage.gear.getById(3) as GearItemDescription,12);
         _loc4_ = DataStorage.hero.getHeroById(2);
         _loc1_.addHeroXp(_loc4_,12);
         _loc4_ = DataStorage.hero.getHeroById(3);
         _loc1_.addHeroXp(_loc4_,12);
         _loc4_ = DataStorage.hero.getHeroById(12);
         _loc1_.addHeroXp(_loc4_,12);
         var _loc3_:Vector.<RewardData> = new Vector.<RewardData>();
         _loc3_.push(_loc1_);
         var _loc2_:Object = JSON.parse("{\"enemies\":[{\"userId\":\"335\",\"power\":\"58501\",\"user\":{\"avatarId\":\"5\",\"clanId\":null,\"experience\":\"94655\",\"name\":\"Volt(220)\",\"clanRole\":null,\"accountId\":\"174572176\",\"lastLoginTime\":\"1453381615\",\"serverId\":\"2\",\"id\":\"335\"},\"place\":\"1\",\"heroes\":[{\"color\":13,\"star\":5,\"id\":5,\"level\":70},{\"color\":13,\"star\":5,\"id\":13,\"level\":70},{\"color\":13,\"star\":5,\"id\":12,\"level\":70},{\"color\":11,\"star\":5,\"id\":1,\"level\":70},{\"color\":13,\"star\":5,\"id\":4,\"level\":70}]},{\"userId\":\"374\",\"power\":\"909\",\"user\":{\"avatarId\":\"5\",\"clanId\":\"4\",\"experience\":\"4690\",\"name\":\"<--\",\"clanRole\":\"2\",\"accountId\":\"208206002\",\"lastLoginTime\":\"1453452511\",\"serverId\":\"2\",\"id\":\"374\"},\"place\":\"6\",\"heroes\":[{\"color\":1,\"star\":3,\"id\":13,\"level\":21}]},{\"userId\":\"410\",\"power\":\"408\",\"user\":{\"avatarId\":\"1\",\"clanId\":\"4\",\"experience\":\"6\",\"name\":null,\"clanRole\":\"1\",\"accountId\":\"230849\",\"lastLoginTime\":\"1442418808\",\"serverId\":\"2\",\"id\":\"410\"},\"place\":\"8\",\"heroes\":[{\"color\":1,\"star\":1,\"id\":10,\"level\":1},{\"color\":1,\"star\":1,\"id\":20,\"level\":1},{\"color\":1,\"star\":1,\"id\":14,\"level\":1}]}],\"battles\":[{\"userId\":\"517\",\"defenders\":[{\"2\":{\"color\":3,\"dodge\":10,\"star\":1,\"strength\":123,\"agility\":36,\"level\":14,\"xp\":1625,\"hp\":1060,\"lifesteal\":180,\"slots\":[],\"physicalCritChance\":6,\"physicalAttack\":152,\"armor\":88,\"magicResist\":16,\"power\":1080,\"intelligence\":65,\"skills\":{\"1\":14,\"2\":14},\"id\":2},\"3\":{\"color\":3,\"dodge\":60,\"star\":1,\"strength\":28,\"agility\":94,\"level\":14,\"xp\":1625,\"hp\":1240,\"lifesteal\":360,\"slots\":[],\"physicalCritChance\":16,\"physicalAttack\":191,\"armor\":288,\"power\":1663,\"intelligence\":85,\"skills\":{\"1\":14,\"2\":14},\"id\":3},\"12\":{\"color\":3,\"dodge\":70,\"star\":1,\"strength\":35,\"agility\":87,\"level\":14,\"xp\":1625,\"hp\":880,\"lifesteal\":360,\"slots\":[],\"physicalCritChance\":16,\"physicalAttack\":191,\"armor\":288,\"power\":1656,\"intelligence\":78,\"skills\":{\"1\":14,\"2\":14},\"id\":12},\"13\":{\"color\":3,\"dodge\":60,\"star\":1,\"strength\":55,\"agility\":36,\"level\":14,\"xp\":1625,\"hp\":4500,\"slots\":[],\"physicalAttack\":63,\"armor\":81,\"magicResist\":108,\"power\":1406,\"magicPower\":297,\"intelligence\":131,\"skills\":{\"1\":14,\"2\":14},\"id\":13}}],\"startTime\":1453460531,\"typeId\":\"490\",\"effects\":[],\"seed\":1007095946,\"reward\":[],\"attackers\":{\"8\":{\"color\":2,\"dodge\":70,\"star\":2,\"strength\":81,\"agility\":154,\"level\":31,\"xp\":7604,\"hp\":880,\"lifesteal\":180,\"slots\":{\"0\":0,\"2\":0,\"3\":0,\"4\":0,\"5\":0},\"physicalAttack\":25,\"armor\":480,\"power\":2376,\"intelligence\":141,\"skills\":{\"1\":31,\"2\":31},\"id\":8},\"1\":{\"color\":3,\"dodge\":10,\"star\":2,\"strength\":217,\"agility\":95,\"level\":31,\"xp\":7604,\"hp\":1480,\"lifesteal\":180,\"slots\":{\"0\":0,\"3\":0},\"physicalCritChance\":6,\"physicalAttack\":152,\"armor\":140,\"magicResist\":24,\"power\":1857,\"intelligence\":151,\"skills\":{\"1\":31,\"2\":26},\"id\":1},\"4\":{\"color\":2,\"star\":2,\"strength\":191,\"agility\":88,\"level\":31,\"xp\":7604,\"hp\":920,\"slots\":{\"0\":0,\"2\":0,\"3\":0,\"4\":0,\"5\":0},\"physicalAttack\":116,\"armor\":36,\"power\":1394,\"intelligence\":148,\"skills\":{\"1\":31,\"2\":31},\"id\":4},\"5\":{\"color\":2,\"dodge\":60,\"star\":2,\"strength\":117,\"agility\":88,\"level\":31,\"xp\":7604,\"hp\":5580,\"slots\":{\"0\":0,\"4\":0,\"5\":0},\"physicalAttack\":39,\"magicResist\":36,\"power\":1412,\"magicPower\":90,\"intelligence\":191,\"skills\":{\"1\":31,\"2\":7},\"id\":5},\"7\":{\"color\":2,\"dodge\":60,\"star\":1,\"strength\":86,\"agility\":57,\"level\":31,\"xp\":7604,\"hp\":5580,\"slots\":{\"3\":0,\"4\":0,\"5\":0},\"physicalAttack\":63,\"magicResist\":36,\"power\":1346,\"magicPower\":54,\"intelligence\":160,\"skills\":{\"1\":31,\"2\":22},\"id\":7}}}],\"win\":true,\"state\":{\"userId\":\"517\",\"arenaPlace\":\"10\",\"grandPower\":\"0\",\"arenaPower\":\"9645\",\"grandHeroes\":[],\"grandCoin\":\"0\",\"arenaHeroes\":[{\"color\":2,\"star\":2,\"id\":8,\"level\":31},{\"color\":2,\"star\":1,\"id\":7,\"level\":31},{\"color\":2,\"star\":2,\"id\":9,\"level\":12},{\"color\":3,\"star\":1,\"id\":12,\"level\":32},{\"color\":3,\"star\":2,\"id\":1,\"level\":31}],\"grandPlace\":null,\"grandCoinTime\":null}}");
         BattleDamageStatistics.deserialize(JSON.parse("{\"attackers\":{\"8\":3521,\"1\":5759,\"4\":2503,\"5\":5748,\"7\":843},\"defenders\":{\"2\":5612,\"3\":1260,\"12\":4083,\"13\":10669}}"));
      }
      
      [Console(text="Окно гранд-арены")]
      public function testDialog_grand() : void
      {
         var _loc1_:GrandPopupMediator = new GrandPopupMediator(GameModel.instance.player);
         _loc1_.open();
      }
      
      [Console(text="Окно поиска клана")]
      public function testDialog_clan_search() : void
      {
         var _loc1_:ClanSearchPopupMediator = new ClanSearchPopupMediator(GameModel.instance.player);
         _loc1_.open();
      }
      
      [Console(text="Окно инфо по клану")]
      public function testDialog_clan_info() : void
      {
         var _loc1_:ClanInfoPopupMediator = new ClanInfoPopupMediator(GameModel.instance.player);
         _loc1_.open();
      }
      
      [Console(text="Окно обмена шмота на очки активности")]
      public function testDialog_clan_itemForActivity() : void
      {
         var _loc1_:ClanItemForActivityPopupMediator = new ClanItemForActivityPopupMediator(GameModel.instance.player);
         _loc1_.open();
      }
      
      [Console(text="Окно поражения в миссии")]
      public function testDialog_missionDefeat() : void
      {
         var _loc1_:MissionDefeatPopupMediator = new MissionDefeatPopupMediator(GameModel.instance.player,null,MechanicStorage.MISSION);
         _loc1_.open();
      }
      
      [Console(text="Окно мультифарма почты")]
      public function testDialog_mailMultiFarm() : void
      {
         var _loc1_:RewardData = new RewardData();
         _loc1_.inventoryCollection.addItem(DataStorage.gear.getById(1) as GearItemDescription,1);
         _loc1_.inventoryCollection.addItem(DataStorage.gear.getById(2) as GearItemDescription,2);
         _loc1_.inventoryCollection.addItem(DataStorage.gear.getById(3) as GearItemDescription,12);
         PopUpManager.addPopUp(new PlayerMailMultifarmPopup(_loc1_.outputDisplay));
      }
      
      [Console(text="Окно получения героя")]
      public function testDialog_rewardHero(param1:int, param2:int) : void
      {
         var _loc3_:HeroDescription = DataStorage.hero.getHeroById(param1);
         PopUpManager.addPopUp(new RewardHeroPopup(_loc3_,param2));
      }
      
      [Console(text="Окно повышения цвета героя")]
      public function testDialog_heroColorUp(param1:int, param2:int, param3:int = 2) : void
      {
         var _loc5_:HeroDescription = DataStorage.hero.getHeroById(param1);
         var _loc6_:HeroEntry = new HeroEntry(_loc5_,new HeroEntrySourceData({
            "star":param2,
            "color":param3,
            "lvl":22
         }));
         var _loc4_:HeroColorUpPopup = new HeroColorUpPopup(_loc6_,1);
         PopUpManager.addPopUp(_loc4_);
      }
      
      [Console(text="Окно магазина редкостей")]
      public function testDialog_specialShop() : void
      {
         var _loc2_:* = null;
         var _loc1_:SpecialShopMerchant = GameModel.instance.player.specialShop.model.getAvailableMerchant();
         if(_loc1_ != null)
         {
            _loc2_ = new SpecialShopPopupMediator(_loc1_);
            _loc2_.open();
         }
      }
      
      [Console(text="Окно повышения звезды героя")]
      public function testDialog_heroStarUp(param1:int, param2:int, param3:int = 2) : void
      {
         var _loc6_:HeroDescription = DataStorage.hero.getHeroById(param1);
         var _loc7_:HeroEntry = new HeroEntry(_loc6_,new HeroEntrySourceData({
            "star":param2,
            "color":param3,
            "lvl":22
         }));
         var _loc5_:HeroEntry = new HeroEntry(_loc6_,new HeroEntrySourceData({
            "star":param2 - 1,
            "color":param3,
            "lvl":22
         }));
         var _loc4_:HeroStarUpPopup = new HeroStarUpPopup(_loc7_,_loc5_.getBasicBattleStats(),1);
         PopUpManager.addPopUp(_loc4_);
      }
      
      [Console(text="Окно повышения уровня команды ")]
      public function testDialog_levelUp(param1:int, param2:int) : void
      {
         var _loc3_:PlayerTeamLevel = DataStorage.level.getTeamLevelByLevel(param1);
         var _loc4_:PlayerTeamLevel = DataStorage.level.getTeamLevelByLevel(param2);
         PopupList.instance.dialog_level_up(_loc3_,_loc4_);
      }
      
      [Console(text="Окно повышения уровня облика")]
      public function testDialog_skinLevelUp(param1:int) : void
      {
         PopupList.instance.dialog_skin_level_up(param1);
      }
      
      [Console(text="Окно инфо облика")]
      public function testDialog_skinInfo(param1:int) : void
      {
         PopupList.instance.dialog_skin_info(param1);
      }
      
      [Console(text="Окно покупки биллинга ")]
      public function testDialog_vipLevelUp(param1:int) : void
      {
         var _loc2_:VipLevelUpPopupMediator = new VipLevelUpPopupMediator(GameModel.instance.player,param1);
         _loc2_.open();
      }
      
      [Console(text="версия клиента")]
      public function version() : void
      {
         PopupList.instance.message(ClientVersion.version);
      }
      
      [Console(text="симуляция ошибки")]
      public function error(param1:int) : void
      {
         PopupList.instance.error("1","2",Boolean(param1));
      }
      
      [Console(text="тестовое сообщение от айфрейма в клиент")]
      public function test_push() : void
      {
         GameModel.instance.actionManager.pushTest();
      }
      
      [Console(text="сброс таймеров на автоматический показ окон при старте игры")]
      public function autoPopup_resetSharedObject() : void
      {
         GameModel.instance.player.sharedObjectStorage.debug_clearAll();
      }
      
      [Console(text="тестовое сообщение от айфрейма в клиент")]
      public function test_push_billing(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc5_:Vector.<PlayerBillingDescription> = GameModel.instance.player.billingData.list;
         var _loc3_:int = _loc5_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc5_[_loc4_].id == int(param1))
            {
               _loc2_ = _loc5_[_loc4_];
               break;
            }
            _loc4_++;
         }
         if(_loc2_)
         {
            GameModel.instance.actionManager.pushBillingTest(_loc2_);
         }
      }
      
      [Console(text="тестовое добавление аккаунта для мержа")]
      public function test_AddUserToUserMerge() : void
      {
         GameModel.instance.actionManager.executeRPCCommand(new CommandTestAddUserToUserMerge());
      }
      
      [Console(text="обновление офферов")]
      public function test_SpecialOfferGetAll() : void
      {
         var _loc1_:CommandOfferGetAll = GameModel.instance.actionManager.playerCommands.specialOfferGetAll();
      }
      
      [Console(text="отображение окна со списком титанов")]
      public function test_showTitanList() : void
      {
         var _loc1_:TitanListPopupMediator = new TitanListPopupMediator(GameModel.instance.player);
         _loc1_.open(null);
      }
      
      [Console(text="Окно повышения звезды титана")]
      public function testDialog_titanStarUp(param1:int, param2:int) : void
      {
         var _loc5_:TitanDescription = DataStorage.titan.getTitanById(param1);
         var _loc4_:TitanEntry = new TitanEntry(_loc5_,new TitanEntrySourceData({
            "star":param2,
            "lvl":22
         }));
         var _loc6_:TitanEntry = new TitanEntry(_loc5_,new TitanEntrySourceData({
            "star":param2 - 1,
            "lvl":22
         }));
         var _loc3_:TitanStarUpPopup = new TitanStarUpPopup(_loc4_,_loc6_.battleStats,1);
         PopUpManager.addPopUp(_loc3_);
      }
   }
}

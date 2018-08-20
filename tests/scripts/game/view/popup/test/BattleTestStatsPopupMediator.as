package game.view.popup.test
{
   import battle.BattleConfig;
   import battle.BattleLog;
   import battle.data.BattleData;
   import battle.data.BattleHeroDescription;
   import by.blooddy.crypto.Base64;
   import engine.core.assets.AssetLoader;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import feathers.data.ListCollection;
   import flash.desktop.Clipboard;
   import flash.utils.ByteArray;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.BattleAssetStorage;
   import game.battle.controller.thread.BattleThread;
   import game.battle.controller.thread.SingleBattleThread;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.skin.SkinDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.util.ConsoleSOStorage;
   import game.view.gui.components.toggle.ClipToggleButton;
   import game.view.popup.PopupBase;
   import game.view.popup.test.grade.BattleTestGradeModel;
   import game.view.popup.test.grade.IntVectorByteArrayEncoder;
   import game.view.popup.test.stattask.BattleStatTaskExecutor;
   import game.view.popup.test.stattask.BattleStatTaskPopupMediator;
   import idv.cjcat.signals.Signal;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   
   public class BattleTestStatsPopupMediator extends PopupMediator implements IAnimatable
   {
      
      public static const GRADE_BOTH:int = 0;
      
      public static const GRADE_LEFT:int = 1;
      
      public static const GRADE_RIGHT:int = 2;
      
      public static const TAB_HEROES:int = 0;
      
      public static const TAB_CREEPS:int = 1;
      
      public static const TAB_BOSSES:int = 2;
      
      public static const TAB_TITANS:int = 3;
      
      private static const GRADES_COUNT:int = 3;
       
      
      public const CONFIGS:Vector.<String> = new <String>[DataStorage.battleConfig.PVP.name,DataStorage.battleConfig.PVE.name,DataStorage.battleConfig.TOWER.name,DataStorage.battleConfig.BOSS.name,DataStorage.battleConfig.TITAN.name];
      
      public const SKIN_MODES:Vector.<String> = new <String>["Без скинов","Все со скинами","Скины аккаунта"];
      
      public const HERO_TABS:Vector.<String> = new <String>["Герои","Крипы","Боссы","Титаны"];
      
      private const _codeIsRefreshing:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const _codeIsUpdated:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const _reportIsCopied:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const _shortWinrateReportIsCopied:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const _attackersDefendersWinrateReportIsCopied:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const _urlIsCopied:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const _reportIsAvailable:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const _doNotRandomRight:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const _powerLeft:IntPropertyWriteable = new IntPropertyWriteable(0);
      
      private const _powerRight:IntPropertyWriteable = new IntPropertyWriteable(0);
      
      private const _selectedHeroTab:IntPropertyWriteable = new IntPropertyWriteable(0);
      
      public const onStartButtonToggled:Signal = new Signal();
      
      public const onHeroStatsOutput:Signal = new Signal(String);
      
      public const onReportUpdated:Signal = new Signal();
      
      public const onPresetsChanged:Signal = new Signal();
      
      public const onGradeModeChanged:Signal = new Signal();
      
      public const onFillEmptySlotsChanged:Signal = new Signal();
      
      public const onChangeVisibility:Signal = new Signal(Boolean);
      
      public const onBattlegroundChanged:Signal = new Signal();
      
      public const onConfigChanged:Signal = new Signal();
      
      public const onSkinModeChanged:Signal = new Signal();
      
      public const grade_left:BattleTestGradeModel = new BattleTestGradeModel();
      
      public const grade_right:BattleTestGradeModel = new BattleTestGradeModel();
      
      public const codeIsRefreshing:BooleanProperty = _codeIsRefreshing;
      
      public const codeIsUpdated:BooleanProperty = _codeIsUpdated;
      
      public const reportIsCopied:BooleanProperty = _reportIsCopied;
      
      public const shortWinrateReportIsCopied:BooleanProperty = _shortWinrateReportIsCopied;
      
      public const attackersDefendersWinrateReportIsCopied:BooleanProperty = _attackersDefendersWinrateReportIsCopied;
      
      public const urlIsCopied:BooleanProperty = _urlIsCopied;
      
      public const reportIsAvailable:BooleanProperty = _reportIsAvailable;
      
      public const doNotRandomRight:BooleanProperty = _doNotRandomRight;
      
      public const powerLeft:IntProperty = _powerLeft;
      
      public const powerRight:IntProperty = _powerRight;
      
      public const selectedHeroTab:IntProperty = _selectedHeroTab;
      
      protected var testSetup:BattleTestSetup;
      
      private var _currentBattlegroundId:int = 1;
      
      private var _gradeMode:int = 0;
      
      private var _sameGradesInGradeBoth:Boolean = false;
      
      private var _fillEmptySlots:Boolean = false;
      
      private var _configIndex:int = 0;
      
      private var _skinModeIndex:int = 0;
      
      protected var enabled:Boolean;
      
      protected var leftTeam:TeamGatherPopupMediatorAllHeroes;
      
      protected var rightTeam:TeamGatherPopupMediatorAllHeroes;
      
      public const battlegrounds:ListCollection = new ListCollection();
      
      public function BattleTestStatsPopupMediator(param1:Player, param2:String = null)
      {
         var _loc7_:* = null;
         var _loc3_:* = undefined;
         super(param1);
         var _loc4_:Vector.<UnitDescription> = new Vector.<UnitDescription>();
         var _loc5_:Vector.<UnitDescription> = new Vector.<UnitDescription>();
         if(param2)
         {
            _loc7_ = decodeUriSetupB(param2);
         }
         if(_loc7_)
         {
            setupState(_loc7_,_loc4_,_loc5_);
         }
         else
         {
            _loc3_ = ConsoleSOStorage.instance.getTestData();
            if(!_loc3_.testStatTeams)
            {
               _loc3_.testStatTeams = {};
            }
            setupState(_loc3_.testStatTeams,_loc4_,_loc5_);
         }
         leftTeam = new TeamGatherPopupMediatorAllHeroes(param1,_loc4_,true);
         rightTeam = new TeamGatherPopupMediatorAllHeroes(param1,_loc5_,true);
         leftTeam.onHeroPicked.add(onHeroPickedLeft);
         rightTeam.onHeroPicked.add(onHeroPickedRight);
         testSetup = new BattleTestSetup();
         var _loc6_:Vector.<BattleTestStatsBattlegroundValueObject> = new Vector.<BattleTestStatsBattlegroundValueObject>();
         var _loc8_:int = 1;
         while(AssetStorage.battleground.getById(_loc8_))
         {
            _loc6_.push(new BattleTestStatsBattlegroundValueObject(AssetStorage.battleground.getById(_loc8_)));
            _loc8_++;
         }
         this.battlegrounds.data = _loc6_;
         grade_left.level.signal_update.add(handler_updateGradeLevel);
         grade_right.level.signal_update.add(handler_updateGradeLevel);
      }
      
      private function setupState(param1:Object, param2:Vector.<UnitDescription>, param3:Vector.<UnitDescription>) : void
      {
         if(param1.leftTeam)
         {
            var _loc7_:int = 0;
            var _loc6_:* = param1.leftTeam;
            for each(var _loc4_ in param1.leftTeam)
            {
               param2.push(DataStorage.hero.getUnitById(_loc4_));
            }
         }
         if(param1.rightTeam)
         {
            var _loc9_:int = 0;
            var _loc8_:* = param1.rightTeam;
            for each(_loc4_ in param1.rightTeam)
            {
               param3.push(DataStorage.hero.getUnitById(_loc4_));
            }
         }
         _sameGradesInGradeBoth = false;
         if(param1.grade_both)
         {
            grade_left.deserialize(param1.grade_both);
            grade_right.deserialize(param1.grade_both);
            _sameGradesInGradeBoth = true;
         }
         else
         {
            if(param1.left)
            {
               grade_left.deserialize(param1.left);
            }
            if(param1.right)
            {
               grade_right.deserialize(param1.right);
            }
            else if(param1.left)
            {
               grade_right.deserialize(param1.left);
               _sameGradesInGradeBoth = true;
            }
         }
         var _loc5_:Vector.<int> = param1.params;
         deserializeParams(_loc5_);
      }
      
      public function get onCountUpdated() : Signal
      {
         return testSetup.onCountUpdated;
      }
      
      public function get gradeMode() : int
      {
         return _gradeMode;
      }
      
      public function get gradeModeButtonName() : String
      {
         if(_gradeMode == 0)
         {
            return "Обе команды";
         }
         if(_gradeMode == 2)
         {
            return "Правая";
         }
         if(_gradeMode == 1)
         {
            return "Левая";
         }
         return "Ты сломал игру";
      }
      
      public function get fillEmptySlots() : Boolean
      {
         return _fillEmptySlots;
      }
      
      public function get battlesStartedCount() : int
      {
         return testSetup.startedCount;
      }
      
      public function get battlesSucceededCount() : int
      {
         return testSetup.succeededCount;
      }
      
      public function get battlesAttackersWinCount() : int
      {
         return testSetup.attackersWinCount;
      }
      
      public function get battlesBadCount() : int
      {
         return testSetup.failedCount;
      }
      
      public function get winrateString() : String
      {
         return testSetup.succeededCount > 0?(testSetup.attackersWinCount / testSetup.succeededCount * 100).toFixed(1) + "%":"";
      }
      
      public function get report() : String
      {
         return testSetup.statistics.getReport();
      }
      
      public function get winrateOnlyReport() : String
      {
         return testSetup.statistics.getShortReport();
      }
      
      public function get durationsReport() : String
      {
         return testSetup.statistics.getDurationReport();
      }
      
      public function get attackersDefendersReport() : String
      {
         return testSetup.getAttackersDefendersReport();
      }
      
      public function get leftTeamMediator() : TeamGatherPopupMediatorAllHeroes
      {
         return leftTeam;
      }
      
      public function get rightTeamMediator() : TeamGatherPopupMediatorAllHeroes
      {
         return rightTeam;
      }
      
      public function get startButtonEnabled() : Boolean
      {
         return enabled;
      }
      
      public function get currentBattlegroundName() : String
      {
         return AssetStorage.battleground.getById(_currentBattlegroundId).internalName;
      }
      
      public function get currentBattlegroundIndex() : int
      {
         return _currentBattlegroundId - 1;
      }
      
      public function get useInterpreter() : Boolean
      {
         return BattleAssetStorage.USE_INTERPRETER;
      }
      
      public function get sameGrades() : Boolean
      {
         return grade_left.isEqual(grade_right);
      }
      
      public function get configName() : String
      {
         return CONFIGS[_configIndex];
      }
      
      public function get skinMode() : String
      {
         return SKIN_MODES[_skinModeIndex];
      }
      
      protected function get leftGrade() : BattleTestGradeModel
      {
         return grade_left;
      }
      
      protected function get rightGrade() : BattleTestGradeModel
      {
         return _gradeMode == 0?grade_left:grade_right;
      }
      
      public function action_scenario() : void
      {
      }
      
      public function action_toggle(param1:ClipToggleButton) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:* = undefined;
         var _loc4_:* = undefined;
         if(!testSetup.isReady)
         {
            return;
         }
         if(enabled)
         {
            toggle();
            onReportUpdated.dispatch();
            _reportIsAvailable.value = true;
         }
         else
         {
            _loc3_ = this.leftTeam.descriptionList;
            _loc2_ = this.rightTeam.descriptionList;
            if(!_fillEmptySlots && (_loc3_.length == 0 || _loc2_.length == 0))
            {
               return;
            }
            testSetup.setupTeams(_loc3_,_loc2_);
            testSetup.fillEmptySlotsLeft = _fillEmptySlots;
            testSetup.fillEmptySlotsRight = _fillEmptySlots && !_doNotRandomRight.value;
            testSetup.collectStatisticsRight = !_doNotRandomRight.value;
            toggle();
            _loc4_ = ConsoleSOStorage.instance.getTestData().testStatTeams;
            _loc4_.grade_both = grade_left.serialize();
         }
      }
      
      public function action_startOne() : void
      {
         var _loc6_:* = null;
         if(!testSetup.isReady)
         {
            return;
         }
         var _loc3_:Vector.<UnitDescription> = this.leftTeam.descriptionList;
         var _loc1_:Vector.<UnitDescription> = this.rightTeam.descriptionList;
         if(!_fillEmptySlots && (_loc3_.length == 0 || _loc1_.length == 0))
         {
            return;
         }
         if(enabled)
         {
            action_toggle(null);
         }
         var _loc7_:* = ConsoleSOStorage.instance.getTestData().testStatTeams;
         var _loc4_:Array = [];
         var _loc10_:int = 0;
         var _loc9_:* = _loc3_;
         for each(var _loc8_ in _loc3_)
         {
            _loc4_.push(_loc8_.id);
         }
         _loc7_.leftTeam = _loc4_;
         _loc4_ = [];
         var _loc12_:int = 0;
         var _loc11_:* = _loc1_;
         for each(_loc8_ in _loc1_)
         {
            _loc4_.push(_loc8_.id);
         }
         _loc7_.rightTeam = _loc4_;
         testSetup.setupTeams(_loc3_,_loc1_);
         testSetup.fillEmptySlotsLeft = _fillEmptySlots;
         testSetup.fillEmptySlotsRight = _fillEmptySlots && !_doNotRandomRight.value;
         BattleLog.getLog();
         var _loc5_:BattleConfig = DataStorage.battleConfig.getByName(configName);
         var _loc2_:BattleData = testSetup.createBattleData(leftGrade,rightGrade,_loc5_.defaultHeroSpeed < 100);
         if(_loc2_)
         {
            applySkins(_loc2_.attackers.heroes);
            applySkins(_loc2_.defenders.heroes);
            trace("addTest(\'" + _loc2_.seed + "\',\'" + JSON.stringify(_loc2_.serialize()) + "\',\'" + "\');");
            onChangeVisibility.dispatch(false);
            _loc6_ = new SingleBattleThread(_loc2_,AssetStorage.battleground.getById(_currentBattlegroundId),_loc5_);
            _loc6_.run();
            _loc6_.onComplete.add(reveal);
            _loc6_.onRetreat.add(reveal);
         }
      }
      
      private function reveal(param1:BattleThread) : void
      {
         Game.instance.screen.hideBattle();
         onChangeVisibility.dispatch(true);
      }
      
      private function applySkins(param1:Vector.<BattleHeroDescription>) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         var _loc6_:* = null;
         var _loc10_:int = 0;
         var _loc9_:* = param1;
         for each(var _loc5_ in param1)
         {
            switch(int(_skinModeIndex))
            {
               case 0:
                  _loc5_.skin = 0;
                  continue;
               case 1:
                  _loc2_ = DataStorage.skin.getSkinsByHeroId(_loc5_.heroId);
                  if(_loc2_.length > 0)
                  {
                     _loc3_ = 0;
                     var _loc8_:int = 0;
                     var _loc7_:* = _loc2_;
                     for each(var _loc4_ in _loc2_)
                     {
                        if(_loc4_.id > _loc3_)
                        {
                           _loc3_ = _loc4_.id;
                        }
                     }
                     _loc5_.skin = _loc3_;
                  }
                  continue;
               case 2:
                  _loc6_ = player.heroes.getById(_loc5_.heroId);
                  if(_loc6_)
                  {
                     _loc5_.skin = _loc6_.currentSkin;
                  }
                  continue;
            }
         }
      }
      
      public function action_toggleEmptySlots() : void
      {
         _fillEmptySlots = !_fillEmptySlots;
         onFillEmptySlotsChanged.dispatch();
      }
      
      public function action_doNotRandomRight(param1:Boolean) : void
      {
         _doNotRandomRight.value = param1;
      }
      
      public function action_changeGradeMode() : void
      {
         if(_gradeMode == 0 && _sameGradesInGradeBoth)
         {
            grade_right.copyFrom(grade_left);
         }
         _gradeMode = (_gradeMode + 1) % 3;
         if(_gradeMode == 0)
         {
            _sameGradesInGradeBoth = sameGrades;
         }
         onGradeModeChanged.dispatch();
      }
      
      public function action_dropGrade() : void
      {
         grade_right.copyFrom(grade_left);
         onGradeModeChanged.dispatch();
      }
      
      public function action_changeConfig() : void
      {
         _configIndex = (_configIndex + 1) % CONFIGS.length;
         onConfigChanged.dispatch();
      }
      
      public function action_changeSkinMode() : void
      {
         _skinModeIndex = (_skinModeIndex + 1) % SKIN_MODES.length;
         onSkinModeChanged.dispatch();
      }
      
      public function action_clearResults() : void
      {
         testSetup.statistics.clear();
         testSetup.clear();
         onCountUpdated.dispatch();
         onReportUpdated.dispatch();
         _reportIsAvailable.value = false;
      }
      
      public function action_refreshCode() : void
      {
         testSetup.refreshCode();
         AssetStorage.hero.clear();
         _codeIsRefreshing.value = true;
         _codeIsUpdated.value = false;
         AssetStorage.instance.globalLoader.eventComplete.addOnce(handler_codeUpdated);
      }
      
      public function action_copyReport() : void
      {
         Clipboard.generalClipboard.setData("air:text",report);
         _reportIsCopied.value = true;
         Starling.juggler.delayCall(function():*
         {
            _reportIsCopied.value = false;
         },0.8);
      }
      
      public function action_winrateOnly() : void
      {
         Clipboard.generalClipboard.setData("air:text",winrateOnlyReport);
         _shortWinrateReportIsCopied.value = true;
         Starling.juggler.delayCall(function():*
         {
            _shortWinrateReportIsCopied.value = false;
         },0.8);
      }
      
      public function action_attackersDefendersOnly() : void
      {
         Clipboard.generalClipboard.setData("air:text",attackersDefendersReport);
         _attackersDefendersWinrateReportIsCopied.value = true;
         Starling.juggler.delayCall(function():*
         {
            _attackersDefendersWinrateReportIsCopied.value = false;
         },0.8);
      }
      
      public function action_toggleInterpreter(param1:Boolean) : void
      {
         BattleAssetStorage.USE_INTERPRETER = param1;
         AssetStorage.battle.requestAllCode();
      }
      
      public function action_selectHeroTab(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = undefined;
         var _loc3_:* = undefined;
         if(param1 >= 0 && param1 < HERO_TABS.length)
         {
            if(_selectedHeroTab.value != param1)
            {
               _selectedHeroTab.value = param1;
               if(param1 == 0)
               {
                  _configIndex = 0;
               }
               else if(param1 == 1)
               {
                  _configIndex = 1;
               }
               else if(param1 == 2)
               {
                  _configIndex = 3;
               }
               else if(param1 == 3)
               {
                  _configIndex = 4;
               }
               onConfigChanged.dispatch();
            }
            _loc2_ = null;
            if(param1 == 0)
            {
               _loc2_ = "hero";
            }
            else if(param1 == 1)
            {
               _loc2_ = "creep";
            }
            else if(param1 == 2)
            {
               _loc2_ = "boss";
            }
            else if(param1 == 3)
            {
               _loc2_ = "titan";
            }
            _loc4_ = new Vector.<UnitDescription>();
            _loc3_ = DataStorage.hero.getList();
            var _loc7_:int = 0;
            var _loc6_:* = _loc3_;
            for each(var _loc5_ in _loc3_)
            {
               if(_loc5_.unitType == _loc2_)
               {
                  _loc4_.push(_loc5_);
               }
            }
            leftTeam.setHeroes(_loc4_);
            rightTeam.setHeroes(_loc4_);
         }
      }
      
      public function action_selectBattleground(param1:BattleTestStatsBattlegroundValueObject) : void
      {
         var _loc2_:int = (battlegrounds.data as Vector.<BattleTestStatsBattlegroundValueObject>).indexOf(param1);
         _currentBattlegroundId = param1.id;
         onBattlegroundChanged.dispatch();
      }
      
      public function action_copyUrl() : void
      {
         var leftTeam:Vector.<int> = new Vector.<int>();
         var _loc3_:int = 0;
         var _loc2_:* = this.leftTeam.descriptionList;
         for each(desc in this.leftTeam.descriptionList)
         {
            leftTeam.push(desc.id);
         }
         var rightTeam:Vector.<int> = new Vector.<int>();
         var _loc5_:int = 0;
         var _loc4_:* = this.rightTeam.descriptionList;
         for each(desc in this.rightTeam.descriptionList)
         {
            rightTeam.push(desc.id);
         }
         var appUri:String = "https://vk.com/app4776548";
         var left:Vector.<int> = grade_left.toVector();
         var right:Vector.<int> = _gradeMode == 0?grade_left.toVector():grade_right.toVector();
         var setupUri:String = encodeUriSetupB(leftTeam,rightTeam,left,right,serializeParams());
         var url:String = appUri + GameModel.instance.context.platformFacade.urlParamsSeparator + "test_battle_setup" + "=" + setupUri;
         Clipboard.generalClipboard.setData("air:text",url);
         _urlIsCopied.value = true;
         Starling.juggler.delayCall(function():*
         {
            _urlIsCopied.value = false;
         },0.8);
      }
      
      public function action_macroTask() : void
      {
         var _loc2_:BattleConfig = DataStorage.battleConfig.getByName(configName);
         var _loc1_:BattleStatTaskExecutor = new BattleStatTaskExecutor(testSetup,grade_left,grade_right,_loc2_);
         var _loc3_:BattleStatTaskPopupMediator = new BattleStatTaskPopupMediator(player,_loc1_);
         _loc3_.open();
      }
      
      private function encodeUriSetup(param1:Object) : String
      {
         var _loc4_:String = JSON.stringify(param1);
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeUTF(_loc4_);
         _loc5_.compress();
         var _loc3_:String = Base64.encode(_loc5_);
         var _loc2_:String = encodeURIComponent(_loc3_);
         return _loc2_;
      }
      
      private function encodeUriSetupB(param1:Vector.<int>, param2:Vector.<int>, param3:Vector.<int>, param4:Vector.<int>, param5:Vector.<int>) : String
      {
         var _loc7_:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
         _loc7_.push(param1,param2,param3,param4,param5);
         var _loc9_:ByteArray = IntVectorByteArrayEncoder.encode(_loc7_);
         _loc9_.compress();
         var _loc8_:String = Base64.encode(_loc9_);
         var _loc6_:String = encodeURIComponent(_loc8_);
         return _loc6_;
      }
      
      private function decodeUriSetupB(param1:String) : Object
      {
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         try
         {
            _loc4_ = decodeURIComponent(param1);
            _loc8_ = Base64.decode(_loc4_);
            _loc8_.uncompress();
            _loc5_ = new Vector.<int>();
            _loc2_ = new Vector.<int>();
            _loc3_ = new Vector.<int>();
            _loc6_ = new Vector.<int>();
            _loc7_ = new Vector.<int>();
            IntVectorByteArrayEncoder.decode(new <Vector.<int>>[_loc5_,_loc2_,_loc3_,_loc6_,_loc7_],_loc8_);
            var _loc10_:* = {
               "leftTeam":_loc5_,
               "rightTeam":_loc2_,
               "left":_loc3_,
               "right":_loc6_,
               "params":_loc7_
            };
            return _loc10_;
         }
         catch(e:Error)
         {
            var _loc11_:* = null;
            return _loc11_;
         }
      }
      
      private function decodeUriSetup(param1:String) : Object
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         try
         {
            _loc2_ = decodeURIComponent(param1);
            _loc4_ = Base64.decode(_loc2_);
            _loc4_.uncompress();
            _loc3_ = _loc4_.readUTF();
            var _loc6_:* = JSON.parse(_loc3_);
            return _loc6_;
         }
         catch(e:Error)
         {
            var _loc7_:* = null;
            return _loc7_;
         }
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BattleTestStatsPopup(this);
         return _popup;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:BattleConfig = DataStorage.battleConfig.getByName(configName);
         testSetup.run(leftGrade,rightGrade,_loc2_);
      }
      
      protected function toggle() : void
      {
         enabled = !enabled;
         if(enabled)
         {
            BattleLog.doLog = false;
            Starling.juggler.add(this);
         }
         else
         {
            BattleLog.doLog = true;
            Starling.juggler.remove(this);
         }
         onStartButtonToggled.dispatch();
      }
      
      protected function dispatchHeroStats(param1:int, param2:BattleTestGradeModel) : void
      {
         var _loc5_:* = null;
         var _loc6_:int = param2.getUnitPower(param1);
         var _loc3_:String = "power: " + _loc6_;
         var _loc4_:String = String(param2.getUnitStats(param1,true));
         _loc3_ = _loc3_ + ("\n" + _loc4_);
         if(DataStorage.hero.getTitanById(param1))
         {
            _loc5_ = String(param2.getElementStats(param1));
            _loc3_ = _loc3_ + ("\n\n" + _loc5_);
         }
         onHeroStatsOutput.dispatch(_loc3_);
      }
      
      private function serializeParams() : Vector.<int>
      {
         return new <int>[_currentBattlegroundId,_gradeMode,!!_fillEmptySlots?1:0,_configIndex,_skinModeIndex,_selectedHeroTab.value,!!_doNotRandomRight.value?1:0,!!BattleAssetStorage.USE_INTERPRETER?1:0];
      }
      
      private function deserializeParams(param1:Vector.<int>) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = param1.length;
         if(_loc2_ > 0)
         {
            _currentBattlegroundId = param1[0];
         }
         if(_loc2_ > 1)
         {
            _gradeMode = param1[1];
         }
         if(_loc2_ > 2)
         {
            _fillEmptySlots = param1[2];
         }
         if(_loc2_ > 3)
         {
            _configIndex = param1[3];
         }
         if(_loc2_ > 4)
         {
            _skinModeIndex = param1[4];
         }
         if(_loc2_ > 5)
         {
            _selectedHeroTab.value = param1[5];
         }
         if(_loc2_ > 6)
         {
            _doNotRandomRight.value = param1[6] > 0?true:false;
         }
         if(_loc2_ > 7)
         {
            BattleAssetStorage.USE_INTERPRETER = param1[7];
         }
      }
      
      private function createTest(param1:String, param2:String, param3:String) : BattleData
      {
         var _loc6_:* = undefined;
         var _loc4_:* = JSON.parse(param2);
         if(param3)
         {
            _loc6_ = JSON.parse(param3);
         }
         var _loc5_:BattleData = new BattleData();
         _loc5_.parseRawDescription(_loc4_);
         if(_loc6_)
         {
            _loc5_.parseRawResult(_loc6_);
         }
         _loc5_.seed = int(param1);
         _loc5_.attackers.initialize(AssetStorage.battle.skillFactory);
         _loc5_.defenders.initialize(AssetStorage.battle.skillFactory);
         return _loc5_;
      }
      
      protected function onHeroPickedLeft(param1:UnitDescription) : void
      {
         dispatchHeroStats(param1.id,leftGrade);
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = leftTeam.descriptionList;
         for each(var _loc3_ in leftTeam.descriptionList)
         {
            _loc2_ = _loc2_ + leftGrade.getUnitPower(_loc3_.id);
         }
         _powerLeft.value = _loc2_;
      }
      
      protected function onHeroPickedRight(param1:UnitDescription) : void
      {
         dispatchHeroStats(param1.id,rightGrade);
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = rightTeam.descriptionList;
         for each(var _loc3_ in rightTeam.descriptionList)
         {
            _loc2_ = _loc2_ + rightGrade.getUnitPower(_loc3_.id);
         }
         _powerRight.value = _loc2_;
      }
      
      protected function handler_codeUpdated(param1:AssetLoader) : void
      {
         _codeIsRefreshing.value = false;
         _codeIsUpdated.value = testSetup.scriptsHashChanged;
      }
      
      protected function handler_updateGradeLevel(param1:int) : void
      {
         if(enabled)
         {
            action_clearResults();
         }
      }
   }
}

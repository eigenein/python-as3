package game.mediator.gui.popup.team
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.IntPropertyWriteable;
   import feathers.data.ListCollection;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.UnitEntry;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.popup.PopupBase;
   import game.view.popup.team.TeamGatherRSXPopup;
   import idv.cjcat.signals.Signal;
   
   public class TeamGatherPopupMediator extends PopupMediator
   {
      
      public static const MAX_TEAM_SIZE:int = 5;
      
      public static const HEROES_ON_THE_SCREEN:int = 20;
      
      public static const HEROES_IN_A_ROW:int = 5;
       
      
      protected const _currentTeamEmpty:BooleanPropertyWriteable = new BooleanPropertyWriteable();
      
      protected const _canComplete:BooleanPropertyWriteable = new BooleanPropertyWriteable();
      
      protected const _currentTeamPower:IntPropertyWriteable = new IntPropertyWriteable();
      
      public const currentTeamEmpty:BooleanProperty = _currentTeamEmpty;
      
      public const currentTeamPower:IntPropertyWriteable = _currentTeamPower;
      
      public const canComplete:BooleanProperty = _canComplete;
      
      public const signal_heroSelected:Signal = new Signal(TeamGatherPopupHeroValueObject,Number);
      
      public const signal_heroDeselected:Signal = new Signal(TeamGatherPopupHeroValueObject,Number);
      
      public const signal_teamUpdate:Signal = new Signal();
      
      public const signal_teamGatherCanceled:Signal = new Signal(TeamGatherPopupMediator);
      
      protected var _signal_teamGatherComplete:Signal;
      
      protected var _heroList:Vector.<TeamGatherPopupHeroValueObject>;
      
      public const heroList:ListCollection = new ListCollection();
      
      public const teamListDataProvider:ListCollection = new ListCollection();
      
      private var _startButtonLabel:String;
      
      public function TeamGatherPopupMediator(param1:Player, param2:Vector.<UnitDescription>)
      {
         _startButtonLabel = Translate.translate("UI_DIALOG_TEAM_GATHER_START");
         super(param1);
         _signal_teamGatherComplete = new Signal(TeamGatherPopupMediator);
         _heroList = createHeroList();
         heroList.data = _heroList;
         selectTeam(param2);
         updateSelection();
      }
      
      override protected function dispose() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get text_dialogCaption() : String
      {
         return Translate.translate("UI_TOWER_TEAM_GATHER_TITLE");
      }
      
      public function get maxTeamLength() : int
      {
         return 5;
      }
      
      public function get isEmptyTeam() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:int = teamListDataProvider.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = teamListDataProvider.getItemAt(_loc2_) as TeamGatherPopupHeroValueObject;
            if(!_loc3_.isEmpty)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function get emptyTeamString() : String
      {
         if(hasTitansToSelect && Translate.has("UI_DIALOG_TEAM_GATHER_TITAN_EMPTY"))
         {
            return Translate.translate("UI_DIALOG_TEAM_GATHER_TITAN_EMPTY");
         }
         return Translate.translate("UI_DIALOG_TEAM_GATHER_EMPTY");
      }
      
      public function get hasTitansToSelect() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:int = heroList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = heroList.getItemAt(_loc2_) as TeamGatherPopupHeroValueObject;
            if(_loc3_.desc.unitType == "hero")
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function get heroesSelected() : int
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get tutorialStartAction() : TutorialNode
      {
         return TutorialNavigator.ACTION_START_BATTLE;
      }
      
      public function get isFullTeamSelected() : Boolean
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get signal_teamGatherComplete() : Signal
      {
         return _signal_teamGatherComplete;
      }
      
      public function get playerEntryTeamList() : Vector.<PlayerHeroEntry>
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc5_:* = null;
         var _loc2_:Vector.<PlayerHeroEntry> = new Vector.<PlayerHeroEntry>();
         var _loc3_:int = teamListDataProvider.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = teamListDataProvider.getItemAt(_loc4_) as TeamGatherPopupHeroValueObject;
            if(_loc1_.desc)
            {
               _loc5_ = player.heroes.getById(_loc1_.desc.id);
               if(_loc5_)
               {
                  _loc2_.push(_loc5_);
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get playerUnitEntryTeamList() : Vector.<UnitEntry>
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc5_:* = null;
         var _loc2_:Vector.<UnitEntry> = new Vector.<UnitEntry>();
         var _loc3_:int = teamListDataProvider.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = teamListDataProvider.getItemAt(_loc4_) as TeamGatherPopupHeroValueObject;
            if(_loc1_.desc)
            {
               _loc5_ = UnitUtils.getPlayerUnitEntry(player,_loc1_.desc);
               if(_loc5_)
               {
                  _loc2_.push(_loc5_);
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get descriptionList() : Vector.<UnitDescription>
      {
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc3_:Vector.<UnitDescription> = new Vector.<UnitDescription>();
         var _loc1_:int = teamListDataProvider.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = (teamListDataProvider.getItemAt(_loc2_) as TeamGatherPopupHeroValueObject).desc;
            if(_loc4_)
            {
               _loc3_.push(_loc4_);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function get startButtonLabel() : String
      {
         return _startButtonLabel;
      }
      
      public function set startButtonLabel(param1:String) : void
      {
         _startButtonLabel = param1;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TEAM_GATHER;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TeamGatherRSXPopup(this);
         return _popup;
      }
      
      public function action_pick(param1:TeamGatherPopupHeroValueObject, param2:Number = 0.2) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function action_complete() : void
      {
         if(teamListDataProvider.length)
         {
            _signal_teamGatherComplete.dispatch(this);
            Tutorial.events.triggerEvent_teamSelectionCompleted();
         }
      }
      
      override public function close() : void
      {
         super.close();
         signal_teamGatherCanceled.dispatch(this);
      }
      
      protected function createHeroList() : Vector.<TeamGatherPopupHeroValueObject>
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:Vector.<TeamGatherPopupHeroValueObject> = new Vector.<TeamGatherPopupHeroValueObject>();
         var _loc2_:Vector.<UnitDescription> = getAllHeroes();
         var _loc7_:Vector.<TeamGatherPopupHeroValueObject> = new Vector.<TeamGatherPopupHeroValueObject>();
         var _loc1_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = createHeroValueObject(_loc2_[_loc3_]);
            if(_loc4_)
            {
               _loc5_.push(_loc4_);
            }
            _loc3_++;
         }
         var _loc6_:int = _loc5_.length;
         while(_loc6_ < 20 || _loc6_ % 5 > 0)
         {
            _loc5_.push(createEmptyHeroValueObject());
            _loc6_++;
         }
         _loc5_.sort(_sortVoVect);
         return _loc5_;
      }
      
      protected function getAllHeroes() : Vector.<UnitDescription>
      {
         return UnitUtils.heroVectorToUnitVector(DataStorage.hero.getPlayableHeroes());
      }
      
      public function isHeroUnavailable(param1:TeamGatherPopupHeroValueObject) : TeamGatherHeroBlockReason
      {
         return null;
      }
      
      protected function createHeroValueObject(param1:UnitDescription) : TeamGatherPopupHeroValueObject
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:PlayerHeroEntry = player.heroes.getById(param1.id);
         if(_loc4_)
         {
            _loc2_ = new TeamGatherPopupHeroValueObject(this,UnitEntryValueObject.create(param1,_loc4_));
            _loc3_ = isHeroUnavailable(_loc2_);
            if(_loc3_)
            {
               _loc2_.setUnavailable(_loc3_);
            }
            return _loc2_;
         }
         return null;
      }
      
      protected function createEmptyHeroValueObject() : TeamGatherPopupHeroValueObject
      {
         return new TeamGatherPopupHeroValueObject(this,null);
      }
      
      protected function selectTeam(param1:Vector.<UnitDescription>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:Vector.<TeamGatherPopupHeroValueObject> = new Vector.<TeamGatherPopupHeroValueObject>();
         var _loc5_:int = _heroList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc3_ = _heroList[_loc2_];
            if(param1 && param1.indexOf(_loc3_.desc) != -1)
            {
               _loc4_.push(_loc3_);
            }
            _loc2_++;
         }
         _loc4_.sort(TeamGatherPopupHeroValueObject.sortByBattleOrder);
         teamListDataProvider.data = _loc4_;
         _currentTeamEmpty.value = _loc4_.length == 0;
         updateCurrentTeamState();
      }
      
      protected function updateSelection() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<TeamGatherPopupHeroValueObject> = new Vector.<TeamGatherPopupHeroValueObject>();
         var _loc3_:Vector.<TeamGatherPopupHeroValueObject> = teamListDataProvider.data as Vector.<TeamGatherPopupHeroValueObject>;
         var _loc4_:int = _heroList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _heroList[_loc1_].selected = _loc3_.indexOf(_heroList[_loc1_]) != -1;
            _loc1_++;
         }
         if(isFullTeamSelected)
         {
            Tutorial.events.triggerEvent_fullTeamSelected();
         }
         else
         {
            Tutorial.events.triggerEvent_hasTeamToSelect();
         }
      }
      
      protected function updateHeroesList() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function updateCurrentTeamState() : void
      {
         _canComplete.value = !_currentTeamEmpty.value;
         _currentTeamPower.value = getCurrentTeamPower();
         adjustTeamLength();
      }
      
      protected function getCurrentTeamPower() : int
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function _sortVoVect(param1:TeamGatherPopupHeroValueObject, param2:TeamGatherPopupHeroValueObject) : int
      {
         var _loc4_:Number = int(!param1.isEmpty) * 1000000000 + int(param1.isAvailable) * 100000 + param1.power;
         var _loc3_:Number = int(!param2.isEmpty) * 1000000000 + int(param2.isAvailable) * 100000 + param2.power;
         return _loc3_ - _loc4_;
      }
      
      protected function _sortDescriptions(param1:UnitDescription, param2:UnitDescription) : int
      {
         return param1.battleOrder - param2.battleOrder;
      }
      
      protected function adjustTeamLength() : void
      {
         while(teamListDataProvider.length > maxTeamLength)
         {
            teamListDataProvider.removeItemAt(0);
         }
         while(teamListDataProvider.length < maxTeamLength)
         {
            teamListDataProvider.addItemAt(createEmptyHeroValueObject(),0);
         }
      }
   }
}

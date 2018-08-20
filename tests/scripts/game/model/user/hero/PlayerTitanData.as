package game.model.user.hero
{
   import battle.BattleStats;
   import com.progrestar.common.Logger;
   import engine.context.GameContext;
   import flash.utils.Dictionary;
   import game.data.reward.RewardTitan;
   import game.data.reward.RewardTitanExp;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.data.storage.level.TitanLevel;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.titan.TitanDescription;
   import game.model.user.Player;
   import game.model.user.hero.watch.PlayerTitanWatcher;
   import org.osflash.signals.Signal;
   
   public class PlayerTitanData
   {
       
      
      private var player:Player;
      
      private const logger:Logger = Logger.getLogger(PlayerTitanData);
      
      private const titansById:Dictionary = new Dictionary();
      
      private const spiritArtifactsById:Dictionary = new Dictionary();
      
      public const watcher:PlayerTitanWatcher = new PlayerTitanWatcher();
      
      private var _signal_newTitanObtained:Signal;
      
      private var _signal_titanEvolveStar:Signal;
      
      private var _signal_titanArtifactEvolveStar:Signal;
      
      private var _signal_titanArtifactLevelUp:Signal;
      
      private var _levelUpPotionDescription:ConsumableDescription;
      
      public function PlayerTitanData()
      {
         _signal_newTitanObtained = new Signal(PlayerTitanEntry);
         _signal_titanEvolveStar = new Signal(PlayerTitanEntry,BattleStats,int);
         _signal_titanArtifactEvolveStar = new Signal(PlayerTitanEntry,PlayerTitanArtifact);
         _signal_titanArtifactLevelUp = new Signal(PlayerTitanEntry,PlayerTitanArtifact);
         super();
      }
      
      public function get signal_newTitanObtained() : Signal
      {
         return _signal_newTitanObtained;
      }
      
      public function get signal_titanEvolveStar() : Signal
      {
         return _signal_titanEvolveStar;
      }
      
      public function get signal_titanArtifactEvolveStar() : Signal
      {
         return _signal_titanArtifactEvolveStar;
      }
      
      public function get signal_titanArtifactLevelUp() : Signal
      {
         return _signal_titanArtifactLevelUp;
      }
      
      public function get levelUpPotionDescription() : ConsumableDescription
      {
         var _loc1_:* = undefined;
         if(!_levelUpPotionDescription)
         {
            _loc1_ = DataStorage.consumable.getItemsByType("titanExperience");
            _levelUpPotionDescription = _loc1_[0];
         }
         return _levelUpPotionDescription;
      }
      
      public function init(param1:Object, param2:Object) : void
      {
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = param2;
         for each(var _loc5_ in param2)
         {
            _loc4_ = new PlayerTitanArtifact();
            _loc4_.desc = DataStorage.titanArtifact.getById(_loc5_.id) as TitanArtifactDescription;
            _loc4_.level = _loc5_.level;
            _loc4_.stars = _loc5_.star;
            spiritArtifactsById[_loc4_.desc.id] = _loc4_;
         }
         var _loc11_:int = 0;
         var _loc10_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc6_ = DataStorage.titan.getTitanById(_loc3_.id);
            _loc7_ = new PlayerTitanEntry(_loc6_,new PlayerTitanEntrySourceData(_loc3_),getSpiritArtifactById(_loc6_.spiritArtifact.id));
            titansById[_loc7_.id] = _loc7_;
         }
      }
      
      public function initWatcher(param1:Player) : void
      {
         this.player = param1;
         watcher.initialize(param1);
      }
      
      public function addRewardExp(param1:Vector.<RewardTitanExp>) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:* = null;
         var _loc2_:int = getMaxTitanExp();
         var _loc3_:int = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = param1[_loc5_].exp;
            _loc6_ = getById(param1[_loc5_].id);
            if(_loc6_.experience + _loc4_ > _loc2_)
            {
               _loc4_ = _loc2_ - _loc6_.experience;
            }
            _loc6_.addExp(_loc4_);
            _loc5_++;
         }
      }
      
      public function addRewardTitans(param1:Vector.<RewardTitan>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc2_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1[_loc4_].desc;
            _loc6_ = PlayerTitanEntrySourceData.createEmpty(_loc3_);
            _loc5_ = new PlayerTitanEntry(param1[_loc4_].desc,_loc6_,getSpiritArtifactById(_loc3_.spiritArtifact.id));
            titansById[_loc5_.id] = _loc5_;
            watcher.invalidate(_loc3_);
            _signal_newTitanObtained.dispatch(_loc5_);
            _loc4_++;
         }
      }
      
      public function getMaxTitanExp() : int
      {
         var _loc1_:TitanLevel = DataStorage.level.getTitanLevel(player.levelData.level.maxTitanLevel);
         if(_loc1_ && _loc1_.nextLevel)
         {
            return _loc1_.nextLevel.exp - 1;
         }
         return _loc1_.exp;
      }
      
      public function getById(param1:int) : PlayerTitanEntry
      {
         return titansById[param1];
      }
      
      public function getSpiritArtifactById(param1:int) : PlayerTitanArtifact
      {
         return spiritArtifactsById[param1];
      }
      
      public function getAmount() : int
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = titansById;
         for each(var _loc2_ in titansById)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function getList() : Vector.<PlayerTitanEntry>
      {
         var _loc1_:Vector.<PlayerTitanEntry> = new Vector.<PlayerTitanEntry>();
         var _loc4_:int = 0;
         var _loc3_:* = titansById;
         for each(var _loc2_ in titansById)
         {
            if(_loc2_.titan.isPlayable)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getFilteredList(param1:Function) : Vector.<PlayerTitanEntry>
      {
         var _loc2_:Vector.<PlayerTitanEntry> = new Vector.<PlayerTitanEntry>();
         var _loc5_:int = 0;
         var _loc4_:* = titansById;
         for each(var _loc3_ in titansById)
         {
            if(param1(_loc3_))
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function titanArtifactEvolveStar(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         param1.evolveArtifactStar(param2);
         _signal_titanArtifactEvolveStar.dispatch(param1,param2);
      }
      
      public function titanArtifactLevelUp(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         param1.levelUpArtifact(param2);
         _signal_titanArtifactLevelUp.dispatch(param1,param2);
      }
      
      public function titanSpiritArtifactEvolveStar(param1:PlayerTitanArtifact) : void
      {
         param1.evolve();
         _signal_titanArtifactEvolveStar.dispatch(null,param1);
      }
      
      public function titanSpiritArtifactLevelUp(param1:PlayerTitanArtifact) : void
      {
         param1.levelUp();
         _signal_titanArtifactLevelUp.dispatch(null,param1);
      }
      
      public function titanEvolveStar(param1:PlayerTitanEntry) : void
      {
         var _loc4_:int = param1.getPower();
         var _loc2_:BattleStats = param1.battleStats;
         var _loc3_:BattleStats = param1.battleStats;
         param1.evolveStar();
         watcher.invalidate(param1.titan as TitanDescription);
         logger.debug(param1.id,"promote color",JSON.stringify(param1.battleStats));
         _diff(_loc3_,param1.battleStats);
         _signal_titanEvolveStar.dispatch(param1,_loc2_,_loc4_);
      }
      
      private function _diff(param1:BattleStats, param2:BattleStats) : void
      {
         if(param1 == param2)
         {
            if(GameContext.instance.consoleEnabled)
            {
               throw "Same BattleStats should not be diffed";
            }
         }
         param1.multiply(-1);
         param1.add(param2);
         logger.debug("diff",JSON.stringify(param1));
      }
   }
}

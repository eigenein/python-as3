package game.model.user.arena
{
   import game.command.realtime.SocketClientEvent;
   import game.command.timer.AlarmEvent;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.arena.ArenaDescription;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.PlayerHeroEntry;
   import idv.cjcat.signals.Signal;
   
   public class PlayerArenaData
   {
      
      public static const TEAMS_COUNT:int = 1;
       
      
      protected var heroes:Vector.<Vector.<HeroDescription>>;
      
      protected var place:int;
      
      protected var battles:int;
      
      protected var wins:int;
      
      protected var player:Player;
      
      private var selectedEnemies:Vector.<PlayerArenaEnemy>;
      
      private var rewardFlag:Boolean;
      
      private var rewardTime:int;
      
      public const onEnemiesUpdate:Signal = new Signal();
      
      public const onDefendersUpdate:Signal = new Signal();
      
      public const onPlaceUpdate:Signal = new Signal();
      
      public const onNoMoreEnemiesAvailable:Signal = new Signal();
      
      private var _signal_rewardTimeAlarm:Signal;
      
      public function PlayerArenaData(param1:Player)
      {
         _signal_rewardTimeAlarm = new Signal();
         super();
         this.player = param1;
      }
      
      public static function hasHeroesToParticipateInArena(param1:Player) : Boolean
      {
         var _loc2_:Vector.<PlayerHeroEntry> = param1.heroes.getFilteredList(filter_availableForArena);
         return _loc2_ && _loc2_.length > 0;
      }
      
      public static function hasHeroesToParticipateInGrand(param1:Player) : Boolean
      {
         var _loc2_:Vector.<PlayerHeroEntry> = param1.heroes.getFilteredList(filter_availableForGrand);
         return _loc2_ && _loc2_.length > 0;
      }
      
      public static function filter_availableForArena(param1:PlayerHeroEntry) : Boolean
      {
         return param1 && param1.level.level >= MechanicStorage.ARENA.minHeroLevel;
      }
      
      public static function filter_availableForGrand(param1:PlayerHeroEntry) : Boolean
      {
         return param1 && param1.level.level >= MechanicStorage.GRAND.minHeroLevel;
      }
      
      public function get introduced() : Boolean
      {
         return place != 0;
      }
      
      public function get description() : ArenaDescription
      {
         return DataStorage.arena.arena;
      }
      
      public function get rankingIsLocked() : Boolean
      {
         return wins < DataStorage.rule.arenaRule.arenaRankingLockedWinCount && player.registrationTime > DataStorage.rule.arenaRule.arenaRankingLockedRegistrationTime;
      }
      
      public function get rankingIsLockedBattles() : int
      {
         return wins;
      }
      
      public function get rankingIsLockedBattlesLeft() : int
      {
         return DataStorage.rule.arenaRule.arenaRankingLockedWinCount - wins;
      }
      
      public function get rankingIsLockedUpToBattlesCount() : int
      {
         return DataStorage.rule.arenaRule.arenaRankingLockedWinCount;
      }
      
      public function get signal_rewardTimeAlarm() : Signal
      {
         return _signal_rewardTimeAlarm;
      }
      
      public function init(param1:*) : void
      {
         heroes = new Vector.<Vector.<HeroDescription>>(0);
         update(param1);
         GameModel.instance.actionManager.messageClient.subscribe("arenaPlaceChanged",onAsyncPlaceChanged);
      }
      
      public function update(param1:*) : void
      {
         place = param1.arenaPlace;
         battles = param1.battles;
         wins = param1.wins;
         onPlaceUpdate.dispatch();
         var _loc5_:* = new Vector.<HeroDescription>(0);
         heroes[0] = _loc5_;
         var _loc4_:* = _loc5_;
         var _loc7_:int = 0;
         var _loc6_:* = param1.arenaHeroes;
         for each(var _loc3_ in param1.arenaHeroes)
         {
            _loc4_.push(DataStorage.hero.getHeroById(_loc3_.id));
         }
         onDefendersUpdate.dispatch();
         rewardFlag = int(param1.rewardFlag) == 1;
         rewardTime = param1.rewardTime;
         var _loc2_:AlarmEvent = new AlarmEvent(rewardTime,"arenaRewardTime");
         _loc2_.callback = handler_arenaRewardTimeAlarm;
         GameTimer.instance.addAlarm(_loc2_);
      }
      
      public function getDefenders() : Vector.<Vector.<HeroDescription>>
      {
         return heroes;
      }
      
      public function getValidDefenders(param1:Player) : Vector.<HeroDescription>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function setDefenders(param1:Vector.<Vector.<HeroDescription>>) : void
      {
         if(!param1 || param1.length == 0)
         {
            return;
         }
         this.heroes = param1;
         onDefendersUpdate.dispatch();
      }
      
      public function getEnemies() : Vector.<PlayerArenaEnemy>
      {
         return selectedEnemies;
      }
      
      public function setEnemies(param1:Vector.<PlayerArenaEnemy>) : void
      {
         selectedEnemies = param1;
         onEnemiesUpdate.dispatch();
      }
      
      public function getPlace() : int
      {
         return place;
      }
      
      public function setPlace(param1:int) : void
      {
         place = param1;
         onPlaceUpdate.dispatch();
      }
      
      public function setBattles(param1:int, param2:int) : void
      {
         battles = param1;
         wins = param2;
      }
      
      public function setRewardFlag(param1:int) : void
      {
         rewardFlag = param1;
      }
      
      public function updateEnimiesAvailability(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = false;
         var _loc6_:int = 0;
         var _loc5_:* = selectedEnemies;
         for each(var _loc4_ in selectedEnemies)
         {
            _loc2_ = param1[_loc4_.id];
            if(!_loc3_)
            {
               _loc3_ = _loc2_;
            }
            if(_loc2_ != undefined)
            {
               _loc4_.setAvailability(_loc2_);
            }
         }
         if(!_loc3_)
         {
            onNoMoreEnemiesAvailable.dispatch();
         }
      }
      
      protected function getSocketEventArenaType() : String
      {
         return "arena";
      }
      
      protected function onAsyncPlaceChanged(param1:SocketClientEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = undefined;
         if(param1 && param1.data)
         {
            _loc3_ = param1.data.body.pushUserId;
            if(player.id != _loc3_)
            {
               return;
            }
            _loc2_ = param1.data.body;
            if(_loc2_ && _loc2_.place && _loc2_.type == getSocketEventArenaType())
            {
               setPlace(_loc2_.place);
            }
         }
      }
      
      protected function handler_arenaRewardTimeAlarm() : void
      {
         if(rewardFlag)
         {
            _signal_rewardTimeAlarm.dispatch();
            rewardFlag = false;
         }
      }
   }
}

package game.model.user.arena
{
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.arena.ArenaDescription;
   import game.data.storage.hero.HeroDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   import idv.cjcat.signals.Signal;
   
   public class PlayerGrandData extends PlayerArenaData
   {
      
      public static const TEAMS_COUNT:int = 3;
       
      
      public const onCoinsUpdate:Signal = new Signal();
      
      protected var coins:Number;
      
      protected var coinsLastUpdateTime:Number;
      
      public function PlayerGrandData(param1:Player)
      {
         super(param1);
      }
      
      override public function get description() : ArenaDescription
      {
         return DataStorage.arena.grand;
      }
      
      public function get currentCoins() : int
      {
         var _loc1_:Number = GameTimer.instance.currentServerTime;
         _loc1_ = _loc1_ - coinsLastUpdateTime;
         return coins + _loc1_ * coinsByHour / 3600;
      }
      
      public function get coinsByHour() : int
      {
         return DataStorage.arena.getRewardByPlace(place).grandHourlyReward;
      }
      
      override public function init(param1:*) : void
      {
         heroes = new Vector.<Vector.<HeroDescription>>(0);
         update(param1);
         GameModel.instance.actionManager.messageClient.subscribe("arenaPlaceChanged",onAsyncPlaceChanged);
      }
      
      override public function update(param1:*) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:* = undefined;
         place = param1.grandPlace;
         coins = param1.grandCoin;
         coinsLastUpdateTime = param1.grandCoinTime;
         onPlaceUpdate.dispatch();
         onCoinsUpdate.dispatch();
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            heroes[_loc3_] = new Vector.<HeroDescription>(0);
            _loc3_++;
         }
         if(param1.grandHeroes && param1.grandHeroes.length == 3)
         {
            _loc2_ = param1.grandHeroes.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc5_ = heroes[_loc3_];
               var _loc7_:int = 0;
               var _loc6_:* = param1.grandHeroes[_loc3_];
               for each(var _loc4_ in param1.grandHeroes[_loc3_])
               {
                  _loc5_.push(DataStorage.hero.getHeroById(_loc4_.id));
               }
               _loc3_++;
            }
            onDefendersUpdate.dispatch();
         }
      }
      
      public function updateCoins(param1:Number, param2:int) : void
      {
         coins = param1;
         coinsLastUpdateTime = param2;
         onCoinsUpdate.dispatch();
      }
      
      override protected function getSocketEventArenaType() : String
      {
         return "grand";
      }
   }
}

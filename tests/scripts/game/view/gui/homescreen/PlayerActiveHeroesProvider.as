package game.view.gui.homescreen
{
   import engine.core.assets.AssetLoader;
   import game.assets.HeroRsxAssetDisposable;
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.skin.SkinDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.hero.TitanEntry;
   import org.osflash.signals.Signal;
   
   public class PlayerActiveHeroesProvider
   {
       
      
      private var player:Player;
      
      private var count:int;
      
      private var getTitans:Boolean;
      
      private var samplingScale:Number;
      
      private var assets:Vector.<HeroRsxAssetDisposable>;
      
      private var heroes:Vector.<UnitDescription>;
      
      public const signal_updateHeroes:Signal = new Signal(Vector.<HeroRsxAssetDisposable>,Vector.<UnitDescription>);
      
      public function PlayerActiveHeroesProvider(param1:Boolean, param2:int, param3:Number = 1)
      {
         assets = new Vector.<HeroRsxAssetDisposable>();
         heroes = new Vector.<UnitDescription>();
         super();
         this.getTitans = param1;
         this.count = param2;
         this.samplingScale = param3;
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = assets;
         for each(var _loc1_ in assets)
         {
            _loc1_.dropUsage();
         }
         assets.length = 0;
         if(getTitans)
         {
            player.titans.signal_newTitanObtained.remove(handler_newTitanObtained);
         }
         else
         {
            player.arena.onDefendersUpdate.remove(handler_defendersUpdated);
            player.heroes.signal_newHeroObtained.remove(handler_newHeroObtained);
            player.heroes.signal_heroChangeSkin.remove(handler_heroChangeSkin);
         }
      }
      
      public function start(param1:Player) : void
      {
         this.player = param1;
         if(param1.isInited)
         {
            subscribe();
         }
         else
         {
            param1.signal_update.initSignal.addOnce(subscribe);
         }
      }
      
      public function restart() : void
      {
         updateActiveHeroes();
      }
      
      protected function subscribe() : void
      {
         if(getTitans)
         {
            player.titans.signal_newTitanObtained.add(handler_newTitanObtained);
         }
         else
         {
            player.arena.onDefendersUpdate.add(handler_defendersUpdated);
            player.heroes.signal_newHeroObtained.add(handler_newHeroObtained);
            player.heroes.signal_heroChangeSkin.add(handler_heroChangeSkin);
         }
         updateActiveHeroes();
      }
      
      protected function updateActiveHeroes() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function getChosenTitans() : Vector.<TitanEntry>
      {
         var _loc4_:Vector.<TitanEntry> = new Vector.<TitanEntry>();
         var _loc2_:Vector.<PlayerTitanEntry> = player.titans.getList();
         _loc2_.sort(PlayerTitanEntry.sort_byPower);
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _loc2_;
         for each(var _loc1_ in _loc2_)
         {
            _loc4_.push(_loc1_);
            _loc3_++;
            if(_loc3_ < count)
            {
               continue;
            }
            break;
         }
         return _loc4_;
      }
      
      protected function getChosenHeroes() : Vector.<PlayerHeroEntry>
      {
         var _loc3_:Vector.<PlayerHeroEntry> = new Vector.<PlayerHeroEntry>();
         var _loc4_:Vector.<HeroDescription> = player.arena.getValidDefenders(player);
         var _loc2_:int = 0;
         if(_loc4_ && _loc4_.length > 2)
         {
            var _loc7_:int = 0;
            var _loc6_:* = _loc4_;
            for each(var _loc1_ in _loc4_)
            {
               if(_loc1_ != null)
               {
                  _loc2_++;
                  _loc3_.push(player.heroes.getById(_loc1_.id));
               }
            }
         }
         if(_loc2_ < 3)
         {
            _loc3_.length = 0;
            _loc2_ = 0;
            var _loc9_:int = 0;
            var _loc8_:* = player.heroes.getList();
            for each(var _loc5_ in player.heroes.getList())
            {
               _loc3_.push(_loc5_);
               _loc2_++;
               if(_loc2_ < count)
               {
                  continue;
               }
               break;
            }
         }
         return _loc3_;
      }
      
      private function handler_assetsCompleted(param1:AssetLoader) : void
      {
         signal_updateHeroes.dispatch(assets.concat(),heroes);
      }
      
      private function handler_newTitanObtained(param1:PlayerTitanEntry) : void
      {
         updateActiveHeroes();
      }
      
      private function handler_defendersUpdated() : void
      {
         updateActiveHeroes();
      }
      
      private function handler_newHeroObtained(param1:PlayerHeroEntry) : void
      {
         updateActiveHeroes();
      }
      
      private function handler_heroChangeSkin(param1:PlayerHeroEntry, param2:SkinDescription) : void
      {
         updateActiveHeroes();
      }
   }
}

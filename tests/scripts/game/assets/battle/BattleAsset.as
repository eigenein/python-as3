package game.assets.battle
{
   import battle.BattleConfig;
   import battle.data.BattleData;
   import battle.data.BattleHeroDescription;
   import battle.data.BattleTeamDescription;
   import engine.context.GameContext;
   import engine.core.assets.AssetProvider;
   import flash.utils.Dictionary;
   import game.assets.HeroRsxAssetDisposable;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   import game.battle.view.hero.HeroClipAssetDataProvider;
   import game.battle.view.hero.IBattleSubsystem;
   import game.sound.MusicSource;
   
   public class BattleAsset extends BattleCodeAsset
   {
      
      private static const APPEAR_IN_ATTACKERS:int = 1;
      
      private static const APPEAR_IN_DEFENDERS:int = 2;
       
      
      private var sceneAsset:BattlegroundAsset;
      
      private var soundtrack:SoundtrackAsset;
      
      private var heroAssets:Dictionary;
      
      private var sameHeroUsage:Dictionary;
      
      private var crowdHeroAssets:Array;
      
      private var _subsystems:Vector.<IBattleSubsystem>;
      
      private var _battleConfig:BattleConfig;
      
      private var _playerIsAttacker:Boolean = true;
      
      private var _attackerIconDescription:BattlePlayerTeamIconDescription;
      
      private var _defenderIconDescription:BattlePlayerTeamIconDescription;
      
      public const commonAssets:Vector.<RsxGameAsset> = new Vector.<RsxGameAsset>();
      
      public const attackerSideTeam:BattleSideAsset = new BattleSideAsset();
      
      public const defenderSideTeam:BattleSideAsset = new BattleSideAsset();
      
      public function BattleAsset(param1:BattleData, param2:BattlegroundAsset, param3:BattleConfig)
      {
         crowdHeroAssets = [];
         _subsystems = new Vector.<IBattleSubsystem>();
         super(param1);
         this.sceneAsset = param2;
         this.sceneAsset.addUsage();
         this._battleConfig = param3;
         heroAssets = new Dictionary();
         sameHeroUsage = new Dictionary();
         commonAssets.push(AssetStorage.rsx.getByName("common_fx.rsx"));
      }
      
      public function dispose() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = crowdHeroAssets;
         for each(var _loc2_ in crowdHeroAssets)
         {
            _loc2_.dropUsage(true);
         }
         var _loc6_:int = 0;
         var _loc5_:* = heroAssets;
         for each(var _loc1_ in heroAssets)
         {
            _loc1_.dropUsage();
         }
         sceneAsset.dropUsage();
      }
      
      public function get battleConfig() : BattleConfig
      {
         return _battleConfig;
      }
      
      public function get playerBattleTeam() : BattleTeamDescription
      {
         return !!playerIsAttacker?battleData.attackers:battleData.defenders;
      }
      
      public function get playerIsAttacker() : Boolean
      {
         return _playerIsAttacker;
      }
      
      public function set playerIsAttacker(param1:Boolean) : void
      {
         _playerIsAttacker = param1;
      }
      
      public function get attackerIconDescription() : BattlePlayerTeamIconDescription
      {
         return _attackerIconDescription;
      }
      
      public function set attackerIconDescription(param1:BattlePlayerTeamIconDescription) : void
      {
         _attackerIconDescription = param1;
      }
      
      public function get defenderIconDescription() : BattlePlayerTeamIconDescription
      {
         return _defenderIconDescription;
      }
      
      public function set defenderIconDescription(param1:BattlePlayerTeamIconDescription) : void
      {
         _defenderIconDescription = param1;
      }
      
      public function addSubsystem(param1:IBattleSubsystem) : void
      {
         _subsystems.push(param1);
      }
      
      public function getSubsystems() : Vector.<IBattleSubsystem>
      {
         return _subsystems.concat();
      }
      
      public function getSceneAsset() : BattlegroundAsset
      {
         return sceneAsset;
      }
      
      public function getSoundtrack() : MusicSource
      {
         return !!soundtrack?soundtrack.music:null;
      }
      
      public function setSoundtrack(param1:SoundtrackAsset) : void
      {
         this.soundtrack = param1;
      }
      
      public function requestCommonFxAsset(param1:RsxGameAsset) : void
      {
         if(commonAssets.indexOf(param1) == -1)
         {
            commonAssets.push(param1);
         }
      }
      
      public function requestResampledHeroAsset(param1:int, param2:Number) : void
      {
         var _loc3_:* = null;
         if(!crowdHeroAssets[param1])
         {
            _loc3_ = AssetStorage.hero.getClipProvider(param1,0,param2);
            _loc3_.addUsage();
            crowdHeroAssets[param1] = _loc3_;
         }
      }
      
      override public function prepare(param1:AssetProvider) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _subsystems;
         for each(var _loc2_ in _subsystems)
         {
            _loc2_.requestAssets(this);
         }
         super.prepare(param1);
      }
      
      override protected function requestHero(param1:Array, param2:BattleHeroDescription, param3:int) : void
      {
         var _loc4_:* = null;
         super.requestHero(param1,param2,param3);
         if(!heroAssets[param2])
         {
            _loc4_ = AssetStorage.hero.getClipProvider(param2.heroId,param2.skin);
            sameHeroUsage[_loc4_] = int(sameHeroUsage[_loc4_]) | (param3 == 1?1:2);
            if(param3 != 1)
            {
               sameHeroUsage[param2] = true;
            }
            _loc4_.addUsage();
            heroAssets[param2] = _loc4_;
            param1.push(_loc4_);
            if(param2.element != null && param2.element.elementSpiritPower > 0)
            {
               requestCommonFxAsset(AssetStorage.rsx.getByName("common_artifact_titan.rsx"));
               var _loc5_:* = param2.element.element;
               if("fire" !== _loc5_)
               {
                  if("water" !== _loc5_)
                  {
                     if("earth" === _loc5_)
                     {
                        requestCommonFxAsset(AssetStorage.rsx.getByName("common_artifact_titan_earth.rsx"));
                     }
                  }
                  else
                  {
                     requestCommonFxAsset(AssetStorage.rsx.getByName("common_artifact_titan_water.rsx"));
                  }
               }
               else
               {
                  requestCommonFxAsset(AssetStorage.rsx.getByName("common_artifact_titan_fire.rsx"));
               }
            }
         }
      }
      
      override protected function get basicAssets() : Array
      {
         var _loc1_:Array = super.basicAssets;
         _loc1_.push(sceneAsset);
         if(soundtrack)
         {
            _loc1_.push(soundtrack);
         }
         var _loc5_:int = 0;
         var _loc4_:* = commonAssets;
         for each(var _loc2_ in commonAssets)
         {
            _loc1_.push(_loc2_);
         }
         var _loc7_:int = 0;
         var _loc6_:* = crowdHeroAssets;
         for each(var _loc3_ in crowdHeroAssets)
         {
            _loc1_.push(_loc3_);
         }
         return _loc1_;
      }
      
      public function getHeroAssetClipProvider(param1:BattleHeroDescription, param2:Number = 1, param3:String = null) : HeroClipAssetDataProvider
      {
         var _loc4_:Boolean = false;
         var _loc5_:HeroRsxAssetDisposable = getMostSuitableAsset(param1);
         if(_loc5_ && _loc5_.completed)
         {
            _loc4_ = sameHeroUsage[param1] && sameHeroUsage[_loc5_] == (1 | 2);
            return _loc5_.getHeroData(param2,param3,_loc4_);
         }
         return null;
      }
      
      public function getResampledHeroAsset(param1:int, param2:Number = 1, param3:String = null) : HeroClipAssetDataProvider
      {
         var _loc4_:HeroRsxAssetDisposable = crowdHeroAssets[param1] as HeroRsxAssetDisposable;
         if(_loc4_ && _loc4_.completed)
         {
            return _loc4_.getHeroData(param2,param3);
         }
         return null;
      }
      
      override public function complete() : void
      {
         super.complete();
         if(GameContext.instance.consoleEnabled)
         {
            var _loc3_:int = 0;
            var _loc2_:* = commonAssets;
            for each(var _loc1_ in commonAssets)
            {
               if(_loc1_.data == null)
               {
                  throw "rsx asset has not been loaded: " + _loc1_.ident;
               }
            }
         }
      }
      
      private function getMostSuitableAsset(param1:BattleHeroDescription) : HeroRsxAssetDisposable
      {
         var _loc2_:HeroRsxAssetDisposable = heroAssets[param1];
         if(_loc2_ == null)
         {
            if(param1.skin != 0)
            {
               var _loc5_:int = 0;
               var _loc4_:* = heroAssets;
               for(var _loc3_ in heroAssets)
               {
                  if(_loc3_.skin == param1.skin)
                  {
                     return heroAssets[_loc3_];
                  }
               }
            }
            else
            {
               var _loc7_:int = 0;
               var _loc6_:* = heroAssets;
               for(_loc3_ in heroAssets)
               {
                  if(_loc3_.heroId == param1.heroId && _loc3_.skin == 0)
                  {
                     return heroAssets[_loc3_];
                  }
               }
            }
            var _loc9_:int = 0;
            var _loc8_:* = heroAssets;
            for(_loc3_ in heroAssets)
            {
               if(_loc3_.heroId == param1.heroId)
               {
                  return heroAssets[_loc3_];
               }
            }
            var _loc11_:int = 0;
            var _loc10_:* = heroAssets;
            for each(_loc2_ in heroAssets)
            {
               return _loc2_;
            }
            throw new Error("Retrieving hero that was not loaded");
         }
         return _loc2_;
      }
   }
}

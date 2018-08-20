package game.mechanics.dungeon.popup.floor
{
   import engine.core.animation.ZSortedSprite;
   import engine.core.utils.property.IntPropertyWriteable;
   import flash.geom.Point;
   import game.assets.HeroRsxAssetDisposable;
   import game.assets.IHeroAsset;
   import game.assets.storage.AssetStorage;
   import game.battle.view.BattleScene;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mechanics.dungeon.mediator.DungeonFloorValueObject;
   import game.mechanics.dungeon.mediator.DungeonScreenState;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.view.hero.DungeonHeroTerrainHeight;
   import game.view.hero.FreeDungeonHero;
   import starling.animation.IAnimatable;
   import starling.animation.Juggler;
   import starling.display.DisplayObject;
   import starling.filters.BlurFilter;
   
   public class DungeonFloorTeamRenderer implements IAnimatable
   {
      
      private static var _point:Point = new Point();
       
      
      private var oneScreenTravelDistance:Number = 1300.0;
      
      private var state:DungeonScreenState;
      
      private var juggler:Juggler;
      
      private var scene:BattleScene;
      
      private var xPositionProperty:IntPropertyWriteable;
      
      private var currentHeroesSpawnPosition:Number;
      
      private var teamIndexCounter:int = 0;
      
      private var transitionIsProgress:Boolean = false;
      
      private var transitionSpeed:Number = 0;
      
      private var heroes:Vector.<FreeDungeonHero>;
      
      private var assets:Vector.<HeroRsxAssetDisposable>;
      
      private var ridersContainers:Vector.<DisplayObject>;
      
      private var terrainRight:DungeonHeroTerrainHeight;
      
      private var terrainLeft:DungeonHeroTerrainHeight;
      
      private var rightStairsBorder:Number;
      
      private var leftStairsBorder:Number;
      
      public function DungeonFloorTeamRenderer(param1:DungeonScreenState, param2:Juggler)
      {
         scene = new BattleScene();
         heroes = new Vector.<FreeDungeonHero>();
         assets = new Vector.<HeroRsxAssetDisposable>();
         ridersContainers = new Vector.<DisplayObject>();
         terrainRight = new DungeonHeroTerrainHeight();
         terrainLeft = new DungeonHeroTerrainHeight();
         super();
         this.state = param1;
         this.juggler = param2;
         param1.signal_startHeroTravel.add(handler_startHeroTravel);
         param1.signal_cheatTeleportHeroes.add(handler_cheatTeleportHeroes);
         param1.signal_prepareHeroesToMovement.add(handler_prepareHeroesToMovement);
         param1.signal_battleEnd.add(handler_battleEnd);
         var _loc4_:Number = getPositionByColumn(5 - 1) + 1000 + 5;
         var _loc3_:Number = getPositionByColumn(0) - 5;
         terrainLeft.mapPoints.push(new Point(_loc3_ - 120 - 400,360));
         terrainLeft.mapPoints.push(new Point(_loc3_ - 120,-40));
         terrainLeft.mapPoints.push(new Point(_loc3_ - 40,-40));
         terrainLeft.mapPoints.push(new Point(_loc3_,0));
         terrainLeft.mapPoints.push(new Point(_loc4_,0));
         terrainLeft.mapPoints.push(new Point(_loc4_ + 40,-40));
         terrainLeft.mapPoints.push(new Point(_loc4_ + 100,-40));
         terrainLeft.mapPoints.push(new Point(_loc4_ + 100 + 400,-440));
         terrainRight.mapPoints.push(new Point(_loc3_ - 100 - 400,-440));
         terrainRight.mapPoints.push(new Point(_loc3_ - 100,-40));
         terrainRight.mapPoints.push(new Point(_loc3_ - 40,-40));
         terrainRight.mapPoints.push(new Point(_loc3_,0));
         terrainRight.mapPoints.push(new Point(_loc4_,0));
         terrainRight.mapPoints.push(new Point(_loc4_ + 40,-40));
         terrainRight.mapPoints.push(new Point(_loc4_ + 120,-40));
         terrainRight.mapPoints.push(new Point(_loc4_ + 120 + 400,360));
         rightStairsBorder = _loc4_ + 120 + 140;
         leftStairsBorder = _loc3_ - 120 - 140;
      }
      
      public function dispose() : void
      {
         juggler.remove(this);
         var _loc5_:int = 0;
         var _loc4_:* = assets;
         for each(var _loc3_ in assets)
         {
            _loc3_.dropUsage(true);
         }
         assets.length = 0;
         var _loc7_:int = 0;
         var _loc6_:* = this.ridersContainers;
         for each(var _loc1_ in this.ridersContainers)
         {
            _loc1_.dispose();
         }
         this.ridersContainers.length = 0;
         if(scene)
         {
            scene.dispose();
            var _loc9_:int = 0;
            var _loc8_:* = heroes;
            for each(var _loc2_ in heroes)
            {
               _loc2_.dispose();
            }
         }
         state.signal_startHeroTravel.remove(handler_startHeroTravel);
         state.signal_cheatTeleportHeroes.remove(handler_cheatTeleportHeroes);
         state.signal_prepareHeroesToMovement.remove(handler_prepareHeroesToMovement);
      }
      
      protected function getPositionByColumn(param1:int) : Number
      {
         return param1 * oneScreenTravelDistance + 290;
      }
      
      public function start() : void
      {
         currentHeroesSpawnPosition = getPositionByColumn(state.columnIndex);
         state.addHeroes(state.rowVo,scene.graphics);
         setupHeroes(GameModel.instance.player);
         juggler.add(this);
      }
      
      public function advanceTime(param1:Number) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function getHeroTargetPosition(param1:FreeDungeonHero) : Point
      {
         var _loc2_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc3_:int = !!state.itemVo.rightExit?1:-1;
         _loc2_ = 500;
         _loc6_ = -150;
         var _loc4_:int = 5;
         var _loc5_:* = 60;
         _point.x = currentHeroesSpawnPosition + _loc2_ + _loc6_ * _loc3_ + (param1.teamIndex - 0.5 * _loc4_) * _loc3_ * _loc5_;
         _point.y = (param1.teamIndex % 2 - 0.5) * (!!param1.isTitan?40:17);
         return _point;
      }
      
      public function startTransition() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         transitionIsProgress = true;
         var _loc2_:* = 0;
         var _loc7_:* = 1;
         var _loc5_:DungeonFloorValueObject = state.itemVo;
         if(_loc5_.rightExit)
         {
            if(_loc5_.isLeftmost)
            {
               _loc2_ = Number(-600);
            }
         }
         else if(_loc5_.isRightmost)
         {
            _loc2_ = Number(600);
         }
         currentHeroesSpawnPosition = getPositionByColumn(state.columnIndex);
         var _loc6_:int = heroes.length;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc3_ = heroes[_loc4_];
            if(!_loc3_.isRider)
            {
               _loc1_ = getHeroTargetPosition(_loc3_);
               _loc3_.targetPosition(_loc1_.x + _loc2_,_loc1_.y * _loc7_);
            }
            _loc4_++;
         }
      }
      
      protected function updateHeroes() : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = this.heroes;
         for each(var _loc2_ in this.heroes)
         {
            _loc2_.dispose();
         }
         this.heroes.length = 0;
         var _loc7_:int = 0;
         var _loc6_:* = this.ridersContainers;
         for each(var _loc1_ in this.ridersContainers)
         {
            _loc1_.dispose();
         }
         this.ridersContainers.length = 0;
         teamIndexCounter = 0;
         AssetStorage.instance.globalLoader.cancelCallback(handler_titanLoaded);
         AssetStorage.instance.globalLoader.cancelCallback(handler_heroLoaded);
         var _loc9_:int = 0;
         var _loc8_:* = assets;
         for each(var _loc3_ in assets)
         {
            _loc3_.dropUsage(true);
         }
         assets.length = 0;
         setupHeroes(GameModel.instance.player);
      }
      
      protected function setupHeroes(param1:Player) : void
      {
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc5_:Vector.<UnitDescription> = param1.dungeon.getActiveTitans(param1);
         var _loc3_:Vector.<UnitDescription> = param1.dungeon.getActiveHeroes(param1);
         var _loc9_:int = 0;
         var _loc8_:* = _loc5_;
         for each(var _loc4_ in _loc5_)
         {
            _loc7_ = AssetStorage.hero.getClipProvider(_loc4_.id);
            _loc7_.addUsage();
            assets.push(_loc7_);
            AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc7_,handler_titanLoaded);
         }
         var _loc11_:int = 0;
         var _loc10_:* = _loc3_;
         for each(var _loc6_ in _loc3_)
         {
            _loc2_ = param1.heroes.getById(_loc6_.id);
            _loc7_ = AssetStorage.hero.getClipProvider(_loc2_.id,_loc2_.currentSkin,0.5);
            _loc7_.addUsage();
            assets.push(_loc7_);
            AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc7_,handler_heroLoaded);
         }
      }
      
      protected function addUnit(param1:IHeroAsset, param2:Boolean) : void
      {
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:FreeDungeonHero = new FreeDungeonHero(param2);
         _loc5_.view.position.size = !!param2?80:35;
         if(!param2)
         {
            _loc6_ = getFirstTitan();
            if(_loc6_)
            {
               _loc5_.isRider = true;
               _loc6_.isBusy = true;
            }
         }
         if(_loc5_.isRider)
         {
            _loc5_.init(param1,1 / 0.825);
            _loc5_.setPosition(0,0);
            _loc5_.view.position.direction = !!_loc6_.view.assetIsMirrored?-1:1;
            scene.addHeroView(null,_loc5_.view);
            _loc3_ = new ZSortedSprite();
            ridersContainers.push(_loc3_);
            _loc3_.filter = BlurFilter.createGlow(0,1.2,2,1);
            _loc5_.view.transform.setParent(_loc3_);
            _loc6_.view.setMarker("MARKER_CONTENT",_loc3_);
         }
         else
         {
            _loc5_.init(param1);
            teamIndexCounter = Number(teamIndexCounter) + 1;
            _loc5_.teamIndex = Number(teamIndexCounter);
            _loc4_ = getHeroTargetPosition(_loc5_);
            _loc5_.setPosition(_loc4_.x,_loc4_.y);
            _loc5_.view.position.direction = !!state.itemVo.rightExit?1:-1;
            _loc5_.terrain = !!state.itemVo.rightExit?terrainRight:terrainLeft;
            _loc5_.view.updatePosition();
            _loc5_.view.tweenShadowAlpha(0);
            scene.addHeroView(null,_loc5_.view);
            _loc5_.targetPosition(_loc5_.xTarget);
         }
         _loc5_.advanceTime(0);
         heroes.push(_loc5_);
      }
      
      private function handler_startHeroTravel() : void
      {
         startTransition();
      }
      
      private function handler_prepareHeroesToMovement() : void
      {
         var _loc2_:DungeonFloorValueObject = state.itemVo;
         var _loc1_:Boolean = _loc2_.rightExit && !_loc2_.isLeftmost || !_loc2_.rightExit && _loc2_.isRightmost;
         if(_loc1_)
         {
            var _loc5_:int = 0;
            var _loc4_:* = heroes;
            for each(var _loc3_ in heroes)
            {
               if(!_loc3_.isRider)
               {
                  _loc3_.position.x = _loc3_.xTarget + 320;
               }
            }
         }
         else
         {
            var _loc7_:int = 0;
            var _loc6_:* = heroes;
            for each(_loc3_ in heroes)
            {
               if(!_loc3_.isRider)
               {
                  _loc3_.position.x = _loc3_.xTarget - 320;
               }
            }
         }
         advanceSceneTimeToDisposeParticles();
      }
      
      private function advanceSceneTimeToDisposeParticles() : void
      {
         scene.advanceTime(3);
      }
      
      private function handler_battleEnd() : void
      {
         updateHeroes();
      }
      
      private function handler_cheatTeleportHeroes() : void
      {
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc9_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc4_:Number = NaN;
         advanceSceneTimeToDisposeParticles();
         state.addHeroes(state.rowVo,scene.graphics);
         if(state.itemVo.isRightmost && !state.itemVo.rightExit)
         {
            var _loc11_:int = 0;
            var _loc10_:* = heroes;
            for each(_loc7_ in heroes)
            {
               if(!_loc7_.isRider)
               {
                  _loc5_ = getHeroTargetPosition(_loc7_);
                  _loc7_.setPosition(_loc5_.x + 1000 * 0.6,_loc5_.y);
                  _loc7_.targetPosition(_loc5_.x,_loc5_.y);
                  _loc7_.advanceTime(0);
                  _loc7_.terrain = terrainLeft;
               }
            }
            scene.advanceTime(0);
            return;
         }
         if(state.itemVo.isLeftmost && state.itemVo.rightExit)
         {
            var _loc13_:int = 0;
            var _loc12_:* = heroes;
            for each(_loc7_ in heroes)
            {
               if(!_loc7_.isRider)
               {
                  _loc5_ = getHeroTargetPosition(_loc7_);
                  _loc7_.setPosition(_loc5_.x - 1000 * 0.6,_loc5_.y);
                  _loc7_.targetPosition(_loc5_.x,_loc5_.y);
                  _loc7_.advanceTime(0);
                  _loc7_.terrain = terrainRight;
               }
            }
            scene.advanceTime(0);
            return;
         }
         var _loc6_:* = Infinity;
         var _loc8_:* = -Infinity;
         var _loc15_:int = 0;
         var _loc14_:* = heroes;
         for each(_loc7_ in heroes)
         {
            if(!_loc7_.isRider)
            {
               _loc9_ = _loc7_.view.position.x - _loc7_.view.position.size * _loc7_.view.position.scale;
               _loc2_ = _loc7_.view.position.x + _loc7_.view.position.size * _loc7_.view.position.scale;
               if(_loc9_ < _loc6_)
               {
                  _loc6_ = _loc9_;
               }
               if(_loc2_ > _loc8_)
               {
                  _loc8_ = _loc2_;
               }
            }
         }
         scene.graphics.getBounds(scene.sortedContainer);
         var _loc3_:int = !!state.itemVo.rightExit?1:-1;
         var _loc1_:Number = currentHeroesSpawnPosition + 1000 * (0.5 - 0.5 * _loc3_);
         if(_loc3_ > 0)
         {
            _loc4_ = _loc1_ - _loc8_;
         }
         else
         {
            _loc4_ = _loc1_ - _loc6_;
         }
         var _loc17_:int = 0;
         var _loc16_:* = heroes;
         for each(_loc7_ in heroes)
         {
            if(!_loc7_.isRider)
            {
               _loc7_.position.x = _loc7_.position.x + _loc4_;
               _loc7_.advanceTime(0);
            }
         }
      }
      
      private function getFirstTitan() : FreeDungeonHero
      {
         var _loc3_:int = 0;
         var _loc2_:* = heroes;
         for each(var _loc1_ in heroes)
         {
            if(_loc1_.isTitan && !_loc1_.isBusy)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      protected function handler_titanLoaded(param1:IHeroAsset) : void
      {
         addUnit(param1,true);
      }
      
      protected function handler_heroLoaded(param1:IHeroAsset) : void
      {
         addUnit(param1,false);
      }
   }
}

package game.battle.view.hero.crowd
{
   import battle.BattleConfig;
   import battle.Team;
   import battle.logic.MovingBody;
   import battle.objects.BattleBody;
   import battle.proxy.displayEvents.BattleDisplayEvent;
   import battle.proxy.displayEvents.SmashGroundEvent;
   import flash.geom.Matrix;
   import game.assets.battle.BattleAsset;
   import game.battle.controller.position.BattleBodyEntry;
   import game.battle.controller.position.BattleBodyState;
   import game.battle.controller.position.BattleBodyViewPosition;
   import game.battle.view.EffectGraphicsProvider;
   import game.battle.view.animation.OnceEffectAnimationFactory;
   import game.battle.view.hero.AnimationIdent;
   import game.battle.view.hero.BattleContext;
   import game.battle.view.hero.HeroClipAssetDataProvider;
   import game.battle.view.hero.HeroView;
   import game.battle.view.hero.IBattleSubsystem;
   import game.data.storage.DataStorage;
   
   public class HeroCrowd implements IBattleSubsystem
   {
      
      public static const KNOCKUP_FX:String = "titan_smash_fly";
      
      public static const SMASH_FX:String = "titan_smash";
       
      
      private var context:BattleContext;
      
      private var completed:Boolean;
      
      private var spawnCooldown:Number = 0;
      
      private var groupSpawnCooldown:Number = 0;
      
      private var groupSpawnCounter:int = 0;
      
      private var groupSpawnAngle:Number = 0;
      
      private var battleConfig:BattleConfig;
      
      private var config:HeroCrowdSpawnConfig;
      
      private var count:int = 0;
      
      private var heroes:Vector.<CrowdHeroInstance>;
      
      private var heroesToRemove:Vector.<CrowdHeroInstance>;
      
      public function HeroCrowd(param1:HeroCrowdSpawnConfig)
      {
         battleConfig = DataStorage.battleConfig.core;
         heroes = new Vector.<CrowdHeroInstance>();
         heroesToRemove = new Vector.<CrowdHeroInstance>();
         super();
         this.config = param1;
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = heroes;
         for each(var _loc1_ in heroes)
         {
            _loc1_.view.dispose();
         }
      }
      
      public function requestAssets(param1:BattleAsset) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = config.heroes;
         for each(var _loc2_ in config.heroes)
         {
            param1.requestResampledHeroAsset(_loc2_,config.scale);
         }
      }
      
      public function startBattle(param1:BattleContext) : void
      {
         this.context = param1;
         param1.mediator.signal_displayEvent.add(handler_battleDisplayEvent);
      }
      
      public function cleanUpBattle() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = heroes;
         for each(var _loc1_ in heroes)
         {
            killAndDisposeHero(_loc1_,-config.direction);
         }
      }
      
      public function endBattle() : void
      {
         completed = true;
         context.mediator.signal_displayEvent.remove(handler_battleDisplayEvent);
         var _loc3_:int = 0;
         var _loc2_:* = heroes;
         for each(var _loc1_ in heroes)
         {
            _loc1_.view.stay();
         }
      }
      
      public function updateSpawnProcess(param1:Number) : void
      {
         var _loc2_:* = null;
         spawnCooldown = spawnCooldown + param1;
         groupSpawnCooldown = groupSpawnCooldown + param1;
         if(spawnCooldown > config.spawnCooldown && groupSpawnCooldown > config.groupSpawnCooldown && count < config.maxCount && groupSpawnCounter < config.groupSpawnCount)
         {
            if(groupSpawnCounter == 0 && config.spawnPositions != null && config.spawnPositions.length > 0)
            {
               _loc2_ = config.spawnPositions[0];
               groupSpawnAngle = Math.random() * (_loc2_.aMax - _loc2_.aMin - _loc2_.groupAngleDispersion * 2) + _loc2_.aMin + _loc2_.groupAngleDispersion;
            }
            if(spawnMob())
            {
               count = Number(count) + 1;
               spawnCooldown = 0;
               groupSpawnCounter = groupSpawnCounter + 1;
               if(groupSpawnCounter + 1 >= config.groupSpawnCount)
               {
                  groupSpawnCooldown = 2 * (Math.random() - 0.5) * config.groupSpawnCooldownDispersion;
                  groupSpawnCounter = Math.round(2 * (Math.random() - 0.5) * config.groupSpawnCountDispersion);
               }
            }
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc3_:* = null;
         var _loc4_:Number = NaN;
         var _loc2_:Number = NaN;
         if(!context.scene.canBattle)
         {
            return;
         }
         if(!completed)
         {
            updateSpawnProcess(param1);
         }
         param1 = param1 * 1.5;
         var _loc7_:int = 0;
         var _loc6_:* = heroes;
         for each(var _loc5_ in heroes)
         {
            _loc3_ = _loc5_.state;
            _loc5_.spawnHoldPositionDuration = _loc5_.spawnHoldPositionDuration - param1;
            if(!completed && _loc5_.hp > 0 && _loc5_.spawnHoldPositionDuration <= 0)
            {
               _loc3_.canMove = true;
               _loc3_.speed = config.scale * battleConfig.defaultHeroSpeed;
               _loc3_.target = _loc5_.team.enemyTeam.targetSelector.getNearestToPositionAbstract(_loc5_.body.body.x);
               if(_loc3_.target != null)
               {
                  _loc4_ = _loc3_.target.getVisualPosition();
                  _loc2_ = _loc4_ - _loc5_.body.body.x;
                  _loc3_.meleeTypeTargetingRange = _loc5_.attackRange + 50;
                  _loc5_.view.position.direction = _loc2_ > 0?1:-1;
               }
               else
               {
                  _loc3_.meleeTypeTargetingRange = -1;
                  _loc2_ = Infinity * _loc5_.team.direction;
                  _loc5_.view.position.direction = 0;
               }
               if(Math.abs(_loc2_) < _loc5_.attackRange)
               {
                  _loc5_.view.position.movement = 0;
                  if(!_loc5_.view.isAttacking)
                  {
                     _loc5_.view.setAnimation(AnimationIdent.ATTACK);
                  }
               }
               else
               {
                  _loc5_.body.body.x = _loc5_.body.body.x + _loc3_.speed * param1 * _loc5_.view.position.direction;
                  _loc5_.view.position.movement = 1;
               }
            }
            _loc5_.view.updatePosition();
         }
         if(heroesToRemove.length > 0)
         {
            removeOutdatedHeroes();
         }
      }
      
      protected function addSmashFx(param1:HeroView, param2:int) : void
      {
         var _loc5_:* = null;
         var _loc4_:EffectGraphicsProvider = context.fx.getCommonEffect("titan_smash_fly");
         if(!_loc4_ || _loc4_ == EffectGraphicsProvider.MISSING)
         {
            return;
         }
         var _loc3_:Matrix = new Matrix(param2,0,0,1);
         _loc5_ = OnceEffectAnimationFactory.factory(context.scene,_loc4_,_loc3_,0,null,false);
         _loc5_.createOnHero(param1);
         _loc4_ = context.fx.getCommonEffect("titan_smash");
         if(!_loc4_ || _loc4_ == EffectGraphicsProvider.MISSING)
         {
            return;
         }
         var _loc6_:Number = (0.25 + 0.75 * Math.random()) * config.scale;
         _loc3_ = new Matrix(param2 * _loc6_,0,0,_loc6_,param1.position.x,param1.position.y);
         _loc5_ = OnceEffectAnimationFactory.factory(context.scene,_loc4_,_loc3_,0,null,false);
         _loc5_.createOnScene(context.scene.sortedContainer,param1.position.z + param1.position.size + 1);
      }
      
      protected function createSpawnFx(param1:HeroView, param2:int) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:EffectGraphicsProvider = context.fx.getCommonEffect("dungeon_hero_spawn_fx");
         if(_loc4_ && _loc4_ != EffectGraphicsProvider.MISSING)
         {
            _loc3_ = new Matrix(param2 * config.scale,0,0,config.scale);
            _loc5_ = OnceEffectAnimationFactory.factory(context.scene,_loc4_,_loc3_,0,null,false);
            _loc5_.createOnHero(param1);
         }
      }
      
      protected function spawnMob() : Boolean
      {
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = config.heroes.length * Math.random();
         var _loc3_:int = config.heroes[_loc5_];
         var _loc9_:HeroClipAssetDataProvider = context.asset.getResampledHeroAsset(_loc3_,config.scale);
         if(_loc9_)
         {
            _loc2_ = new HeroView();
            _loc2_.applyAsset(_loc9_,true);
            _loc6_ = getSpawnPosition(config);
            _loc10_ = new BattleBody(null,new MovingBody(battleConfig.heroSize * config.scale));
            _loc10_.body.x = _loc6_.x;
            if(config.direction > 0)
            {
               _loc7_ = context.engine.objects.teams[0];
            }
            else
            {
               _loc7_ = context.engine.objects.teams[1];
            }
            _loc8_ = new BattleBodyState();
            _loc8_.mass = 0.01;
            _loc1_ = new BattleBodyEntry();
            _loc1_.body = _loc10_;
            _loc1_.team = _loc7_;
            _loc1_.view = _loc2_;
            _loc1_.size = 70;
            _loc1_.position = _loc6_;
            _loc1_.viewPosition = _loc2_.position;
            _loc1_.modelState = _loc8_;
            context.objects.addBodyEntry(_loc1_,true);
            _loc1_.view.updatePosition();
            context.scene.addHero(_loc2_);
            _loc4_ = new CrowdHeroInstance();
            _loc4_.body = _loc10_;
            _loc4_.view = _loc2_;
            _loc4_.state = _loc8_;
            _loc4_.team = _loc7_;
            _loc4_.hp = 5;
            _loc4_.attackRange = 50 + Math.random() * 100;
            _loc4_.signal_dispose.add(handler_heroRemoved);
            heroes.push(_loc4_);
            _loc4_.spawnHoldPositionDuration = 1.1;
            createSpawnFx(_loc4_.view,_loc7_.direction);
            return true;
         }
         return false;
      }
      
      protected function getSpawnPosition(param1:HeroCrowdSpawnConfig) : BattleBodyViewPosition
      {
         var _loc2_:* = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:BattleBodyViewPosition = new BattleBodyViewPosition();
         if(param1.spawnPositions != null && param1.spawnPositions.length > 0)
         {
            _loc2_ = param1.spawnPositions[0];
            _loc3_ = groupSpawnAngle + 2 * (Math.random() - 0.5) * _loc2_.groupAngleDispersion;
            _loc4_ = Math.random() * (_loc2_.rMax - _loc2_.rMin) + _loc2_.rMin;
            _loc5_.x = _loc2_.x + Math.cos(_loc3_) * _loc4_;
            _loc5_.y = _loc2_.y + Math.sin(_loc3_) * _loc4_ * 0.8;
            _loc5_.z = _loc5_.y;
         }
         else
         {
            _loc5_.x = param1.spawnX;
            _loc5_.y = Math.random() * 200 - 100;
            _loc5_.z = _loc5_.y;
         }
         return _loc5_;
      }
      
      private function damage(param1:CrowdHeroInstance, param2:int, param3:int) : void
      {
         param1.hp = param1.hp - param2;
         if(param1.hp <= 0)
         {
            killAndDisposeHero(param1,param3);
         }
      }
      
      private function removeOutdatedHeroes() : void
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = heroesToRemove;
         for each(var _loc2_ in heroesToRemove)
         {
            _loc1_ = heroes.indexOf(_loc2_);
            if(_loc1_ != -1)
            {
               heroes.splice(_loc1_,1);
            }
            count = Number(count) - 1;
         }
         heroesToRemove.length = 0;
      }
      
      private function smashGround(param1:Number, param2:Number, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = heroes;
         for each(var _loc4_ in heroes)
         {
            if(_loc4_.hp > 0 && Math.abs(_loc4_.view.position.x - param1) <= param2)
            {
               damage(_loc4_,10000,param3);
            }
         }
      }
      
      private function killAndDisposeHero(param1:CrowdHeroInstance, param2:int) : void
      {
         param1.view.signal_deathAnimationCompleted.add(param1.dispose);
         param1.view.die();
         param1.view.disableAndStopWhenCompleted();
         addSmashFx(param1.view,param2);
         param1.hp = 0;
      }
      
      private function handler_battleDisplayEvent(param1:BattleDisplayEvent) : void
      {
         var _loc2_:* = null;
         if(param1.type == SmashGroundEvent.TYPE)
         {
            _loc2_ = param1 as SmashGroundEvent;
            smashGround(_loc2_.x,_loc2_.r,_loc2_.direction);
         }
      }
      
      private function handler_heroRemoved(param1:CrowdHeroInstance) : void
      {
         heroesToRemove.push(param1);
         context.scene.removeHero(param1.view);
         param1.view.dispose();
      }
   }
}

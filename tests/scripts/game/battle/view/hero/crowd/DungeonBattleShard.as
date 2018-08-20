package game.battle.view.hero.crowd
{
   import battle.Team;
   import battle.logic.MovingBody;
   import battle.objects.BattleBody;
   import battle.proxy.ViewTransform;
   import flash.geom.Point;
   import game.assets.battle.BattleAsset;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   import game.battle.controller.position.BattleBodyEntry;
   import game.battle.controller.position.BattleBodyState;
   import game.battle.controller.position.BattleBodyViewPosition;
   import game.battle.controller.position.HeroViewPositionValue;
   import game.battle.view.EffectGraphicsProvider;
   import game.battle.view.animation.EffectAnimationSet;
   import game.battle.view.hero.BattleContext;
   import game.battle.view.hero.IBattleSubsystem;
   import starling.core.Starling;
   
   public class DungeonBattleShard implements IBattleSubsystem
   {
       
      
      private var shardFx:EffectAnimationSet;
      
      private var exploded:Boolean = false;
      
      private var finished:Boolean = false;
      
      private var clipBaseName:String;
      
      private var context:BattleContext;
      
      private var teamDirection:int;
      
      private var x:Number;
      
      private var y:Number;
      
      private var r:Number;
      
      private var victoryScreenCenterOffset:Number;
      
      private const commonFxAsset:RsxGameAsset = AssetStorage.rsx.getByName("common_dungeon_fx.rsx");
      
      public function DungeonBattleShard(param1:int, param2:Number, param3:Number, param4:Number, param5:String, param6:Number)
      {
         super();
         this.teamDirection = param1;
         this.x = param2;
         this.y = param3;
         this.r = param4;
         this.clipBaseName = param5;
         this.victoryScreenCenterOffset = param6;
      }
      
      public function dispose() : void
      {
      }
      
      public function requestAssets(param1:BattleAsset) : void
      {
         param1.requestCommonFxAsset(commonFxAsset);
      }
      
      public function advanceTime(param1:Number) : void
      {
         if(!finished)
         {
            shardFx.advanceTime(param1);
            if(exploded && shardFx.completed)
            {
               shardFx.setTime(shardFx.duration - 1 / 60);
               shardFx.advanceTime(0);
               finished = true;
            }
         }
      }
      
      public function startBattle(param1:BattleContext) : void
      {
         this.context = param1;
         createShard(teamDirection,x,y,r);
      }
      
      public function endBattle() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:* = null;
         context.scene.camera.doTrackHeroes = false;
         if(context.parent.hasWinner && context.parent.attackersWon)
         {
            _loc1_ = Starling.current.stage.stageWidth * 0.5 + victoryScreenCenterOffset;
            _loc2_ = context.scene.battlegroundController.battlePosition.clone();
            _loc2_.x = _loc2_.x + x - _loc1_;
            context.scene.camera.moveToPosition(_loc2_,1,1);
            crystalExplosionAnimation();
         }
      }
      
      public function cleanUpBattle() : void
      {
      }
      
      protected function crystalExplosionAnimation() : void
      {
         var _loc1_:EffectGraphicsProvider = context.fx.getCommonEffect(clipBaseName + "_explosion_animation");
         if(!_loc1_ || _loc1_ == EffectGraphicsProvider.MISSING)
         {
            return;
         }
         shardFx.setGraphics(_loc1_);
         shardFx.setTime(0);
         exploded = true;
      }
      
      protected function createShard(param1:int, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc10_:* = null;
         var _loc8_:* = null;
         var _loc7_:EffectGraphicsProvider = context.fx.getCommonEffect(clipBaseName + "_idle_animation");
         if(!_loc7_ || _loc7_ == EffectGraphicsProvider.MISSING)
         {
            return;
         }
         shardFx = new EffectAnimationSet();
         shardFx.setGraphics(_loc7_);
         shardFx.targetSpace = context.scene.animationTarget;
         var _loc6_:ViewTransform = new ViewTransform();
         _loc6_.a = param1;
         _loc6_.d = 1;
         _loc6_.tx = param2;
         _loc6_.ty = param3;
         _loc6_.tz = 0;
         shardFx.setTransform(_loc6_);
         if(teamDirection > 0)
         {
            _loc8_ = context.engine.objects.teams[0];
         }
         else
         {
            _loc8_ = context.engine.objects.teams[1];
         }
         var _loc9_:BattleBodyState = new BattleBodyState(10000000);
         _loc9_.mass = 100;
         _loc9_.canMove = false;
         _loc9_.speed = 0;
         _loc9_.size = param4 / 25;
         var _loc5_:BattleBodyEntry = new BattleBodyEntry();
         _loc5_.size = 70;
         _loc5_.body = new BattleBody(null,new MovingBody(param4));
         _loc5_.team = _loc8_;
         _loc5_.position = new BattleBodyViewPosition(param2,param3,param3);
         _loc5_.viewPosition = new HeroViewPositionValue();
         _loc5_.modelState = _loc9_;
         _loc5_.body.body.x = _loc5_.position.x;
         context.objects.addBodyEntry(_loc5_,true);
      }
   }
}

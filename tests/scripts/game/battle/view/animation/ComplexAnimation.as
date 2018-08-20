package game.battle.view.animation
{
   import battle.BattleEngine;
   import battle.data.BattleSkillDescription;
   import battle.proxy.ViewTransform;
   import battle.proxy.ViewTransformProvider;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.battle.controller.BattleMediatorObjects;
   import game.battle.gui.BattleHpBarClip;
   import game.battle.view.BattleGraphicsMethodProvider;
   import game.battle.view.EffectGraphicsProvider;
   import game.battle.view.systems.IBattleDisposable;
   import org.osflash.signals.Signal;
   
   public class ComplexAnimation implements IBattleFadableAnimation, IBattleDisposable
   {
       
      
      private const animations:EffectAnimationSet = new EffectAnimationSet();
      
      private var transformProvider:ViewTransformProvider;
      
      private var playingOnce:Boolean;
      
      private var defaultFx:EffectGraphicsProvider;
      
      private var graphics:BattleGraphicsMethodProvider;
      
      private var bar:BattleHpBarClip;
      
      private var skill:BattleSkillDescription;
      
      private var switchedOnce:Boolean;
      
      private const _signal_dispose:Signal = new Signal();
      
      public function ComplexAnimation(param1:EffectGraphicsProvider, param2:ViewTransformProvider, param3:BattleMediatorObjects, param4:BattleGraphicsMethodProvider, param5:BattleSkillDescription)
      {
         super();
         this.transformProvider = param2;
         this.defaultFx = param1;
         var _loc7_:Rectangle = null;
         animations.setGraphics(param1);
         animations.targetSpace = param4.getGlobalAnimationTarget();
         if(animations.frontAnimation)
         {
            animations.frontAnimation.advanceTime(0);
            _loc7_ = animations.frontAnimation.graphics.getBounds(animations.frontAnimation.graphics);
         }
         else if(animations.backAnimation)
         {
            animations.backAnimation.advanceTime(0);
            _loc7_ = animations.backAnimation.graphics.getBounds(animations.backAnimation.graphics);
         }
         if(_loc7_)
         {
            _loc7_.x = _loc7_.x / BattleEngine.ASSET_SCALE;
            _loc7_.y = _loc7_.y / BattleEngine.ASSET_SCALE;
            _loc7_.width = _loc7_.width / BattleEngine.ASSET_SCALE;
            _loc7_.height = _loc7_.height / BattleEngine.ASSET_SCALE;
         }
         param2.init(_loc7_);
         var _loc6_:ViewTransform = param2.getTransform();
         if(_loc6_)
         {
            animations.setTransform(_loc6_);
         }
         animations.advanceTime(0);
         if(param2.hasProgress())
         {
            bar = AssetStorage.rsx.battle_interface.create_battleBarYellow();
            bar.defineMaxValue(1);
            bar.x = -(int(bar.width * 0.5));
            param4.getGlobalAnimationTarget().addChild(bar);
         }
         playingOnce = !param2.hasDefinedDuration();
         this.graphics = param4;
         this.skill = param5;
      }
      
      public function dispose() : void
      {
         if(!transformProvider)
         {
            return;
         }
         animations.dispose();
         if(bar)
         {
            bar.removeFromParent();
            bar.dispose();
            bar = null;
         }
         transformProvider = null;
         _signal_dispose.dispatch();
      }
      
      public function get signal_dispose() : Signal
      {
         return _signal_dispose;
      }
      
      public function set alpha(param1:Number) : void
      {
         animations.alpha = param1;
         if(bar)
         {
            bar.alpha;
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc4_:* = null;
         var _loc2_:ViewTransform = transformProvider.getTransform();
         if(!_loc2_)
         {
            dispose();
            return;
         }
         if(transformProvider.switchAsset != null)
         {
            _loc4_ = graphics.getHeroEffect(skill.tier,transformProvider.switchAsset,skill.hero);
            if(_loc4_ == EffectGraphicsProvider.MISSING)
            {
               _loc4_ = graphics.getCommonEffect(transformProvider.switchAsset);
            }
            animations.setGraphics(_loc4_);
            defaultFx = _loc4_;
            transformProvider.switchAsset = null;
         }
         if(transformProvider.playOnce != null)
         {
            _loc4_ = graphics.getHeroEffect(skill.tier,transformProvider.playOnce,skill.hero);
            if(_loc4_ != EffectGraphicsProvider.MISSING)
            {
               animations.setGraphics(_loc4_);
               animations.setTime(0);
               switchedOnce = true;
            }
            transformProvider.playOnce = null;
         }
         if(transformProvider.setTime >= 0)
         {
            animations.setTime(transformProvider.setTime);
            transformProvider.setTime = -1;
         }
         if(transformProvider.setPlayingOnce)
         {
            playingOnce = true;
            transformProvider.setPlayingOnce = false;
         }
         animations.setTransform(_loc2_);
         var _loc5_:BattleFx = animations.frontAnimation;
         if(_loc5_)
         {
            _loc5_.selfOffsetZ = _loc2_.tz;
         }
         var _loc3_:BattleFx = animations.backAnimation;
         if(_loc3_)
         {
            _loc3_.selfOffsetZ = _loc2_.tz - transformProvider.zBackOffset;
         }
         animations.advanceTime(param1);
         if(bar != null)
         {
            bar.x = _loc2_.tx - int(bar.width * 0.5);
            bar.y = _loc2_.ty - 50;
            bar.setValue(transformProvider.getProgress(),1);
            bar.advanceTime(param1);
         }
         if(animations.completed)
         {
            if(playingOnce)
            {
               dispose();
            }
            else if(switchedOnce)
            {
               animations.setTime(0);
               animations.setGraphics(defaultFx);
               switchedOnce = false;
            }
         }
      }
   }
}

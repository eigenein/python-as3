package game.battle.view.hero
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Container;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.animation.DisposableAnimation;
   import engine.core.utils.MatrixUtil;
   import flash.geom.Matrix;
   import game.battle.controller.position.HeroViewPositionValue;
   import game.battle.view.BattleScene;
   import game.battle.view.EffectGraphicsProvider;
   import game.battle.view.animation.OnceEffectAnimationFactory;
   
   public class BattleAnimationParticleEmitter extends DisposableAnimation
   {
      
      public static const FRONT_FX_NAME:String = "permanent_emitter";
      
      public static const BACK_FX_NAME:String = "permanent_emitter_back";
      
      public static const FRONT_MARKER_FX_NAME:String = "permanent_marker_emitter";
      
      public static const BACK_MARKER_FX_NAME:String = "permanent_marker_emitter_back";
      
      public static const MARKER_EMITTER:String = "MARKER_EMITTER";
      
      public static const MARKER_EMITTER_TRANSFORM:String = "MARKER_EMITTER_TRANSFORM";
       
      
      private var asset:HeroClipAssetDataProvider;
      
      private var scene:BattleScene;
      
      private var targetHero:HeroView;
      
      private var entries:Vector.<BattleAnimationPartileEmitterEntry>;
      
      private var assetXScale:Number = 1;
      
      private var assetYScale:Number = 1;
      
      public var doEmmit:Boolean = true;
      
      public function BattleAnimationParticleEmitter(param1:HeroView, param2:HeroClipAssetDataProvider)
      {
         var _loc3_:* = null;
         entries = new Vector.<BattleAnimationPartileEmitterEntry>();
         super();
         this.targetHero = param1;
         this.asset = param2;
         this.assetYScale = param2.defaultScale;
         this.assetXScale = !!param2.mirrored?-assetYScale:Number(assetYScale);
         _loc3_ = param2.getClipByName("permanent_emitter");
         if(_loc3_)
         {
            entries.push(new BattleAnimationPartileEmitterEntry(_loc3_,0,false));
         }
         _loc3_ = param2.getClipByName("permanent_emitter_back");
         if(_loc3_)
         {
            entries.push(new BattleAnimationPartileEmitterEntry(_loc3_,-1,false));
         }
         _loc3_ = param2.getClipByName("permanent_marker_emitter");
         if(_loc3_)
         {
            entries.push(new BattleAnimationPartileEmitterEntry(_loc3_,0,true));
         }
         _loc3_ = param2.getClipByName("permanent_marker_emitter_back");
         if(_loc3_)
         {
            entries.push(new BattleAnimationPartileEmitterEntry(_loc3_,-1,true));
         }
      }
      
      public static function assetHasFx(param1:HeroClipAssetDataProvider) : Boolean
      {
         if(param1.getClipByName("permanent_emitter"))
         {
            return true;
         }
         if(param1.getClipByName("permanent_emitter_back"))
         {
            return true;
         }
         if(param1.getClipByName("permanent_marker_emitter"))
         {
            return true;
         }
         if(param1.getClipByName("permanent_marker_emitter_back"))
         {
            return true;
         }
         return false;
      }
      
      public function setScene(param1:BattleScene) : void
      {
         this.scene = param1;
      }
      
      override public function advanceTime(param1:Number) : void
      {
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         if(targetHero == null || scene == null)
         {
            return;
         }
         var _loc8_:int = 0;
         var _loc7_:* = entries;
         for each(var _loc3_ in entries)
         {
            _loc3_.currentTime = _loc3_.currentTime + param1 * 60;
            if(_loc3_.currentTime > 10000000000)
            {
               _loc3_.currentTime = _loc3_.currentTime - 10000000000;
            }
            _loc2_ = uint(_loc3_.clip.timeLine.length);
            if(_loc3_.currentTime >= 0)
            {
               _loc5_ = int(_loc3_.currentTime) % _loc3_.length;
            }
            else
            {
               _loc5_ = _loc3_.length + (int(_loc3_.currentTime + 1)) % _loc3_.length - 1;
            }
            if(doEmmit)
            {
               if(_loc3_.currentFrame <= _loc5_)
               {
                  _loc4_ = _loc3_.currentFrame + 1;
                  while(_loc4_ <= _loc5_)
                  {
                     addParticlesFromFrame(_loc3_,_loc4_);
                     _loc4_++;
                  }
               }
               else
               {
                  _loc6_ = _loc3_.length;
                  _loc4_ = _loc3_.currentFrame + 1;
                  while(_loc4_ < _loc6_)
                  {
                     addParticlesFromFrame(_loc3_,_loc4_);
                     _loc4_++;
                  }
                  _loc4_ = 0;
                  while(_loc4_ <= _loc5_)
                  {
                     addParticlesFromFrame(_loc3_,_loc4_);
                     _loc4_++;
                  }
               }
            }
            _loc3_.currentFrame = _loc5_;
         }
      }
      
      protected function addParticlesFromFrame(param1:BattleAnimationPartileEmitterEntry, param2:int) : void
      {
         var _loc10_:* = null;
         var _loc9_:* = null;
         var _loc13_:* = null;
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc12_:Number = NaN;
         var _loc11_:* = null;
         var _loc6_:* = NaN;
         var _loc5_:* = null;
         var _loc3_:Container = param1.clip.timeLine[param2] as Container;
         if(_loc3_ != null)
         {
            var _loc15_:int = 0;
            var _loc14_:* = _loc3_.nodes;
            for each(var _loc7_ in _loc3_.nodes)
            {
               _loc10_ = new EffectGraphicsProvider(asset,null);
               _loc10_.front = _loc7_.clip;
               _loc9_ = targetHero.position;
               _loc13_ = targetHero.getMarkerPosition("MARKER_EMITTER_TRANSFORM",true);
               if(_loc13_)
               {
                  _loc8_ = _loc13_;
               }
               else
               {
                  _loc8_ = new Matrix(_loc9_.direction * _loc9_.scale,0,0,assetYScale * _loc9_.scale,_loc9_.x,_loc9_.y);
                  _loc4_ = targetHero.getMarkerPosition("MARKER_EMITTER",true);
                  if(_loc4_)
                  {
                     _loc8_.tx = _loc4_.tx;
                     _loc8_.ty = _loc4_.ty;
                  }
                  else if(param1.needMarker)
                  {
                     return;
                  }
               }
               MatrixUtil.concatInPlaceRight(_loc8_,_loc7_.state.matrix);
               _loc12_ = param1.z * (5 + targetHero.position.size);
               _loc11_ = _loc7_.state.name;
               if(_loc11_.charCodeAt(0) == 122)
               {
                  if(_loc11_.charCodeAt(1) == 95)
                  {
                     _loc12_ = _loc12_ - _loc11_.slice(2);
                  }
                  else
                  {
                     _loc12_ = _loc12_ + Number(_loc11_.slice(1));
                  }
               }
               _loc6_ = 0;
               _loc5_ = OnceEffectAnimationFactory.factory(scene,_loc10_,_loc8_,0,null,false);
               _loc5_.createOnScene(scene.sortedContainer,_loc12_ - 10);
            }
         }
      }
   }
}

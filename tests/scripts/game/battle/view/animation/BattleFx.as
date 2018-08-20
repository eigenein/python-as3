package game.battle.view.animation
{
   import battle.proxy.ViewTransform;
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.starling.ClipSkin;
   import engine.core.animation.Animation;
   import engine.core.animation.ZSortedSprite;
   import flash.geom.Matrix;
   import game.battle.view.hero.HeroView;
   import game.battle.view.systems.IBattleDisposable;
   import org.osflash.signals.Signal;
   
   public class BattleFx extends Animation implements IBattleDisposable
   {
      
      private static const _identityMatrix:Matrix = new Matrix();
       
      
      protected var _playOnce:Boolean;
      
      private var _targetHero:HeroView;
      
      private var _skin:ClipSkin;
      
      protected var _loop:Clip;
      
      private var _rootSprite:ZSortedSprite;
      
      private var _matrixInvalidated:Boolean = false;
      
      private var _assetTransform:Matrix;
      
      private var _selfTransform:ViewTransform;
      
      protected const _assetAndSelfTransform:Matrix = new Matrix();
      
      private var _selfOffsetZ:Number;
      
      private var _alpha:Number = 1;
      
      private var _signal_dispose:Signal;
      
      public function BattleFx(param1:Boolean = false, param2:Number = 0)
      {
         super(null,new Matrix(),0);
         this._playOnce = param1;
         this._rootSprite = rootNode.graphics as ZSortedSprite;
         this._selfOffsetZ = param2;
         state.colorMode = 1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_signal_dispose)
         {
            _signal_dispose.dispatch();
            _signal_dispose.removeAll();
         }
      }
      
      public function get signal_dispose() : Signal
      {
         if(!_signal_dispose)
         {
            _signal_dispose = new Signal();
         }
         return _signal_dispose;
      }
      
      override public function get graphics() : ZSortedSprite
      {
         return _rootSprite;
      }
      
      public function set skin(param1:ClipSkin) : void
      {
         if(param1 == _skin)
         {
            return;
         }
         _skin = param1;
         rootClip = param1.clip;
         _loop = null;
         events = null;
         playSoundsToEvent();
      }
      
      public function set clip(param1:Clip) : void
      {
         if(param1 == rootClip)
         {
            return;
         }
         rootClip = param1;
         _loop = null;
         events = null;
         playSoundsToEvent();
      }
      
      public function set loop(param1:Clip) : void
      {
         _loop = param1;
      }
      
      public function set targetHero(param1:HeroView) : void
      {
         _targetHero = param1;
         param1.transform.parent.addChild(_rootSprite);
      }
      
      public function set targetSpace(param1:ZSortedSprite) : void
      {
         _targetHero = null;
         param1.addChild(_rootSprite);
      }
      
      public function set assetTransform(param1:Matrix) : void
      {
         _assetTransform = param1;
         concatMatrices(_assetTransform,_selfTransform,_assetAndSelfTransform);
      }
      
      public function set selfTransform(param1:ViewTransform) : void
      {
         _selfTransform = param1;
         concatMatrices(_assetTransform,_selfTransform,_assetAndSelfTransform);
      }
      
      public function set selfOffsetZ(param1:Number) : void
      {
         _selfOffsetZ = param1;
      }
      
      public function get alpha() : Number
      {
         return _alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         _alpha = param1;
      }
      
      override public function setFrame(param1:int) : void
      {
         currentTime = param1;
         if(rootClip)
         {
            rootNode.setup(rootClip,state,currentTime,null,_skin);
            if(events)
            {
               events.skipTo(param1);
            }
         }
      }
      
      override public function advanceTime(param1:Number) : void
      {
         currentTime = currentTime + param1 * 60;
         if(currentTime > 10000000000)
         {
            currentTime = currentTime - 10000000000;
         }
         if(rootClip)
         {
            if(_targetHero)
            {
               state.colorAlpha = _alpha * _targetHero.transform.effectsAlpha;
               concatMatrices(_assetAndSelfTransform,_targetHero.transform.location,state.matrix);
               _rootSprite.z = _targetHero.transform.location.tz + _selfOffsetZ;
            }
            else
            {
               state.colorAlpha = _alpha;
               _rootSprite.z = _selfOffsetZ;
            }
            if(_loop != null && rootClip != _loop && currentTime >= rootClip.timeLine.length)
            {
               currentTime = currentTime - rootClip.timeLine.length;
               rootClip = _loop;
               _skin.clip = _loop;
               _loop = null;
               events = null;
               playSoundsToEvent();
            }
            rootNode.setup(rootClip,state,currentTime,null,_skin);
            if(_targetHero)
            {
               _rootSprite.transformationMatrix = state.matrix;
            }
            else
            {
               _rootSprite.transformationMatrix = _assetAndSelfTransform;
            }
            if(events)
            {
               events.advanceFrame(currentTime);
            }
            if(_playOnce && currentTime >= rootClip.timeLine.length)
            {
               dispose();
            }
         }
      }
      
      override public function playSoundsToEvent() : void
      {
         if(!rootClip)
         {
            return;
         }
         _skin.useSoundsFromAsset(rootClip.resource,this);
      }
      
      protected function concatMatrices(param1:Matrix, param2:Matrix, param3:Matrix) : void
      {
         if(param1 == null)
         {
            param1 = _identityMatrix;
         }
         if(param2 == null)
         {
            param2 = _identityMatrix;
         }
         param3.a = param1.a * param2.a + param1.b * param2.c;
         param3.b = param1.a * param2.b + param1.b * param2.d;
         param3.c = param1.c * param2.a + param1.d * param2.c;
         param3.d = param1.c * param2.b + param1.d * param2.d;
         param3.tx = param1.tx * param2.a + param1.ty * param2.c + param2.tx;
         param3.ty = param1.tx * param2.b + param1.ty * param2.d + param2.ty;
      }
   }
}

package game.battle.view.hero
{
   import avmplus.getQualifiedClassName;
   import com.progrestar.common.util.assert;
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.State;
   import com.progrestar.framework.ares.events.ClipEventTimeline;
   import com.progrestar.framework.ares.extension.sounds.ClipSoundEvent;
   import com.progrestar.framework.ares.extension.sounds.IClipSoundEventHandler;
   import com.progrestar.framework.ares.starling.ClipSkin;
   import engine.core.animation.ZSortedSprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import game.battle.view.BattleSoundStarlingEventData;
   import game.battle.view.EffectGraphicsProvider;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class HeroAnimationRsx implements IClipSoundEventHandler
   {
      
      private static var playbackFps:Number = 60;
      
      private static const _rect:Rectangle = new Rectangle();
      
      private static const _matrix:Matrix = new Matrix();
       
      
      public const onAnimationComplete:Signal = new Signal();
      
      protected const customClipMapping:Dictionary = new Dictionary();
      
      protected var animationsMapping:Dictionary;
      
      protected var loopAnimationsMapping:Dictionary;
      
      protected var animationsMappingRevert:Dictionary;
      
      public const rootNode:HeroAnimationClipNode = new HeroAnimationClipNode(new ZSortedSprite());
      
      public const resultState:State = new State();
      
      private var assetDataProvider:HeroClipAssetDataProvider;
      
      private var currentClip:Clip;
      
      private var currentSkin:ClipSkin;
      
      private var state:State;
      
      private var mirrorState:State;
      
      private var currentEvents:ClipEventTimeline;
      
      private var currentFrame:int;
      
      private var currentTime:Number;
      
      private var loop:Boolean;
      
      private var _direction:int = 1;
      
      private var _assetScale:Number;
      
      private var _scale:Number;
      
      private var skinParts:Dictionary;
      
      private var muteSounds:Boolean;
      
      private var _idlePlaybackSpeed:Number = 1;
      
      private var _globalPlaybackSpeed:Number = 1;
      
      private var _runPlaybackSpeed:Number = 1;
      
      public function HeroAnimationRsx(param1:HeroClipAssetDataProvider, param2:Boolean)
      {
         animationsMapping = new Dictionary();
         loopAnimationsMapping = new Dictionary();
         animationsMappingRevert = new Dictionary();
         super();
         assert(param1);
         currentTime = 0;
         state = new State();
         mirrorState = new State();
         state.matrix = new Matrix();
         mirrorState.matrix = new Matrix();
         this.assetDataProvider = param1;
         this.scale = 1;
         this.muteSounds = param2;
         rootNode.weaponTransform.setMirrored(this.assetDataProvider.mirrored);
         initAnimations();
      }
      
      public function dispose() : void
      {
         if(assetDataProvider)
         {
            assetDataProvider.dropUsage();
         }
         rootNode.dispose();
         currentClip = null;
         currentEvents = null;
         currentSkin = null;
      }
      
      public function get graphics() : DisplayObject
      {
         return rootNode.graphics;
      }
      
      public function get complete() : Boolean
      {
         return currentTime >= currentClip.timeLine.length;
      }
      
      public function get looping() : Boolean
      {
         return loop;
      }
      
      public function get currentAnimation() : AnimationIdent
      {
         return animationsMappingRevert[currentClip];
      }
      
      public function get transformationMatrix() : Matrix
      {
         return _direction >= 0?state.matrix:mirrorState.matrix;
      }
      
      public function set direction(param1:int) : void
      {
         _direction = param1;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function get assetName() : String
      {
         return assetDataProvider.name;
      }
      
      public function get assetPrefix() : String
      {
         return assetDataProvider.prefix;
      }
      
      public function set scale(param1:Number) : void
      {
         if(_scale == param1)
         {
            return;
         }
         _scale = param1;
         if(assetDataProvider.mirrored)
         {
            var _loc2_:* = _scale * assetDataProvider.defaultScale;
            mirrorState.matrix.d = _loc2_;
            _loc2_ = _loc2_;
            mirrorState.matrix.a = _loc2_;
            state.matrix.d = _loc2_;
            state.matrix.a = -scale * assetDataProvider.defaultScale;
         }
         else
         {
            _loc2_ = scale * assetDataProvider.defaultScale;
            mirrorState.matrix.d = _loc2_;
            _loc2_ = _loc2_;
            state.matrix.d = _loc2_;
            state.matrix.a = _loc2_;
            mirrorState.matrix.a = -scale * assetDataProvider.defaultScale;
         }
      }
      
      public function get assetIsMirrored() : Boolean
      {
         return assetDataProvider.mirrored;
      }
      
      public function get scale() : Number
      {
         return _scale;
      }
      
      public function set idlePlaybackSpeed(param1:Number) : void
      {
         this._idlePlaybackSpeed = param1;
      }
      
      public function set globalPlaybackSpeed(param1:Number) : void
      {
         this._globalPlaybackSpeed = param1;
      }
      
      public function set runPlaybackSpeed(param1:Number) : void
      {
         this._runPlaybackSpeed = param1;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:* = null;
         if(currentClip)
         {
            rootNode.weaponTransform.advanceTime(param1);
            if(animationsMappingRevert[currentClip] == AnimationIdent.POSE)
            {
               param1 = param1 * _idlePlaybackSpeed;
            }
            _loc2_ = this.currentAnimation;
            if(_globalPlaybackSpeed != 0 && (currentAnimation == AnimationIdent.RUN || currentAnimation == AnimationIdent.IDLE || currentAnimation == AnimationIdent.POSE))
            {
               param1 = param1 * _globalPlaybackSpeed;
            }
            if(currentAnimation == AnimationIdent.RUN)
            {
               param1 = param1 * _runPlaybackSpeed;
            }
            currentTime = currentTime + param1 * playbackFps;
            if(currentTime >= currentClip.timeLine.length)
            {
               onAnimationComplete.dispatch();
               if(!currentClip)
               {
                  return;
               }
               if(loop)
               {
                  currentTime = currentTime - currentClip.timeLine.length;
                  if(loopAnimationsMapping[currentSkin])
                  {
                     selectAnimation(loopAnimationsMapping[currentSkin]);
                  }
               }
               else
               {
                  currentTime = currentClip.timeLine.length - 1;
               }
            }
            currentFrame = int(currentTime);
            if(currentEvents)
            {
               currentEvents.advanceFrame(currentFrame);
            }
            currentSkin.dropPreviousMarkers();
            rootNode.setup(currentClip,resultState,currentFrame,null,currentSkin);
         }
         rootNode.updateLayersState(resultState);
      }
      
      public function stop() : void
      {
         if(currentTime >= currentClip.timeLine.length && currentFrame < currentClip.timeLine.length - 1)
         {
            currentFrame = currentClip.timeLine.length - 1;
            if(currentEvents)
            {
               currentEvents.advanceFrame(currentFrame);
            }
            currentSkin.dropPreviousMarkers();
            rootNode.setup(currentClip,resultState,currentFrame,null,currentSkin);
         }
         currentClip = null;
         currentEvents = null;
      }
      
      public function setCurrentAnimation(param1:AnimationIdent, param2:Boolean) : void
      {
         if(rootNode && param1 && animationsMapping[param1])
         {
            currentTime = 0;
            currentFrame = 0;
            selectAnimation(animationsMapping[param1]);
            loop = param2;
            if(loopAnimationsMapping[currentSkin])
            {
               loop = true;
            }
         }
         else if(currentClip == null)
         {
            setCurrentAnimation(AnimationIdent.IDLE,param2);
         }
      }
      
      public function setCustomAnimation(param1:AnimationIdent, param2:String) : void
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = param2;
         var _loc3_:* = customClipMapping[_loc5_];
         if(_loc3_ === null)
         {
            return;
         }
         if(_loc3_ == undefined)
         {
            _loc6_ = getClipByName(_loc5_);
            if(!_loc6_)
            {
               customClipMapping[_loc5_] = null;
               return;
            }
            _loc4_ = assetDataProvider.createSkin(_loc6_);
            if(!muteSounds)
            {
               _loc4_.useSoundsFromAsset(assetDataProvider.soundAsset,this);
            }
            customClipMapping[_loc5_] = _loc4_;
         }
         else
         {
            _loc4_ = _loc3_;
            _loc6_ = _loc4_.clip;
         }
         currentTime = 0;
         currentFrame = 0;
         selectAnimation(_loc4_);
         loop = loopAnimationsMapping[currentSkin];
      }
      
      private function selectAnimation(param1:ClipSkin) : void
      {
         if(currentClip != null && param1 != null && param1.clip != null && animationsMappingRevert[currentClip] == AnimationIdent.RUN && animationsMappingRevert[param1.clip] == AnimationIdent.POSE && animationsMapping[AnimationIdent.RUN_END])
         {
            loopAnimationsMapping[animationsMapping[AnimationIdent.RUN_END]] = param1;
            param1 = animationsMapping[AnimationIdent.RUN_END];
         }
         currentSkin = param1;
         currentClip = param1.clip;
         rootNode.setClip(currentClip);
         currentEvents = currentSkin.events;
         if(skinParts)
         {
            var _loc4_:int = 0;
            var _loc3_:* = skinParts;
            for(var _loc2_ in skinParts)
            {
               currentSkin.applySkinPart(_loc2_,skinParts[_loc2_]);
            }
         }
      }
      
      public function getStateBounds(param1:AnimationIdent) : Rectangle
      {
         return !!animationsMapping[param1]?(animationsMapping[param1] as ClipSkin).clip.bounds:new Rectangle();
      }
      
      public function getAnimationDuration(param1:AnimationIdent) : Number
      {
         return !!animationsMapping[param1]?(animationsMapping[param1] as ClipSkin).clip.timeLine.length / playbackFps:NaN;
      }
      
      public function getMarkerPosition(param1:DisplayObjectContainer, param2:String, param3:Boolean) : Matrix
      {
         var _loc4_:* = null;
         if(currentSkin == null)
         {
            return null;
         }
         if(param3)
         {
            _loc4_ = currentSkin.getUpdatedMarkerDisplayObject(param2);
         }
         else
         {
            _loc4_ = currentSkin.getMarkerDisplayObject(param2);
         }
         if(_loc4_ && _loc4_.stage)
         {
            return _loc4_.getTransformationMatrix(param1,_matrix);
         }
         return null;
      }
      
      public function setMarkerContent(param1:String, param2:DisplayObject) : void
      {
         if(currentSkin != null)
         {
            if(!skinParts)
            {
               skinParts = new Dictionary();
            }
            skinParts[param1] = param2;
            currentSkin.applySkinPart(param1,param2);
         }
      }
      
      public function createEffectGraphicsProvider(param1:String) : EffectGraphicsProvider
      {
         return assetDataProvider.getEffectProvider(param1);
      }
      
      public function setWeaponRotation(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
         rootNode.weaponTransform.setRotation(param1,param2,param3,param4);
      }
      
      protected function initAnimations() : void
      {
         register(AnimationIdent.IDLE,"IDLE");
         register(AnimationIdent.RUN_END,"RUN_END");
         registerWithLoop(AnimationIdent.RUN,"RUN");
         register(AnimationIdent.STRAFE,"STRAFE");
         register(AnimationIdent.HURT,"HIT");
         registerWithLoop(AnimationIdent.DIE,"DEATH");
         registerWithLoop(AnimationIdent.WIN,"WIN");
         registerWithLoop(AnimationIdent.ATTACK,"ATTACK");
         registerWithLoop(AnimationIdent.ULT,"ULT");
         registerWithLoop(AnimationIdent.SKILL1,"SKILL1");
         registerWithLoop(AnimationIdent.SKILL2,"SKILL2");
         registerWithLoop(AnimationIdent.SKILL3,"SKILL3");
         registerWithLoop(AnimationIdent.POSE,"POSE");
      }
      
      private function registerWithLoop(param1:AnimationIdent, param2:String) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:Clip = register(param1,param2);
         if(!_loc5_)
         {
            _loc3_ = register(param1,param2 + "_LOOP");
            if(_loc3_)
            {
               animationsMappingRevert[_loc3_] = param1;
               loopAnimationsMapping[animationsMapping[param1]] = animationsMapping[param1];
            }
         }
         else
         {
            _loc3_ = getClipByName(param2 + "_LOOP");
            if(_loc3_)
            {
               _loc4_ = assetDataProvider.createSkin(_loc3_);
               animationsMappingRevert[_loc4_.clip] = param1;
               loopAnimationsMapping[animationsMapping[param1]] = _loc4_;
               loopAnimationsMapping[_loc4_] = _loc4_;
               if(!muteSounds)
               {
                  _loc4_.useSoundsFromAsset(assetDataProvider.soundAsset,this);
               }
            }
         }
      }
      
      private function register(param1:AnimationIdent, param2:String) : Clip
      {
         var _loc4_:Clip = getClipByName(param2);
         if(_loc4_ == null)
         {
            if(param2 != "IDLE")
            {
               register(param1,"IDLE");
            }
            else
            {
               trace(getQualifiedClassName(this),param2 + " animation not defined for hero");
            }
            return null;
         }
         var _loc3_:ClipSkin = assetDataProvider.createSkin(_loc4_);
         animationsMapping[param1] = _loc3_;
         if(!muteSounds)
         {
            _loc3_.useSoundsFromAsset(assetDataProvider.soundAsset,this);
         }
         animationsMappingRevert[_loc4_] = param1;
         return _loc4_;
      }
      
      private function getClipByName(param1:String) : Clip
      {
         return assetDataProvider.getClipByName(param1);
      }
      
      public function onSoundEvent(param1:ClipSoundEvent) : void
      {
         rootNode.graphics.dispatchEventWith("SOUND",true,BattleSoundStarlingEventData.create(param1,rootNode.graphics));
      }
   }
}

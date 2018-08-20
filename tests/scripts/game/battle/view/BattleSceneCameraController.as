package game.battle.view
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import game.battle.view.hero.HeroView;
   import idv.cjcat.signals.Signal;
   import starling.core.Starling;
   
   public class BattleSceneCameraController
   {
       
      
      public const cameraTransform:Matrix = new Matrix();
      
      public const signal_travelComplete:Signal = new Signal();
      
      private const cameraPosition:Point = new Point();
      
      private const battlePosition:Point = new Point();
      
      private var _cameraLockTimeLeft:Number = 0;
      
      private var _screenWidth:Number;
      
      private var _leftBorder:Number;
      
      private var _rightBorder:Number;
      
      private var _inExplicitMotion:Boolean = false;
      
      private var motion:CameraSineMotion;
      
      private var _doTrackHeroes:Boolean = false;
      
      private var heroesToTrack:Vector.<HeroView>;
      
      public function BattleSceneCameraController()
      {
         _screenWidth = Starling.current.stage.stageWidth;
         motion = new CameraSineMotion(cameraPosition);
         heroesToTrack = new Vector.<HeroView>();
         super();
      }
      
      public function get inMotion() : Boolean
      {
         return _inExplicitMotion;
      }
      
      public function set doTrackHeroes(param1:Boolean) : void
      {
         _doTrackHeroes = param1;
      }
      
      public function get motionTimeLeft() : Number
      {
         if(!_inExplicitMotion)
         {
            return 0;
         }
         return (_cameraLockTimeLeft > 0?_cameraLockTimeLeft:0) + motion.timeLeft;
      }
      
      public function moveToPosition(param1:Point, param2:Number, param3:Number = 0) : void
      {
         _inExplicitMotion = true;
         motion.start(param1,param2,param3);
      }
      
      public function setPosition(param1:Number = NaN, param2:Number = NaN) : void
      {
         if(_inExplicitMotion)
         {
            _inExplicitMotion = false;
            motion.interrupt();
         }
         if(param1 === param1)
         {
            cameraPosition.x = param1;
         }
         if(param2 === param2)
         {
            cameraPosition.y = param2;
         }
      }
      
      public function lockForDuration(param1:Number = 0) : void
      {
         _cameraLockTimeLeft = param1;
      }
      
      public function setCurrentBattlePosition(param1:Point, param2:Number, param3:Number) : void
      {
         battlePosition.x = param1.x;
         battlePosition.y = param1.y;
         var _loc4_:Number = (param2 + param3) * 0.5;
         _leftBorder = Math.min(_loc4_ - _screenWidth * 0.5,param2);
         _rightBorder = Math.max(_loc4_ + _screenWidth * 0.5,param3);
      }
      
      public function advanceTime(param1:Number) : void
      {
         if(_cameraLockTimeLeft > 0)
         {
            _cameraLockTimeLeft = _cameraLockTimeLeft - param1;
            if(_cameraLockTimeLeft < 0)
            {
               param1 = -_cameraLockTimeLeft;
               _cameraLockTimeLeft = 0;
            }
         }
         if(_cameraLockTimeLeft <= 0)
         {
            if(_inExplicitMotion)
            {
               motion.advanceTime(param1);
               if(motion.completed)
               {
                  _inExplicitMotion = false;
                  signal_travelComplete.dispatch();
                  signal_travelComplete.clear();
               }
            }
            else if(_doTrackHeroes)
            {
               trackHeroes(param1);
            }
         }
         cameraTransform.tx = battlePosition.x - cameraPosition.x;
         cameraTransform.ty = battlePosition.y - cameraPosition.y;
      }
      
      public function addHeroToTracking(param1:HeroView) : void
      {
         if(heroesToTrack.indexOf(param1) == -1)
         {
            heroesToTrack[heroesToTrack.length] = param1;
         }
      }
      
      public function removeHeroFromTracking(param1:HeroView) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = heroesToTrack.indexOf(param1);
         if(_loc3_ != -1)
         {
            _loc2_ = heroesToTrack.length - 1;
            if(_loc3_ != _loc2_)
            {
               heroesToTrack[_loc3_] = heroesToTrack[_loc2_];
            }
            heroesToTrack.length = _loc2_;
         }
      }
      
      protected function trackHeroes(param1:Number) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}

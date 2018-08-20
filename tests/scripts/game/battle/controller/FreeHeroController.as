package game.battle.controller
{
   import flash.geom.Rectangle;
   import game.assets.HeroRsxAssetDisposable;
   import game.battle.view.BattleScene;
   import game.data.storage.hero.UnitDescription;
   import game.view.gui.QuestHeroAdviceValueObject;
   import game.view.hero.FreeHero;
   import game.view.hero.HomeScreenFreeHero;
   import idv.cjcat.signals.Signal;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class FreeHeroController implements IAnimatable
   {
      
      public static const X_CENTER:Number = 450;
      
      public static const SCREEN_SCROLL_POTENTIAL:Number = 0.05;
      
      public static var DEFAULT_TIME_RATE:Number = 1;
      
      public static const screenLeftEdgeWithoutChestX:Number = 130;
      
      public static const screenLeftEdgeWithChestX:Number = 320;
      
      public static const screenRightEdgeWithObstacleX:Number = 680.0;
      
      public static const screenRightEdgeWithoutObstacleX:Number = 850.0;
      
      public static const chestYBottomPosition:Number = 150;
      
      public static const minHeroesYDistance:Number = 20;
       
      
      private var active:Boolean = true;
      
      private var scene:BattleScene;
      
      private var heroes:Vector.<FreeHero>;
      
      private var heroesTarget:Number;
      
      private var cameraTarget:Number;
      
      private var currentScreen:int;
      
      private var maxScreens:int;
      
      private var screenWidth:Number;
      
      private var width:Number;
      
      private var walkZone:Rectangle;
      
      private var _hasAnObstacleOnTheRight:Boolean = true;
      
      private var _signal_heroesReady:Signal;
      
      public function FreeHeroController(param1:Number, param2:Number)
      {
         _signal_heroesReady = new Signal();
         super();
         this.width = param1;
         this.screenWidth = param2;
         walkZone = new Rectangle(320,50,getRightHeroesBorder() - 320,100);
         scene = new BattleScene();
         heroes = new Vector.<FreeHero>();
         Starling.current.stage.addEventListener("touch",onTouch);
         maxScreens = 1;
         cameraTarget = 0;
         heroesTarget = 0;
      }
      
      public function dispose() : void
      {
         Starling.current.stage.removeEventListener("touch",onTouch);
      }
      
      public function get signal_heroesReady() : Signal
      {
         return _signal_heroesReady;
      }
      
      public function set hasAnObstacleOnTheRight(param1:Boolean) : void
      {
         if(_hasAnObstacleOnTheRight != param1)
         {
            _hasAnObstacleOnTheRight = param1;
            walkZone.width = getRightHeroesBorder() - walkZone.x;
         }
      }
      
      public function get graphics() : DisplayObjectContainer
      {
         return scene.graphics;
      }
      
      public function adviceAdd(param1:QuestHeroAdviceValueObject) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(heroes.length)
         {
            _loc2_ = heroes.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if((heroes[_loc3_] as HomeScreenFreeHero).desc == param1.hero)
               {
                  (heroes[_loc3_] as HomeScreenFreeHero).addAdvice(param1);
               }
               else
               {
                  (heroes[_loc3_] as HomeScreenFreeHero).clearAdvice();
               }
               _loc3_++;
            }
         }
      }
      
      public function adviceClear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(heroes.length)
         {
            _loc1_ = heroes.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               (heroes[_loc2_] as HomeScreenFreeHero).clearAdvice();
               _loc2_++;
            }
         }
      }
      
      public function initialize(param1:Vector.<HeroRsxAssetDisposable>, param2:Vector.<UnitDescription>) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
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
      
      protected function updateCameraPosition(param1:Number) : void
      {
         scene.graphics.x = scene.graphics.x * (1 - 0.05) + -cameraTarget * 0.05;
      }
      
      protected function setCameraPosition(param1:Number) : void
      {
         heroesTarget = param1;
         var _loc3_:Number = 150;
         var _loc2_:* = 0;
         if(currentScreen < maxScreens && param1 > currentScreen * screenWidth - _loc3_ + screenWidth)
         {
            currentScreen = Number(currentScreen) + 1;
         }
         else if(currentScreen > 0 && param1 < currentScreen * screenWidth + _loc3_)
         {
            currentScreen = Number(currentScreen) - 1;
         }
         else
         {
            _loc2_ = Number((param1 - (currentScreen + 0.5) * screenWidth) * 0.25);
         }
         var _loc4_:* = Number(currentScreen * screenWidth + _loc2_);
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ > width - screenWidth)
         {
            _loc4_ = Number(width - screenWidth);
         }
         var _loc6_:Number = 200;
         var _loc5_:Number = 200;
         if(Math.abs(cameraTarget - _loc4_) > 400)
         {
            heroesTarget = heroesTarget * 0.5 + 0.5 * (_loc4_ + screenWidth * 0.5);
         }
         else if(heroesTarget < _loc6_)
         {
            heroesTarget = _loc6_;
         }
         else if(heroesTarget > width - _loc5_)
         {
            heroesTarget = width - _loc5_;
         }
         cameraTarget = _loc4_;
      }
      
      protected function expandNormalizedPosition(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = -1 + 2 * param1 / width;
         _loc3_ = (_loc3_ > 0?1:-1) * Math.pow(Math.abs(_loc3_),param2);
         return 0.5 + _loc3_ * 0.5;
      }
      
      private function getRightHeroesBorder() : Number
      {
         if(_hasAnObstacleOnTheRight)
         {
            return 680;
         }
         return 850;
      }
      
      private function sortHeroByX(param1:FreeHero, param2:FreeHero) : int
      {
         return param1.position.x - param2.position.x;
      }
      
      private function sortHeroByY(param1:FreeHero, param2:FreeHero) : int
      {
         return param1.position.y - param2.position.y;
      }
      
      private function removeHero(param1:FreeHero) : void
      {
         scene.removeHero(param1.view);
         param1.dispose();
      }
      
      private function spreadHeroesByY(param1:Vector.<FreeHero>, param2:Number, param3:Number) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(param1.currentTarget as DisplayObject,"ended");
         if(_loc2_ && scene && scene.graphics.stage)
         {
            onClick(-scene.graphics.x + _loc2_.globalX,_loc2_.globalY);
         }
      }
      
      private function onClick(param1:Number, param2:Number) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function destruct() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = heroes.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            removeHero(heroes[_loc2_]);
            _loc2_++;
         }
         heroes.length = 0;
      }
   }
}
